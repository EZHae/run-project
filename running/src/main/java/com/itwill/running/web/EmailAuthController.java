package com.itwill.running.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.service.EmailAuthService;
import com.itwill.running.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
//이메일 전송 후 인증 컨트롤러
public class EmailAuthController {
	private final UserService userService;
	private final EmailAuthService emailService;

	@GetMapping("/verify")
	public String verifyEmail(@RequestParam("token") String token) {
		boolean isVerified = userService.verifyUser(token);

		if (isVerified) {
			return "user/signin"; // 인증 완료 페이지
		} else {
			return "authcheck/failed"; // 실패 페이지
		}
	}
	
	@GetMapping("/authcheck/failed")
	public void failed() {
		
	}
}
