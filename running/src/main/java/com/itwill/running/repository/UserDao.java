package com.itwill.running.repository;

import com.itwill.running.domain.User;

public interface UserDao {
	User selectByUserId(String userId);		// 유저 아이디 조회
	User selectByNickname(String nickname);	// 유저 닉네임 조회
	User selectByEmail(String email);		// 이메일 조회
	User selectByPhoneNumber(String phonenumber); //휴대전화번호 조회
	
	int insertUser(User user); 				// 유저 생성
	User selectByUserIdAndPassword(User user);  // 로그인 (아이디, 패스워드로)
	int updateByImgId(User user);			// 유저 이미지 아이디 업데이트
	
}
