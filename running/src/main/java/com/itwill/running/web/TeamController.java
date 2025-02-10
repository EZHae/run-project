package com.itwill.running.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.domain.User;
import com.itwill.running.dto.TApplicationItemDto;
import com.itwill.running.dto.TMemberItemDto;
import com.itwill.running.dto.TeamItemDto;
import com.itwill.running.service.TApplicationService;
import com.itwill.running.service.TMemberService;
import com.itwill.running.service.TeamService;
import com.itwill.running.service.UserService;

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
	
	@GetMapping("/list")
	public void getTeams(@RequestParam(value= "status", defaultValue = "open")String status, Model model) {
		List<TeamItemDto> teams = "closed".equals(status) ? teamService.readClosedTeams() : teamService.readOpenTeams();
		log.debug("모집 상태 목록={}",teams);
		
		model.addAttribute("teams",teams);
		model.addAttribute("status", status);
		
	}
	
	
	@GetMapping("/details")
	public void recruitTeam(@RequestParam("teamid") Integer teamId, Model model, HttpSession session){
		TeamItemDto team=teamService.readByTeamid(teamId);
		model.addAttribute(team); 
		
		List<TMemberItemDto> tmems=tmemService.readAllByTeamId(teamId);
		model.addAttribute("tmembers", tmems);
		
		List<TApplicationItemDto> tapplist=tappService.readAllApplications(teamId);
		model.addAttribute("tappList", tapplist);
		
		String userId=(String) session.getAttribute("signedInUserId");
		if(userId!=null) {
			User currentUser= userService.selectByUserId(userId);
			model.addAttribute("user",currentUser);
		}
		
	}
	
	@GetMapping("/create")
	public void createTeam() {
		
	}

}
