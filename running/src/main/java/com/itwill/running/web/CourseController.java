package com.itwill.running.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.domain.Course;
import com.itwill.running.service.CourseService;

import jakarta.servlet.http.HttpSession;
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
	public void details(Model model, @RequestParam Integer id, HttpSession session) {
		log.debug("CourseController::details()");
		
		Course course = courseService.read(id);
		
		Object signedInUser = session.getAttribute("signedInUser");
		String userId = course.getUserId();
		
		if (signedInUser != null) {
			signedInUser = signedInUser.toString();
			
			if (!signedInUser.equals(userId)) {
				courseService.viewCount(id);	
			}
		}
		
		log.debug("signedInUser={}", signedInUser);

		model.addAttribute("course", course);
	}
	
	//추가 
	@PostMapping("/details")
	public String likeCourse(@RequestParam Integer id, HttpSession session, Model model) {
	    log.debug("CourseController::likeCourse()");

	    String signedInUser = (String) session.getAttribute("signedInUser");

	    if (signedInUser != null) {
	        Course course = courseService.read(id);
	        String userId = course.getUserId();

	        List<String> likeUserIds = courseService.readLikeUserId(id);

	        if (!signedInUser.equals(userId) && !likeUserIds.contains(signedInUser)) {
	            courseService.likeCount(id);
	            log.debug("User {} liked Course {}", signedInUser, id);
	        } 
	    } 

	    // 현재 페이지로 다시 머무르게.
	    Course course = courseService.read(id);
	    model.addAttribute("course", course);
	    
	    return "/course/details";
	}

}
