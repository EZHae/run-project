package com.itwill.running.web;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwill.running.domain.TCalendar;
import com.itwill.running.dto.TCalendarCreateDto;
import com.itwill.running.dto.TCalendarItemDto;
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

	// 일정 목록 보기
	@GetMapping("/list")
	public String list(@PathVariable Integer teamId, Model model, HttpSession session) {
		log.debug("list() - teamId: {}", teamId);

		// 팀의 일정 목록 가져오기.
		List<TCalendar> tCalendars = tCalendarService.read(teamId);

		// 날짜 포맷터 설정
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

		// 각 일정의 dateTime을 포맷팅하여 새로운 리스트 생성
		List<TCalendarItemDto> tCalendarItems = tCalendars.stream().map(calendar -> {
			TCalendarItemDto item = new TCalendarItemDto();
			item.setId(calendar.getId());
			item.setTitle(calendar.getTitle());
			item.setNickname(calendar.getNickname());
			item.setContent(calendar.getContent());
			item.setCurrentNum(calendar.getCurrentNum());
			item.setMaxNum(calendar.getMaxNum());
			item.setFormattedDateTime(calendar.getDateTime().format(formatter));
			return item;
		}).collect(Collectors.toList());
		
		// 현재 로그인한 사용자 정보 가져오기
	    String userId = (String) session.getAttribute("signedInUserId");
	    
	    // 팀장
	    String teamLeaderId = tMemberService.getTeamLeaderId(teamId);
	    boolean isTeamLeader = userId != null && userId.equals(teamLeaderId);
	    model.addAttribute("isTeamLeader", isTeamLeader);


		// 뷰에 전달할 데이터를 추가
		model.addAttribute("tCalendars", tCalendarItems);
		model.addAttribute("teamId", teamId);

		return "/tcalendar/list";
	}

	// 일정 상세 보기
	@GetMapping("/details")
	public String detail(@PathVariable Integer teamId, @RequestParam Integer calendarId, Model model,
			HttpServletRequest request) {
		log.debug("details() - teamId: {}, calendarId: {}", teamId, calendarId);

		TCalendar tCalendar = tCalendarService.read(calendarId, teamId);
		model.addAttribute("tCalendar", tCalendar);
		model.addAttribute("teamId", teamId);

		LocalDateTime dateTime = tCalendar.getDateTime();
		// 원하는 포맷 지정
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd HH-mm");
		// 포맷 적용
		String formattedDate = dateTime.format(formatter);
		model.addAttribute("dateTime", formattedDate);

		List<TCalendarMemberItemDto> tCalendarMember = tCalendarMemberService.getTCalendarMembers(teamId, calendarId);
		model.addAttribute("tCalendarMember", tCalendarMember);

		List<TMemberItemDto> tMember = tMemberService.readAllByTeamId(teamId);
		model.addAttribute("tMember", tMember);

		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("signedInUserId");
		model.addAttribute("userId", userId);

		 // 팀장 확인
	    String teamLeaderId = tMemberService.getTeamLeaderId(teamId);
	    boolean isTeamLeader = userId != null && userId.equals(teamLeaderId);
	    model.addAttribute("isTeamLeader", isTeamLeader);
	    
		// 신청 여부 확인
		boolean isApplied = tCalendarMemberService.isApplied(calendarId, userId, teamId);
		model.addAttribute("isApplied", isApplied);

		// 현재인원수가 최대인원수에 도달했는지 확인
		boolean isFull = tCalendar.getCurrentNum() >= tCalendar.getMaxNum();
		model.addAttribute("isFull", isFull);

		// 일정이 현재 시간보다 이전인지 확인
		boolean isExpired = tCalendar.getDateTime().isBefore(LocalDateTime.now());
		model.addAttribute("isExpired", isExpired);

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
	public String create(@PathVariable Integer teamId, @ModelAttribute TCalendarCreateDto dto,
			HttpServletRequest request) {
		log.debug("create() - teamId: {}, dto: {}", teamId, dto);

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

		// DTO에 사용자 정보 설정
		dto.setUserId(userId);

		// 사용자 닉네임 가져오기
		String nickname = (String) session.getAttribute("signedInUserNickname");
		dto.setNickname(nickname);

		// 서비스에 DTO를 전달하여 일정 생성 및 생성된 ID를 반환받음
		int generatedId = tCalendarService.create(dto);

		// 생성된 일정의 ID를 사용하여 리다이렉트
		return "redirect:/teampage/" + teamId + "/tcalendar/details?calendarId=" + generatedId;

	}

	//신청 및 신청 취소
	@PostMapping("/apply")
	@ResponseBody
	public Map<String, Object> apply(@PathVariable Integer teamId,
	                                 @RequestParam Integer calendarId,
	                                 HttpSession session) {
	    String userId = (String) session.getAttribute("signedInUserId");
	    String nickname = (String) session.getAttribute("signedInUserNickname");
	    
	    Map<String, Object> result = new HashMap<>();

	    log.debug("신청 처리 시작 - teamId: {}, calendarId: {}, userId: {}", teamId, calendarId, userId);

	    // 팀 멤버인지 확인
	    boolean isTeamMember = tMemberService.isTeamMember(teamId, userId);
	    log.debug("isTeamMember 결과 - isTeamMember: {}", isTeamMember);

	    if (!isTeamMember) {
	        result.put("status", "not_member");
	        result.put("message", "팀에 먼저 가입한 후에 신청해주세요.");
	        return result;
	    }

	    // 이미 신청한 상태인지 확인
	    boolean isApplied = tCalendarMemberService.isApplied(calendarId, userId, teamId);
	    log.debug("isApplied 결과 - isApplied: {}", isApplied);

	    try {
	        if (!isApplied) {
	            // 모집이 완료되었는지 확인
	            TCalendar tCalendar = tCalendarService.read(calendarId, teamId);
	            log.debug("TCalendar 읽기 결과 - tCalendar: {}", tCalendar);

	            if (tCalendar.getCurrentNum() >= tCalendar.getMaxNum()) {
	                result.put("status", "full");
	                result.put("message", "모집이 완료되었습니다.");
	                return result;
	            }
	            // 신청 처리
	            tCalendarService.apply(calendarId, teamId, userId, nickname);
	            log.debug("신청 처리 완료");
	            result.put("status", "applied");
	            result.put("message", "신청이 완료되었습니다.");
	        } else {
	            // 신청 취소 처리
	            tCalendarService.cancelApplication(calendarId, teamId, userId);
	            log.debug("신청 취소 처리 완료");
	            result.put("status", "cancelled");
	            result.put("message", "신청이 취소되었습니다.");
	        }
	    } catch (Exception e) {
	        log.error("신청 처리 중 오류 발생 - teamId: {}, calendarId: {}, userId: {}", teamId, calendarId, userId, e);
	        result.put("status", "error");
	        result.put("message", "처리 중 오류가 발생했습니다.");
	    }

	    return result;
	}

	
	// 현재 인원 수와 최대 인원 수 조회
    @GetMapping("/currentMaxNum")
    public Map<String, Integer> getCurrentAndMaxNum(@PathVariable Integer teamId,
                                                    @RequestParam Integer calendarId) {
        Map<String, Integer> result = tCalendarService.getCurrentAndMaxNum(calendarId, teamId);
        return result;
    }
    
    // 일정 신청자 목록 보기
    @GetMapping("/members")
    public String viewMembers(@PathVariable Integer teamId,
                              @RequestParam Integer calendarId,
                              Model model,
                              HttpSession session) {
        log.debug("viewMembers() - teamId: {}, calendarId: {}", teamId, calendarId);

        // 현재 로그인한 사용자 정보 가져오기
        String userId = (String) session.getAttribute("signedInUserId");
        String nickname = (String) session.getAttribute("signedInUserNickname");

        // 팀 멤버인지 확인
        boolean isTeamMember = tMemberService.isTeamMember(teamId, userId);
//        if (!isTeamMember) {
//            // 접근 권한이 없는 경우 처리
//            return "redirect:/accessDenied";
//        }

        // 신청자 목록 가져오기
        List<TCalendarMemberItemDto> tCalendarMembers = tCalendarMemberService.getTCalendarMembers(teamId, calendarId);
        model.addAttribute("tCalendarMembers", tCalendarMembers);

        // 모델에 필요한 데이터 추가
        model.addAttribute("teamId", teamId);
        model.addAttribute("calendarId", calendarId);
        model.addAttribute("nickname", nickname);
        model.addAttribute("userId", userId);

        return "/tcalendar/members";
    }


}
