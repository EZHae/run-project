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

	@GetMapping("/list") // 페이징처리에 관해서 정확한 url 맵핑을 하기위해 void가 아닌 String으로
	public String list(@RequestParam(defaultValue = "0") int offset, // offset : 데이터를 가져올 시작 위치
			@RequestParam(defaultValue = "10") int limit, // limit : 한 번에 가져올 데이터의 수
			Model model
			) {
		log.debug("CourseController::list()");

		
		// 페이징된 코스 목록 가져오기
		// read() => readAllPageWithOffset(ofset, limit)
		List<Course> courses = courseService.readAllPageWithOffset(offset, limit);
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

	// 검색 컨트롤러 - 페이징 처리도 함께
	@GetMapping("/search")
	public String search(@RequestParam(defaultValue = "10") int limit,
						 @RequestParam(defaultValue = "0") int offset, 
						 Model model,
						 HttpServletRequest request,
						 CourseSearchDto dto) {
		log.debug("CourseController::search() | offset:{}, limit:{}, keyword::{}",offset,limit,dto.getKeyword());

		if (dto.getKeyword() == null) {
	        dto.setKeyword("");
	    }
		
		// 페이징 적용하여 검색된 결과 가져오기
		List<Course> courses = courseService.readPageWithOffset(dto, offset, limit);
		
		
		// 검색된 전체 데이터 개수 가져오기
		int totalPosts = courseService.countPostsBySearch(dto);
		int totalPages = (int) Math.ceil((double) totalPosts / limit);
		log.debug("검색된 전체 게시글 수: {}, 총 페이지 수: {}", totalPosts, totalPages);
		
		
		model.addAttribute("totalPosts", totalPosts); //게시글 전체 수
		model.addAttribute("totalPages", totalPages); // 페이지 수 
		model.addAttribute("courses", courses);
		model.addAttribute("offset", offset); //데이터를 가져올 시작 위치
		model.addAttribute("limit", limit); //한번에 가져올 데이터 갯수
		model.addAttribute("category",dto.getCategory()); // 추천순 or 리뷰순
		model.addAttribute("keyword",dto.getKeyword()); //keyword 입력
		model.addAttribute("order",dto.getOrder()); //조회수순 or 좋아요순
		
		String search = request.getRequestURI();
		model.addAttribute("type", search);
		
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

	@GetMapping("/create")
	public void create(HttpSession session, Model model) {
		log.debug("GET create()");

	}

	@PostMapping("/create")
	public String createCourse(CourseCreateDto dto, HttpSession session) {
		log.debug("POST createCourse(course = {})", dto);

		int result = courseService.createCourse(dto);

		log.debug("insertId={}", result);

		String url = "/course/details?id=" + result;
		return "redirect:" + url;
	}

}