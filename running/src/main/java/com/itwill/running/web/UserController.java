package com.itwill.running.web;

import java.awt.Image;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwill.running.domain.Gimages;
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
	
	// 유저 상세 정보 페이지
	@GetMapping({"/details", "/modify"})
	public void profile(String userId, Model model, HttpSession session) {
		
		// 현재 세션의 유저아이디 조회
		String signedInUserId = (String) session.getAttribute("signedInUserId");
		User user = userService.selectByUserId(signedInUserId);
		log.debug("유저 아이디: {}",user);
		
		int selectedImgId = user.getImgId();
		// 이미지 이름을 가져옴
		uimagesService.selectUserImageByUserId(signedInUserId);
		
		model.addAttribute("user", user);
		model.addAttribute("selectedImgId", selectedImgId);
	}
	
	
	
	
	//  ---------------------------------- 중복체크 ---------------------------------------// 
	
	// 사용자 아이디 중복체크
	@GetMapping("/checkuserid")
	@ResponseBody
	public ResponseEntity<String> checkUserId(@RequestParam String userId) {
		log.debug("checkUsername(username={})", userId);
		boolean result = userService.checkUserId(userId);
		
		return result ? ResponseEntity.ok("Y") : ResponseEntity.ok("N");
	}
	// 사용자 닉네임 중복체크
	@GetMapping("/checknickname")
	@ResponseBody
	public ResponseEntity<String> checkNickname(@RequestParam String nickname) {
		log.debug("checkNickname(nickname={})", nickname);
		boolean result = userService.checkNickname(nickname);
		
		return result ? ResponseEntity.ok("Y") : ResponseEntity.ok("N");
	}
	// 이메일 중복체크
	@GetMapping("/checkemail")
	@ResponseBody
	public ResponseEntity<String> checkEmail(@RequestParam String email){
		log.debug("checkEmail(email={})",email);
		boolean result = userService.checkEmail(email);
		
		return result ? ResponseEntity.ok("Y") : ResponseEntity.ok("N");
	}
	// 휴대전화번호 중복체크
	@GetMapping("/checkphonenumber")
	@ResponseBody
	public ResponseEntity<String> checkPhoneNumber(@RequestParam String phonenumber){
		log.debug("checkPhoneNumber(phonenumber={})",phonenumber);
		boolean result = userService.checkPhoneNumber(phonenumber);
		
		return result ? ResponseEntity.ok("Y") : ResponseEntity.ok("N");
	}
}
