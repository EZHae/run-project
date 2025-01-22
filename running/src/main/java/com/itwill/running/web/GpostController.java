package com.itwill.running.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.domain.Gpost;
import com.itwill.running.dto.GpostCreateDto;
import com.itwill.running.dto.GpostUpdateDto;
import com.itwill.running.service.GpostService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/gpost") // 요청 시작 주소 
public class GpostController {
	
	private final GpostService gPostService;
	
	// 포스트 목록 출력하는 메서드
	@GetMapping("/list")
	public void list(Model model) {
		
		List<Gpost> list = gPostService.read();
		
		model.addAttribute("gPosts",list);
	}
	
	// 포스트 작성을 출력하는 메서드
	@GetMapping("/create")
	public void create() {}
	
	// 포스트 작성 후 이동 
	@PostMapping("/create")
	public String create(GpostCreateDto dto, HttpSession session) {
		// 기본 세션 설정 - 후에 수정할것!!
	    String nickname = (String) session.getAttribute("signedInUserName");
	    dto.setNickname(nickname); // 세션 값을 DTO에 강제로 설정
	    // 세션 값 강제로 설정
	    if (dto.getNickname() == null) {
	        dto.setNickname((String) session.getAttribute("signedInUserName"));
	    }
	    // -----------------------------------
	    
	    log.debug("nickname={}",nickname);
	    
		int result = gPostService.create(dto);
		log.debug("result = {}, create = {}",result,dto);
		
		return "redirect:/gpost/list";
	}
	
	
	// 상세보기 및 수정 페이지를 처리하는 메서드
	@GetMapping({"/details","/modify"})
	public void details(@RequestParam Integer id, Model model) {
		// JSP로 데이터를 넘기기 위해 Model을 사용
		
		gPostService.viewCountPost(id);
		Gpost gPost = gPostService.read(id);
		
		model.addAttribute("gPost",gPost);
	}
	
	@PostMapping("/update")
	public String update(GpostUpdateDto dto) {
		
		gPostService.updatePost(dto);
		log.debug("update = {}", dto);
		return "redirect:/gpost/details?id=" + dto.getId();
	}
	
	
	@GetMapping("/delete")
	public String delete(@RequestParam Integer id) {
		
		gPostService.deletePost(id);
		log.debug("delete = {}", id);
		
		return "redirect:/gpost/list";
	}

}
