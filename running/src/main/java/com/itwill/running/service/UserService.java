package com.itwill.running.service;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.UImages;
import com.itwill.running.domain.User;
import com.itwill.running.dto.UserSignInDto;
import com.itwill.running.dto.UserSignUpDto;
import com.itwill.running.repository.UserDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService {
	
	private final UserDao userDao;
	private final UImagesService uimagesService;
	
	
	public User selectByUserId(String userId) {
		log.debug("selectByUserId(UserId={})", userId);
		User user = userDao.selectByUserId(userId);
		
		return user;
	}
	
	// 로그인 서비스
	public User read(UserSignInDto dto) {
		User user = userDao.selectByUserIdAndPassword(dto.toEntity());
		
		return user;
	}
	
	// 회원가입 서비스
	public User createUser(UserSignUpDto dto) {
		
		// 사용자 정보 생성
		userDao.insertUser(dto.toEntity());
		
		// 등록한 사용자의 userId 조회
		User user = userDao.selectByUserId(dto.getUserId());
		
		// 회원가입에 선택한 기본 이미지 id 추출
		int dafaultImageId = dto.getImgId();
		
		// UImagesService를 통해 기본 이미지 레코드 INSERT 후 생성된 이미지 id 반환
		int insertImage = uimagesService.insertDefaultUserImages(user.getUserId(), dafaultImageId);
		
		// 생성된 이미지 id를 USERS 테이블에 img_id 업데이트
		user.setImgId(insertImage);
		userDao.updateByImgId(user);

		return user;
	}
	
	// 로그인 서비스
}