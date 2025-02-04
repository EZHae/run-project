package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.TImage;

public interface TImageDao {

	int insertTImage(TImage image);
	
	List<TImage> selectTImagesByPostId(Integer postId);
	
	List<TImage> selectTImagesByTeamId(Integer teamId);
	
	int deleteTImageByPostId(Integer postId);
}
