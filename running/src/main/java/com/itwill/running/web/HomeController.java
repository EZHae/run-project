package com.itwill.running.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	@GetMapping("/")
	public String home(HttpSession session) {
		log.debug("home()");
		
		if (session.getAttribute("signedInUser") == null) {
			session.setAttribute("signedInUser", "user1");
			log.debug("signedInUser={}", session.getAttribute("signedInUser").toString()) ;
		} else {
			log.debug("signedInUser={}", session.getAttribute("signedInUser").toString());
		}
		
		return "home";
	}
}
