package com.itwill.running.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.domain.Course;
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
	 
//	@GetMapping("/list")
//	public void list(Model model) {
//		log.debug("CourseController::list()");
//		
//		List<Course> courses = courseService.readPageWithOffset(offset, limit);
//		model.addAttribute("courses", courses);
//	}
	//수정
	@GetMapping("/list") //페이징처리에 관해서 정확한 url 맵핑을 하기위해 void가 아닌 String으로
	public String list(@RequestParam(defaultValue = "0") int offset, //offset : 데이터를 가져올 시작 위치
	                   @RequestParam(defaultValue = "10") int limit, //limit : 한 번에 가져올 데이터의 수
	                   Model model) {
	    log.debug("CourseController::list()");

	    // 페이징된 코스 목록 가져오기
	    List<Course> courses = courseService.readPageWithOffset(offset, limit);
	    model.addAttribute("courses", courses);

	    // 총 게시글 수 가져오기
	    int totalPosts = courseService.countPosts();
	    
	    int totalPages = (int) Math.ceil((double) totalPosts / limit);
	    model.addAttribute("totalPosts", totalPosts);
	    model.addAttribute("totalPages", totalPages);

	    model.addAttribute("offset", offset);
	    model.addAttribute("limit", limit);

	    return "/course/list"; 
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
		
		Object signedInUser = session.getAttribute("signedInUser");
		String userId = course.getUserId();
		
		if (signedInUser != null) {
			
			signedInUser = signedInUser.toString();
			
			/* "/update"에서 이 위의 코드가 필요해서 mapping에 "/update"가 있지만, 
			 * "/update"에서 접근 했을 때에 조회수가 증가 하는 것을 방지 하기 위하기 위하여 
			 * [request.getRequestURI().equals("/details")]("/details"에서만 접근했을 때) 조건 추가 */
			if (request.getRequestURI().equals("/details") && !signedInUser.equals(userId)) {
				courseService.viewCount(id);	
			}
		}
		log.debug("signedInUser={}", signedInUser);
		
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
	    
	    String signedInUser = session.getAttribute("signedInUser").toString();

	    courseService.likeCount(id);
    	courseService.createCourseLike(id, signedInUser);
	    String url = "/course/details?id=" + id;
	    
	    return "redirect:" + url;
	}
	

	@GetMapping("/create")
	public void create(HttpSession session, Model model) {
	    log.debug("GET create()");

	}


	@PostMapping("/create")
	public String createCourse(Course course, HttpSession session) {
	    log.debug("POST createCourse(course = {})", course);

	    courseService.createCourse(course);
	    
	    int result = course.getId();
	    log.debug("insertId={}", result);
	    
	    String url = "/course/details?id=" + result;
	    return "redirect:" + url;
	}
	

}
