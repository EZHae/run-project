package com.itwill.running.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.service.EmailAuthService;
import com.itwill.running.service.ParkService;
import com.itwill.running.service.TApplicationService;
import com.itwill.running.service.TMemberService;
import com.itwill.running.service.TeamService;
import com.itwill.running.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller

//이메일 전송 후 인증 컨트롤러
public class EmailAuthController {
	private UserService userService;
	private EmailAuthService emailService;

//	@GetMapping("/verify")
//	public String verifyEmail(@RequestParam("token") String token) {
//		boolean isVerified = userService.verifyUser(token);
//
//		if (isVerified) {
//			return "email_verified"; // 인증 완료 페이지
//		} else {
//			return "invalid_token"; // 실패 페이지
//		}
//	}
}
