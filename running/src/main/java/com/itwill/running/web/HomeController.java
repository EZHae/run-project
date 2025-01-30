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
	
	private final UserDao userDao;
	
	@GetMapping("/")
	public String home(HttpSession session) {
		log.debug("home()");
		
		if (session.getAttribute("signedInUser") == null) {
			session.setAttribute("signedInUser", "admin1");
			
			// 로그인할때 signedInUser와 동일한 userId를 검색하고 그 User 객체의 nickname도 세션에 저장
			String userId = session.getAttribute("signedInUser").toString();
			User user = userDao.selectByUserId(userId);
			String nickname = user.getNickname();
			session.setAttribute("nickname", nickname);
			
			log.debug("signedInUser={}", session.getAttribute("signedInUser").toString());
			log.debug("nickname={}", nickname);
		} else {
			log.debug("signedInUser={}", session.getAttribute("signedInUser").toString());
			
		}
		return "home";
	}
}
