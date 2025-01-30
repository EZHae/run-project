package com.itwill.running.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwill.running.domain.Gimages;
import com.itwill.running.domain.Gpost;
import com.itwill.running.dto.GpostCategoryDto;
import com.itwill.running.dto.GpostCreateDto;
import com.itwill.running.dto.GpostUpdateDto;
import com.itwill.running.service.GimagesService;
import com.itwill.running.service.GpostService;
import java.util.UUID;
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
	public void list(Model model) {
		
		// 기본값을 자유게시판 목록으로 선택
		GpostCategoryDto dto = new GpostCategoryDto();
		dto.setCategory(0);
		
		List<Gpost> list = gPostService.readByCategorySearch(dto);
		
		model.addAttribute("gPosts",list);
	}
	
	@GetMapping("/category")
	public String list(GpostCategoryDto dto, Model model, HttpSession session) {

	    log.debug("GpostCategoryDto: {}", dto);
	    
	    //현재 카테고리 값을 저장
	    session.setAttribute("currentCategory", dto.getCategory());
	    
	    //카테고리 게시글 목록을 조회
	    List<Gpost> list = gPostService.readByCategorySearch(dto);
	    
	    
	    model.addAttribute("gPosts", list);

	    return "/gpost/list";
	}
	
	// 포스트 작성을 출력하는 메서드
	@GetMapping("/create")
	public void create() {}
	
	// 포스트 작성 후 이동 
	@PostMapping("/create")
	public String create(GpostCreateDto dto, HttpSession session,
						 Model model, @RequestParam(value = "file", required = false) MultipartFile file) throws Exception {
		
		// 기본 세션 설정 - 후에 수정할것!!
	    // 세션에서 닉네임 가져오기
		String userId = (String) session.getAttribute("signedInUserId");
	    String nickname = (String) session.getAttribute("signedInUserName");
	    
	    // DTO에 닉네임 설정
	    dto.setUserId(userId);
	    dto.setNickname(nickname);
	    log.debug("nickname={}", nickname);
	    
	    // 포스트 저장
	    Integer postId = gPostService.create(dto);
	    
	    log.debug("포스트 생성 완료: postId={}", postId);
	    
	    // 글 작성 후 이미지와 연결
	    if (!file.isEmpty()) {
	    	gimagesService.saveImage(file, postId);  // postId 추가
	    }
	    
		log.debug("result = {}, create = {}",postId,dto);
		
		return "redirect:/gpost/list";
	}
	
	
	
	
	// 상세보기 및 수정 페이지를 처리하는 메서드
		@GetMapping({"/details","/modify"})
		public void details(@RequestParam Integer id, Model model, HttpSession session) {
			// JSP로 데이터를 넘기기 위해 Model을 사용
			
			// 세션에서 유저 아이디 가져옴
			String userId = (String) session.getAttribute("signedInUserId");
			
			Gpost gPost = gPostService.read(id);
			String postUserId = gPost.getUserId();
			
			// 세션에 조회기록이 있는지 확인하기
			String viewkey = "viewGpost" + id + userId;
			Object hasView = session.getAttribute(viewkey);
			
		    if (hasView == null || ! userId.equals(postUserId)) {
		        gPostService.viewCountPost(id); // 조회수 증가
		        session.setAttribute(viewkey, true); // 조회 기록 세션에 저장
		    }
			
		    // 이미지 이름을 가져옴
		    List<Gimages> gImages = gimagesService.getImgesByPostId(id);
		    
		    model.addAttribute("gPost",gPost);
		    model.addAttribute("gImages", gImages);
		}
		
	@PostMapping("/update")
	public String update(GpostUpdateDto dto) {
		
		gPostService.updatePost(dto);
		log.debug("update = {}", dto);
		return "redirect:/gpost/details?id=" + dto.getId();
	}
	
	
	@GetMapping("/delete")
	public String delete(@RequestParam Integer id, HttpSession session) {
		
		gPostService.deletePost(id);
		log.debug("delete = {}", id);
		
		// 현재 세션의 카테고리 값을 가져옴
		Integer category = (Integer) session.getAttribute("currentCategory");
		
		session.setAttribute("currentCategory", category);
		
		return "redirect:/gpost/category?category=" + category;
	}

}
