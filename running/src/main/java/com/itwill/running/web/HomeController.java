package com.itwill.running.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwill.running.domain.User;
import com.itwill.running.repository.UserDao;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
public class HomeController {
	
	@GetMapping("/")
	public String home() {
		log.debug("home()");
		
		return "home";
	}
}
