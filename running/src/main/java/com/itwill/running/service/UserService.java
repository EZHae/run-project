package com.itwill.running.service;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.User;
import com.itwill.running.repository.UserDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService {
	
	private final UserDao userDao;
	
	public User selectByUserId(String userId) {
		log.debug("selectByUserId(UserId={})", userId);
		User user = userDao.selectByUserId(userId);
		
		return user;
	}
}