package com.itwill.running.repository;

import com.itwill.running.domain.User;

public interface UserDao {
	User selectByUserId(String userId);
	int insertUser(User user); 				// 유저 생성
	User selectByUserIdAndPassword(User user);  // 로그인 (아이디, 패스워드로)
	int updateByImgId(User user);			// 유저 이미지 아이디 업데이트
	
}
