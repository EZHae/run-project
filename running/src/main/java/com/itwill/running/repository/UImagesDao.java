package com.itwill.running.repository;

import com.itwill.running.domain.UImages;

public interface UImagesDao {	
	Integer insertUserImage(UImages images);		// 이미지 정보를 저장
	UImages selectUserImageByUserId(String userId); // UserId로 해당 유저 이미지를 조회
	UImages selectUserImageById(Integer id);
}
