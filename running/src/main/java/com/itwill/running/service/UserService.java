package com.itwill.running.service;

import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.domain.UImages;
import com.itwill.running.domain.User;
import com.itwill.running.dto.UserItemDto;
import com.itwill.running.dto.UserSignInDto;
import com.itwill.running.dto.UserSignUpDto;
import com.itwill.running.dto.UserUpdateDto;
import com.itwill.running.repository.UserDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService {

	private final UserDao userDao;
	private final UImagesService uimagesService;
	private final EmailAuthService emailAuthService;

	// 유저 아이디 중복체크
	public boolean checkUserId(String userId) {
		log.debug("checkUserId(userId={}", userId);
		User user = userDao.selectByUserId(userId);

		if (user == null) {
			return true;
		} else {
			return false;
		}
	}

	// 닉네임 중복체크
	public boolean checkNickname(String nickname) {
		log.debug("checkNickname(nickname={}", nickname);

		User user = userDao.selectByNickname(nickname);
		if (user == null) {
			return true;
		} else {
			return false;
		}
	}

	// 이메일 중복체크
	public boolean checkEmail(String email) {
		log.debug("checkEmail(email={})", email);

		User user = userDao.selectByEmail(email);

		return (user == null); // 값이 없으면 true고 없으면 false
	}

	// 휴대전화번호 중복체크
	public boolean checkPhoneNumber(String phonenumber) {
		User user = userDao.selectByPhoneNumber(phonenumber);
		if (user == null) {
			return true;
		} else {
			return false;
		}
	}

	// 유저 아이디 조회
	public UserItemDto selectByUserId(String userId) {
		log.debug("selectByUserId(UserId={})", userId);
		User user = userDao.selectByUserId(userId);
		return UserItemDto.fromEntity(user);
	}

	// 로그인 서비스
	public User read(UserSignInDto dto) {
		User user = userDao.selectByUserIdAndPassword(dto.toEntity());

		return user;
	}

	// 로그인 접속 시간 업데이트
	public int updateAccessTime(String userId) {
		return userDao.updateAccessTime(userId);
	}

	// 유저 삭제 서비스
	public int deleteUser(String userId) {
		return userDao.deleteUser(userId);
	}

	// 유저 업데이트 서비스
	public int updateUser(UserUpdateDto dto) {
		return userDao.updateUser(dto);
	}

//	// 회원가입 서비스
//	public User createUser(UserSignUpDto dto) {
//		// 랜덤 인증 토큰 생성
//		String token = UUID.randomUUID().toString();
//		// 인증 전에는 비활성화
//		dto.setAuthCheck(0);
//		
//		// 사용자 정보 생성
//		userDao.insertUser(dto.toEntity());
//
//		// 이메일발송
//		emailAuthService.sendVerificationEmail(dto.getEmail(), token);
//		//todo: 토큰업데이트
//
//		// 등록한 사용자의 userId 조회
//		User user = userDao.selectByUserId(dto.getUserId());
//
//		// 회원가입에 선택한 기본 이미지 id 추출
//		int dafaultImageId = dto.getImgId();
//
//		// UImagesService를 통해 기본 이미지 레코드 INSERT 후 생성된 이미지 id 반환
//		int insertImage = uimagesService.insertDefaultUserImages(user.getUserId(), dafaultImageId);
//
//		// 생성된 이미지 id를 USERS 테이블에 img_id 업데이트
//		user.setImgId(insertImage);
//		userDao.updateByImgId(user);
//
//		return user;
//	}
	
//	//이메일 인증
//	public boolean verifyUser(String token) {
//		User user = userDao.findByVerificationToken(token);
//
//		if (user != null) {
//			user.setAuthCheck(1); // 계정 활성화
//			user.setVerificationToken(null); // 토큰 제거
//			userRepository.save(user);
//			return true;
//		}
//		return false;
//	}

}