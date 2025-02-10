package com.itwill.running.repository;

import org.apache.ibatis.annotations.Param;

import com.itwill.running.domain.User;
import com.itwill.running.dto.UserUpdateDto;
import com.itwill.running.dto.UserVerificationUpdateDto;

public interface UserDao {
	User selectByUserId(String userId);		// 유저 아이디 조회
	User selectByNickname(String nickname);	// 유저 닉네임 조회
	User selectByEmail(String email);		// 이메일 조회
	User selectByPhoneNumber(String phonenumber); //휴대전화번호 조회
	User findByVerificationToken(String token);
	int insertUser(User user); 				// 유저 생성
	User selectByUserIdAndPassword(User user);  // 로그인 (아이디, 패스워드로)
	int updateByImgId(User user);			// 유저 이미지 아이디 업데이트
	int updateAccessTime(String userId);	// 유저 최근 접속 시간 업데이트
	int updateUser(UserUpdateDto dto);				// 유저 정보 수정 업데이트
	int deleteUser(String userId);				// 유저 삭제

	void updateByImgId(String userId, int imgId);
	int selectImgIdByUserId(String userId);		
	Integer updateUserByPassword(@Param("userId") String userId, @Param("password") String password); // 유저 비밀번호 업데이트
	String selectPasswordByUserId(String userId); // 유저 비밀번호 조회

	int updateToken(UserVerificationUpdateDto dto); //토큰업데이트

}
 