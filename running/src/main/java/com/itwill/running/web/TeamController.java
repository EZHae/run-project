package com.itwill.running.web;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.domain.Team;
import com.itwill.running.domain.User;
import com.itwill.running.dto.GCommentCreateDto;
import com.itwill.running.dto.TApplicationItemDto;
import com.itwill.running.dto.TMemberItemDto;
import com.itwill.running.dto.TeamItemDto;
import com.itwill.running.dto.UserItemDto;
import com.itwill.running.service.CourseService;
import com.itwill.running.service.ParkService;
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
@RequestMapping("/team")
public class TeamController {
	private final TeamService teamService;
	private final TMemberService tmemService;
	private final TApplicationService tappService;
	private final UserService userService;
	private final ParkService parkService;
	
	@GetMapping("/list")
	public void getAllTeams(Model model){
		List<TeamItemDto> teams=teamService.readAllTeams();
		log.debug("teams={}",teams);
		model.addAttribute(teams);
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
			UserItemDto currentUser=userService.selectByUserId(userId);
			model.addAttribute("user",currentUser);
		}
		
	}
	
	@GetMapping("/create")      
	public void createTeam(Model model) {
		
	}
	
	
	
}
