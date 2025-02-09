package com.itwill.running.repository;

import com.itwill.running.domain.UImages;
import com.itwill.running.dto.UImagesDto;

public interface UImagesDao {	
	Integer insertUserImage(UImages images);		// 이미지 정보를 저장
	UImages selectUserImageByUserId(String userId); // UserId로 해당 유저 이미지를 조회
	UImages selectUserImageByImgId(Integer imgId);  // imgId로 해당 유저 이미지를 조회
	
	Integer selectImgIdByUserId(String userId);		// userId로 imgId 조회
	int updateUserImage(UImages images);
	void updateUserImage(UImagesDto dto);
	
}
