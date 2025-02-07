package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.Gimages;

public interface GimagesDao {
	
	List<Gimages> selectImagesByPostId(Integer postId);// 포스트 아이디로 이미지를 검색. 
	Integer insertImages(Gimages gImages);// 이미지를 저장
	Integer deleteImagesById(List<Integer> imageIds); // 이미지를 삭제
	
	Integer deleteImagesByPostId(Integer postId); // 모든 이미지를 삭제
	Gimages selectImageByUniqName(String uniqName); // uniqName으로 이미지 조회

}
