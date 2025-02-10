package com.itwill.running.web;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.itwill.running.domain.Park;
import com.itwill.running.domain.Team;
import com.itwill.running.dto.TApplicationItemDto;
import com.itwill.running.dto.TMemberCreateDto;
import com.itwill.running.dto.TMemberItemDto;
import com.itwill.running.dto.TeamCreateDto;
import com.itwill.running.dto.TeamItemDto;
import com.itwill.running.dto.TeamSearchDto;
import com.itwill.running.dto.TeamUpdateDto;
import com.itwill.running.dto.UserItemDto;
import com.itwill.running.service.ParkService;
import com.itwill.running.service.TApplicationService;
import com.itwill.running.service.TMemberService;
import com.itwill.running.service.TeamService;
import com.itwill.running.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor

/*
 * 이지해
@RequestMapping("/teampage")
public class TeamController {

	private final TeamService teamService;
	
	@GetMapping("/list")
	public void list(Model model) {
		log.debug("TeamController::Get_list()");
		
		List<Team> teams = teamService.read();
		
		model.addAttribute("teams", teams);
	}
	
	@GetMapping("/{teamId}")
	public String details(@PathVariable Integer teamId, Model model) {
		log.debug("TeamController::Get_details()");
		
		Team team = teamService.read(teamId);
		
		model.addAttribute("team", team);
		
		return "teampage/details";
	}
	*/

// 최호철
@RequestMapping("/team")
public class TeamController {
	private final TeamService teamService;
	private final TMemberService tmemService;
	private final TApplicationService tappService;
	private final UserService userService;
	private final ParkService parkService;	

	@GetMapping("/list")
	public void getAllTeams(Model model, @RequestParam(value= "status", defaultValue = "open")String status) {
		List<TeamItemDto> teams = "closed".equals(status) ? teamService.readClosedTeams() : teamService.readOpenTeams();
		log.debug("모집 상태 목록={}",teams);
		
		model.addAttribute("teams",teams);
		model.addAttribute("status", status);
	}
	
	@GetMapping("/search")
	public String searchTeams(TeamSearchDto dto, Model model) {
		List<Team> teams=teamService.searchTeams(dto);
		model.addAttribute("teams",teams);
		return "/team/list";
	}

	@GetMapping({ "/details", "/update" })
	public void recruitTeam(@RequestParam("teamid") Integer teamId, Model model, HttpSession session) {
		TeamItemDto team = teamService.readByTeamid(teamId);
		model.addAttribute(team);

		List<TMemberItemDto> tmems = tmemService.readAllByTeamId(teamId);
		model.addAttribute("tmembers", tmems);

		List<TApplicationItemDto> tapplist = tappService.readAllApplications(teamId);
		model.addAttribute("tappList", tapplist);

		Park park = parkService.selectParkByParkId(team.getParkId());
		model.addAttribute(park);

		String userId = (String) session.getAttribute("signedInUserId");
		if (userId != null) {
			UserItemDto currentUser = userService.selectByUserId(userId);
			model.addAttribute("user", currentUser);
		}

	}

	@PostMapping("/update")
	public String updateTeam(TeamUpdateDto dto, HttpServletRequest request, @RequestParam("file") MultipartFile file)
			throws IllegalStateException, IOException {
		String originalFilename = file.getOriginalFilename();
		TeamItemDto ogTeam = teamService.readByTeamid(dto.getTeamId());
		if (originalFilename != "") {
			// 배너이미지를 수정할 때
			String uuidFilename = FileController.getNewFileNameAndSaveFile(file);
			dto.setImagePath(
					request.getContextPath() + "/api/uploadTeamImg/" + URLEncoder.encode(uuidFilename, "UTF-8"));
			dto.setUniqName(uuidFilename);

			// 기존배너이미지 삭제
			FileController.deleteFileFromDirectory("C:\\uploadTeamImg\\" + ogTeam.getUniqName());

		} else {
			// 기존배너를 유지할 때
			log.debug("ogTeam={}", ogTeam);
			dto.setImagePath(ogTeam.getImagePath());
			dto.setUniqName(ogTeam.getUniqName());
		}

		teamService.updateTeam(dto);

		return "redirect:/team/details?teamid=" + dto.getTeamId();
	}

	@GetMapping("/api/count")
	public ResponseEntity<Integer> isTeamCreatable(@RequestParam("teamname") String teamName) {
		int result = teamService.selectCountByTeamName(teamName);
		return ResponseEntity.ok(result);
	}

	@GetMapping("/create")
	public void createTeam(HttpSession session) {
		String userId = (String) session.getAttribute("signedInUserId");

	}

	@PostMapping("/create")
	public String createNewTeam(HttpServletRequest request, TeamCreateDto dto, HttpSession session,
			@RequestParam("file") MultipartFile file) throws IllegalStateException, IOException {

		String userId = (String) session.getAttribute("signedInUserId");
		dto.setUserId(userId);

		String uuidFilename = FileController.getNewFileNameAndSaveFile(file);

		dto.setImagePath(request.getContextPath() + "/api/uploadTeamImg/" + URLEncoder.encode(uuidFilename, "UTF-8"));
		dto.setUniqName(uuidFilename);

		// 팀생성
		teamService.createNewTeam(dto);

		// 생성된 팀의 teamId 가져오기
		Integer teamId = teamService.findTeamId(dto.getTeamName(), userId);

		// t_members테이블에 회장추가하는 메서드로 업데이트
		TMemberCreateDto leader = new TMemberCreateDto();
		leader.setUserId(userId);
		leader.setLeaderCheck(1);
		leader.setTeamId(teamId);
		log.debug("리더객체={}", leader);
		tmemService.createNewTMember(leader);

		return "redirect:/team/list";
	}

	@DeleteMapping("/delete")
	public ResponseEntity<Integer> deleteTeam(@RequestParam("teamid") Integer teamId) {
		// 배너이미지 c드라이브에서 삭제
		TeamItemDto ogTeam = teamService.readByTeamid(teamId);
		FileController.deleteFileFromDirectory("C:\\uploadTeamImg\\" + ogTeam.getUniqName());
		int result = teamService.deleteTeam(teamId);
		return ResponseEntity.ok(result);
	}

}
