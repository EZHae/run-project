package com.itwill.running.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.domain.Gpost;
import com.itwill.running.service.GpostService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/gposts")
public class G_PostController {
	private final GpostService gPostService;

	@GetMapping("/details")
	public void details(@RequestParam("id") Integer id, Model model, HttpSession session) {
		// JSP로 데이터를 넘기기 위해 Model을 사용
		
					// 세션에서 유저 아이디 가져옴
					String userId = (String) session.getAttribute("signedInUserId");
					
					Gpost userPost = gPostService.read(id);
					String postUserId = userPost.getUserId();
					
					// 세션에 조회기록이 있는지 확인하기
					String viewkey = "viewGpost" + id + userId;
					Object hasView = session.getAttribute(viewkey);
					
				    if (hasView == null || ! userId.equals(postUserId)) {
				        gPostService.viewCountPost(id); // 조회수 증가
				        session.setAttribute(viewkey, true); // 조회 기록 저장
				    }
					
					Gpost gPost = gPostService.read(id);
					
					model.addAttribute("gPost",gPost);
	}

	// 포스트 목록 출력하는 메서드
	@GetMapping("/list")
	public void list(Model model) {

		List<Gpost> list = gPostService.read();

		model.addAttribute("gPosts", list);
	}
	
	
}
