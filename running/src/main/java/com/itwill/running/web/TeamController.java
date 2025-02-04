package com.itwill.running.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.domain.Team;
import com.itwill.running.service.TeamService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
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
}
