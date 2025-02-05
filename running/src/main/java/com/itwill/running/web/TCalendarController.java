package com.itwill.running.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.domain.TCalendar;
import com.itwill.running.dto.TCalendarCreateDto;
import com.itwill.running.dto.TCalendarMemberItemDto;
import com.itwill.running.dto.TMemberItemDto;
import com.itwill.running.service.TCalendarMemberService;
import com.itwill.running.service.TCalendarService;
import com.itwill.running.service.TMemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/teampage/{teamId}/tcalendar") // 요청 시작 주소
public class TCalendarController {
	
	private final TCalendarService tCalendarService;
	private final TCalendarMemberService tCalendarMemberService;
	private final TMemberService tMemberService;
	
    // 일정 목록 보기
    @GetMapping("/list")
    public String list(@PathVariable Integer teamId, Model model) {
        log.debug("list() - teamId: {}", teamId);

        // 팀의 일정 목록 가져오기.
        List<TCalendar> tCalendars = tCalendarService.read(teamId);

        // 뷰에 전달할 데이터를 추가
        model.addAttribute("tCalendars", tCalendars);
        model.addAttribute("teamId", teamId);

        return "/tcalendar/list";
    }
    
    // 일정 상세 보기
    @GetMapping("/details")
    public String detail(@PathVariable Integer teamId, @RequestParam Integer calendarId, Model model) {
        log.debug("details() - teamId: {}, calendarId: {}", teamId, calendarId);

        TCalendar tCalendar = tCalendarService.read(calendarId, teamId);
        model.addAttribute("tCalendar", tCalendar);
        model.addAttribute("teamId", teamId);
        
        List<TCalendarMemberItemDto> tCalendarMember = tCalendarMemberService.getTCalendarMembers(teamId, calendarId);
        model.addAttribute("tCalendarMember", tCalendarMember);
        
        List <TMemberItemDto> tMember = tMemberService.readAllByTeamId(teamId);
        model.addAttribute("tMember", tMember);
        
        return "/tcalendar/details"; 
    }

    // 일정 작성 폼
    @GetMapping("/create")
    public String createForm(@PathVariable Integer teamId, Model model) {
        log.debug("createForm() - teamId: {}", teamId);

        model.addAttribute("teamId", teamId);

        return "/tcalendar/create"; 
    }

    // 일정 새글 작성 처리
    @PostMapping("/create")
    public String create(@PathVariable Integer teamId, @ModelAttribute TCalendarCreateDto dto) {
        log.debug("create() - teamId: {}, dto: {}", teamId, dto);

        tCalendarService.create(dto);
        
        return "redirect:/teampage/" + teamId + "/tcalendar/details?calendarId=" + dto.getId() ;
        
	}
}
