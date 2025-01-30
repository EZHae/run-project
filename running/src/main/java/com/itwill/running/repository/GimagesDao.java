package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.Gimages;

public interface GimagesDao {
	
		
	List<Gimages> selectImagesByPostId(Integer postId);// 포스트 아이디로 이미지를 검색. 
	Integer insertImages(Gimages gImages);// 이미지를 저장
	void updateImagesPostId(Integer postId); // 이미지 업데이트
	Integer deleteImagesById(Integer id); // 이미지를 삭제
	Integer deleteImagesByPostId(Integer postId); // 모든 이미지를 삭제
}
