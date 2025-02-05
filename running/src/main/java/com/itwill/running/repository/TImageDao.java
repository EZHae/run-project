package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.TImage;

public interface TImageDao {

	int insertTImage(TImage image);
	
	List<TImage> selectTimageByAll();
	
	List<TImage> selectTImageByPostId(Integer postId);
	
	List<TImage> selectTImageByTeamId(Integer teamId);
	
	List<TImage> selectTimageByTeamIdAndNotNull(Integer teamId);
	
	List<TImage> selectTImageByTeamIdAndNull(Integer teamId);
	
	int deleteTImageByPostId(Integer postId);
	
	int deleteTImageById(Integer id);
}
