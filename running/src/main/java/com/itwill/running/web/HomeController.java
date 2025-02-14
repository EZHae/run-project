package com.itwill.running.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.domain.Course;
import com.itwill.running.domain.Gpost;
import com.itwill.running.domain.Team;
import com.itwill.running.dto.GpostCategoryDto;
import com.itwill.running.service.CourseService;
import com.itwill.running.service.GpostService;
import com.itwill.running.service.TeamService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class HomeController {
	
	private final CourseService courseService;
	private final TeamService teamService;
	private final GpostService gpostService;
	
	@GetMapping("/")
	public String home(Model model) {
		log.debug("home()");
		//카테고리 게시글 목록을 조회
	    List<Course> recentCourses  = courseService.readRecentCourses();
	    List<Team> recentTeams = teamService.selectTeamNameByTeamId();
	    List<Gpost> recentGPost = gpostService.readNewPostById();
	    
	    model.addAttribute("courses", recentCourses);
	    model.addAttribute("teams", recentTeams);
		model.addAttribute("gposts",recentGPost);
	    
		return "home";
	}
}