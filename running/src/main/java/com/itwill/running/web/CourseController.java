package com.itwill.running.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.domain.Course;
import com.itwill.running.dto.CourseCreateDto;
import com.itwill.running.dto.CourseSearchDto;
import com.itwill.running.dto.CourseUpdateDto;
import com.itwill.running.service.CourseService;

import jakarta.servlet.http.HttpServletRequest;
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
	public String search(Model model, CourseSearchDto dto) {
		log.debug("CourseController::search()");
		
		List<Course> courses = courseService.read(dto);
		
		model.addAttribute("courses", courses);
		
		return "/course/list";
	}
	
	@GetMapping({ "/details", "/update" })
	public void details(@RequestParam Integer id, Model model, HttpSession session, HttpServletRequest request) {
		log.debug("CourseController::details()");
		
		Course course = courseService.read(id);
		
		Object signedInUserId = session.getAttribute("signedInUserId");
		String userId = course.getUserId();
		
		if (signedInUserId != null) {
			
			signedInUserId = signedInUserId.toString();
			
			if (!signedInUserId.equals(userId)) {
				courseService.viewCount(id);	
			}
		}
		log.debug("signedInUserId={}", signedInUserId);
		
		List<String> likeUserIds = courseService.readLikeUserId(id);

		model.addAttribute("likeUserIds", likeUserIds);
		model.addAttribute("course", course);
	}
	
	@PostMapping("/update")
	public String update(CourseUpdateDto dto) {
		log.debug("CourseController::update()");
		
		courseService.update(dto);
		
		String url = "/course/details?id=" + dto.getId();
	    return "redirect:" + url;
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam Integer id) {
		log.debug("CourseController::delete()");
		
		courseService.delete(id);
		
	    return "redirect:/course/list";
	}
	
	@GetMapping("/like")
	public String likeCourse(@RequestParam Integer id, HttpSession session, Model model) {
	    log.debug("CourseController::likeCourse()");
	    
	    String signedInUserId = session.getAttribute("signedInUserId").toString();

	    courseService.likeCount(id);
    	courseService.createCourseLike(id, signedInUserId);
	    String url = "/course/details?id=" + id;
	    
	    return "redirect:" + url;
	}
	
	//추가
	@GetMapping("/create")
	public void create(HttpSession session, Model model) {
	    log.debug("GET create()");

	}

	//추가
	@PostMapping("/create")
	public String createCourse(CourseCreateDto dto, HttpSession session) {
	    log.debug("POST createCourse(course = {})", dto);

	    int result = courseService.createCourse(dto);
	    
	    log.debug("insertId={}", result);
	    
	    String url = "/course/details?id=" + result;
	    return "redirect:" + url;
	}


}
