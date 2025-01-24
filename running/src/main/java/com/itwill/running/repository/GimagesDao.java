package com.itwill.running.repository;

import com.itwill.running.domain.Gimages;

public interface GimagesDao {
	
	// 포스트 아이디로 이미지를 검색. 	
//	List<Gimages> selectByPostId(Integer postId);
	
	// 이미지를 저장
	Integer insertImages(Gimages gImages);
	// 테스트 
	
	// 이미지를 삭제
//	Integer deleteImagesById(Integer id);
	
	// 모든 이미지를 삭제
//	Integer deleteImagesByPostId(Integer postId);
}
