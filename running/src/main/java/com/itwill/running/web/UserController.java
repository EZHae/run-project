package com.itwill.running.web;

import java.awt.Image;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.domain.UImages;
import com.itwill.running.domain.User;
import com.itwill.running.dto.UserSignInDto;
import com.itwill.running.dto.UserSignUpDto;
import com.itwill.running.service.UImagesService;
import com.itwill.running.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {
	
	private final UserService userService;
	private final UImagesService uimagesService;
	
	// 로그아웃 처리
	@GetMapping("/signout")
	public String signOut(HttpSession session) {  // 디스패쳐 서블릿이 리퀘스트를 통해서 세션을 찾고 세션 객체를 넘겨줌.
		log.debug("로그아웃: {}",session);
		
		// 로그아웃 
		session.removeAttribute("signedInUserId");
		session.invalidate();
		
		// 로그아웃후 페이지 이동
		return "redirect:/";
	}
	
	// 로그인 페이지 이동
	@GetMapping("/signin")
	public void signIn() {
	}
	// 로그인 처리
	@PostMapping("/signin")
	public String signIn(UserSignInDto dto, @RequestParam(name = "target", defaultValue = "") String target, HttpSession session) throws UnsupportedEncodingException {
		
		User user = userService.read(dto); 
		
		// 로그인 후 페이지로 이동
		String targetPage = null;
		if(user != null) {
			
			// 로그인 사용자 정보를 세션에 저장
			session.setAttribute("signedInUserId",user.getUserId());
			// 로그인할때 signedInUser와 동일한 userId를 검색하고 그 User 객체의 nickname도 세션에 저장
			session.getAttribute("signedInUserId").toString();
			String nickname = user.getNickname();
			session.setAttribute("signedInUserNickname", nickname);
			
			// 유저의 프로필 이미지 가져오기
	        UImages userImage = uimagesService.selectUserImageByUserId(user.getUserId());
	        if (userImage != null) {
	            // 브라우저에서 접근 가능한 URL 경로 저장
	            session.setAttribute("signedInUserImgPath", "/image/view/" + userImage.getId());
	        }
	        
			log.debug("signedInUserId={}", session.getAttribute("signedInUserId").toString());
			log.debug("signedInUserNickname={}", nickname);
			
			targetPage = target.equals("") ? "/" : target;
		} else { // 로그인 실패 시 다시 로그인 페이지로 이동
			
			targetPage = "/user/signin?result=f&target=" + URLEncoder.encode(target, "UTF-8");
		}
		
		return "redirect:" + targetPage;
	}
	
	// 회원가입 페이지 이동
	@GetMapping("/signup")
	public void signUp() {
	}
	// 회원가입 처리
	@PostMapping("/signup")
	public String signUp(UserSignUpDto dto) {
		userService.createUser(dto);
		
		return "redirect:/user/signin";
	}
	
	
}
