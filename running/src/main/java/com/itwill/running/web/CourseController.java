package com.itwill.running.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.domain.Course;
import com.itwill.running.service.CourseService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/course")
public class CourseController {

	private final CourseService courseService;
	
	@GetMapping("/list")
	public void list(Model model) {
		log.debug("CourseController::list()");
		
		List<Course> courses = courseService.read();
		
		model.addAttribute("courses", courses);
	}
	
	@GetMapping("/search")
	public String search(Model model, @RequestParam Integer category, @RequestParam String order, @RequestParam String keyword) {
		log.debug("CourseController::search()");
		
		List<Course> courses = courseService.read(category, order, keyword);
		
		model.addAttribute("courses", courses);
		
		return "/course/list";
	}
	
	@GetMapping({ "/details", "/update" })
	public void details(Model model, @RequestParam Integer id) {
		log.debug("CourseController::details()");
		
		Course course = courseService.read(id);
		
		model.addAttribute("course", course);
	}
}
