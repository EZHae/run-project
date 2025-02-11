package com.itwill.running.web;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.itwill.running.domain.Gimages;
import com.itwill.running.domain.Gpost;
import com.itwill.running.dto.GpostCategoryDto;
import com.itwill.running.dto.GpostCreateDto;
import com.itwill.running.dto.GpostUpdateDto;
import com.itwill.running.service.GimagesService;
import com.itwill.running.service.GpostService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/gpost") // 요청 시작 주소 
public class GpostController {
	
	private final GpostService gPostService;
	private final GimagesService gimagesService;
	
	// 포스트 목록 출력하는 메서드
	@GetMapping("/list")
	public String list(@RequestParam(defaultValue = "0") int offset, // offset : 데이터를 가져올 시작 위치
			@RequestParam(defaultValue = "10") int limit,
			GpostCategoryDto dto,
			Model model) {

	    log.debug("GpostCategoryDto: {}", dto);
	    
	    
	    //카테고리 게시글 목록을 조회
	    List<Gpost> list = gPostService.readPageWithOffset(dto, offset, limit);
	    
	    // 전체 게시글 개수 조회 (페이징을 위한 totalCount)
	    int totalPosts = gPostService.countPostsBySearch(dto);
	    int totalPages = (int) Math.ceil((double) totalPosts / limit);
	    
	    model.addAttribute("totalPosts", totalPosts);
	    model.addAttribute("totalPages", totalPages);
	    model.addAttribute("offset", offset);
	    model.addAttribute("limit", limit);
	    model.addAttribute("gPosts", list);
	    model.addAttribute("category", dto.getCategory()); // 추가
	    model.addAttribute("keyword", dto.getKeyword());
	    model.addAttribute("search", dto.getSearch());
	    model.addAttribute("gpostCategoryDto", dto);
	    
	    return "/gpost/list";
	}
	
	// 검색 컨트롤러 - 페이징 처리도 함께
	@GetMapping("/search")
	public String search(@RequestParam(defaultValue = "10") int limit,
						 @RequestParam(defaultValue = "0") int offset, 
						 Model model,
						 HttpServletRequest request,
						 GpostCategoryDto dto) {
		log.debug("CourseController::search() | offset:{}, limit:{}, keyword::{}",offset,limit,dto.getKeyword());

	    // 검색 값이 없는 경우 기본값 설정
		if (dto.getSearch() == null) dto.setSearch("");  
	    if (dto.getKeyword() == null) dto.setKeyword("");
		
		// 페이징 적용하여 검색된 결과 가져오기
		List<Gpost> posts = gPostService.readPageWithOffset(dto, offset, limit);
		
		
		// 검색된 전체 데이터 개수 가져오기
		int totalPosts = gPostService.countPostsBySearch(dto);
		int totalPages = (int) Math.ceil((double) totalPosts / limit);
		log.debug("검색된 전체 게시글 수: {}, 총 페이지 수: {}", totalPosts, totalPages);
		
		
		model.addAttribute("totalPosts", totalPosts); //게시글 전체 수
		model.addAttribute("totalPages", totalPages); // 페이지 수 
		model.addAttribute("posts", posts);
		model.addAttribute("offset", offset); //데이터를 가져올 시작 위치	
		model.addAttribute("limit", limit); //한번에 가져올 데이터 갯수
		model.addAttribute("category",dto.getCategory()); // 추천순 or 리뷰순
		model.addAttribute("keyword",dto.getKeyword()); //keyword 입력
	    model.addAttribute("search", dto.getSearch());
	    model.addAttribute("gpostCategoryDto", dto);
		String search = request.getRequestURI();
		model.addAttribute("type", search);
		
		return "/gpost/list";
	}
	
	// 포스트 작성을 출력하는 메서드
	@GetMapping("/create")
	public void create() {}
	
	// 포스트 작성 후 이동 
	@PostMapping("/create")
	public String create(GpostCreateDto dto, HttpSession session,
						 Model model, @RequestParam(value = "file", required = false) MultipartFile[] files) throws Exception {
		
	    // 포스트 저장
	    Integer postId = gPostService.create(dto);
	    
	    log.debug("포스트 생성 완료: postId={}", postId);
	    
	    // 글 작성 후 이미지와 연결
		if (files != null && files.length > 0) {
			List<String> imagesUrls = gimagesService.saveImages(files, postId); // postId 추가
			log.debug("업로드 완료, urls : {}", imagesUrls);
		}
	    
		log.debug("result = {}, create = {}",postId,dto);
		
		// 세션에 저장된 현재 카테고리 값 가져오기
		Integer currentCategory = (Integer) session.getAttribute("currentCategory");
		// 만약 세션에 없으면, DTO나 기본값을 사용할 수 없음.
		if(currentCategory == null) {
			currentCategory = dto.getCategory(); // dto에 카테고리가 포함되어 있으면
		}
		
		// 해당 카테고리로 리다이렉트
		return "redirect:/gpost/list?category=" + currentCategory;
	}
	
	
	
	
	// 상세보기 및 수정 페이지를 처리하는 메서드
	@GetMapping({"/details","/modify"})
	public String details(@RequestParam("id") Integer id, Model model, HttpSession session, HttpServletRequest request) {
		// /modify만 필터링
		String requestURI = request.getRequestURI();
		log.debug("요청주소: {}", requestURI);
		if (requestURI.equals("/running/gpost/modify")) {
			// 로그인아이디와 작성자아이디 체크
			String signedInUserId = session.getAttribute("signedInUserId").toString();
			String userId = gPostService.read(id).getUserId();
			if (signedInUserId == null || !signedInUserId.equals(userId)) {
				model.addAttribute("errorcode", "일반 게시글 수정");
				model.addAttribute("errordetail", 1);
				return "nopermission";
			}
		}
		
		// JSP로 데이터를 넘기기 위해 Model을 사용

		// 게시글 정보 가져오기
		Gpost gPost = gPostService.read(id);
		
		Object userId =  session.getAttribute("signedInUserId");
		String postUserId = gPost.getUserId();
		
		// 세션에 조회기록이 있는지 확인하기
		String viewkey = "viewGpost" + id + userId;
		Object hasView = session.getAttribute(viewkey);
		
	    if (hasView == null || (userId != null && !userId.equals(postUserId))) {
	        gPostService.viewCountPost(id); // 조회수 증가
	        session.setAttribute(viewkey, true); // 조회 기록 세션에 저장
	    }
		
	    // 이미지 이름을 가져옴
	    List<Gimages> gImages = gimagesService.getImgesByPostId(id);
	    
	    model.addAttribute("gPost",gPost);
	    model.addAttribute("gImages", gImages);
	    
	    return requestURI.equals("/running/gpost/modify") ? "gpost/modify" : "gpost/details";
	}
		
	@PostMapping("/update")
	public String update(GpostUpdateDto dto, String deletedImages, Model model,
			@RequestParam(value = "file", required = false) MultipartFile[] newFiles, HttpSession session) throws Exception {
		// 로그인아이디와 작성자아이디 체크
		String signedInUserId = session.getAttribute("signedInUserId").toString();
		String userId = gPostService.read(dto.getId()).getUserId();
		if (!signedInUserId.equals(userId)) {
			model.addAttribute("errorcode", "일반 게시글 수정");
			model.addAttribute("errordetail", 1);
			return "nopermission";
		}
		
		// 게시글 업데이트
		gPostService.updatePost(dto);
		log.debug("update = {}", dto);
		
		// 삭제할 이미지 ID 처리 (쉼표로 구분된 문자열)
		if(deletedImages != null && !deletedImages.trim().isEmpty()) {
			
			List<Integer> imageIds = Arrays.stream(deletedImages.split(","))
					.filter(s -> !s.trim().isEmpty())
					.map(String::trim)
					.map(Integer::valueOf)
					.collect(Collectors.toList());
			
			gimagesService.deleteImages(imageIds);
			log.debug("삭제할 이미지 ID 목록: {}", imageIds);
		}
		
		if(newFiles != null && newFiles.length > 0) {
			for(MultipartFile file : newFiles) {
				if(!file.isEmpty()) {
					gimagesService.saveImage(file, dto.getId());
					log.debug("업데이트 된 파일 : {}",file);
				}
			}
		}
		
		return "redirect:/gpost/details?id=" + dto.getId();
	}
	
	
	@GetMapping("/delete")
	public String delete(@RequestParam Integer id, HttpSession session, Model model) {
		// 로그인아이디와 작성자아이디 체크
		String signedInUserId = session.getAttribute("signedInUserId").toString();
		String userId = gPostService.read(id).getUserId();
		if (!signedInUserId.equals(userId)) {
			model.addAttribute("errorcode", "일반 게시글 삭제");
			model.addAttribute("errordetail", 1);
			return "nopermission";
		}
		
		// 현재 카테고리 값을 가져옴
		Gpost deletedPost = gPostService.read(id); // 삭제할 포스트
		Integer category = deletedPost.getCategory(); // 삭제할 포스트의 카테고리
		
		// 포스트 삭제
		gPostService.deletePost(id);
		log.debug("delete = {}", id);
		
		return "redirect:/gpost/list?category=" + category;
	}

}
