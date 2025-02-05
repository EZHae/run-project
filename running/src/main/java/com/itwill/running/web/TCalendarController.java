package com.itwill.running.web;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.itwill.running.domain.TCalendar;
import com.itwill.running.dto.TCalendarCreateDto;
import com.itwill.running.dto.TCalendarMemberItemDto;
import com.itwill.running.dto.TMemberItemDto;
import com.itwill.running.dto.UserItemDto;
import com.itwill.running.service.TCalendarMemberService;
import com.itwill.running.service.TCalendarService;
import com.itwill.running.service.TMemberService;
import com.itwill.running.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

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
    private final UserService userService; // UserService 주입

    // 일정 목록 보기
    @GetMapping("/list")
    public String list(@PathVariable Integer teamId, Model model) {
        log.debug("list() - teamId: {}", teamId);

        // 팀의 일정 목록 가져오기
        List<TCalendar> tCalendars = tCalendarService.read(teamId);

        // 뷰에 전달할 데이터 추가
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

        List<TMemberItemDto> tMember = tMemberService.readAllByTeamId(teamId);
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
    public String create(
        @PathVariable Integer teamId,
        @ModelAttribute TCalendarCreateDto dto,
        HttpServletRequest request
    ) {
        log.debug("create() - teamId: {}, dto: {}", teamId, dto);

        try {
            String date = request.getParameter("date"); // 예: "2023-10-28"
            String time = request.getParameter("time"); // 예: "오전 10:30"

            // 날짜와 시간 포맷터 설정
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("a h:mm", Locale.KOREAN);

            // 날짜와 시간 파싱
            LocalDate parsedDate = LocalDate.parse(date, dateFormatter);
            LocalTime parsedTime = LocalTime.parse(time, timeFormatter);

            // 날짜와 시간을 결합하여 LocalDateTime 생성
            LocalDateTime dateTime = LocalDateTime.of(parsedDate, parsedTime);

            // DTO에 설정
            dto.setDateTime(dateTime);
            dto.setTeamId(teamId);

            // 현재 로그인한 사용자 정보 가져오기
            HttpSession session = request.getSession();
            String userId = (String) session.getAttribute("signedInUserId");
            if (userId != null) {
                // 사용자 정보 조회
                UserItemDto currentUser = userService.selectByUserId(userId);

                if (currentUser != null) {
                    // DTO에 사용자 정보 설정
                    dto.setUserId(currentUser.getUserId());
                    dto.setNickname(currentUser.getNickname());
                } else {
                    // 사용자 정보를 찾을 수 없는 경우 처리
                    return "redirect:/login";
                }
            } else {
                // 로그인되지 않은 경우 처리
                return "redirect:/login";
            }

            // 서비스에 DTO를 전달하여 일정 생성 및 생성된 ID를 반환받음
            int generatedId = tCalendarService.create(dto);

            // 생성된 일정의 ID를 사용하여 리다이렉트
            return "redirect:/teampage/" + teamId + "/tcalendar/details?calendarId=" + generatedId;

        } catch (Exception e) {
            log.error("일정 생성 중 오류 발생", e);
            // 에러 페이지로 리다이렉트하거나 에러 메시지를 보여줄 수 있습니다.
            return "redirect:/error";
        }
    }
}
