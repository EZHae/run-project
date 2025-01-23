package com.itwill.running.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	@GetMapping("")
	public String home(HttpSession session) {
		log.debug("home::doGet");
		
		if (session.getAttribute("signedInUserName") == null || session.getAttribute("signedInUserId") == null) {
			session.setAttribute("signedInUserId", "user1");
	        session.setAttribute("signedInUserName", "nick123");
	         
	         log.debug("signedInUserName={}",session.getAttribute("signedInUserName").toString()) ;
	         log.debug("signedInUserId={}",session.getAttribute("signedInUserId").toString()) ;
	      } else {
	         log.debug("signedInUser={}", session.getAttribute("signedInUserName").toString());
	      }
		return "home";
	}
}
