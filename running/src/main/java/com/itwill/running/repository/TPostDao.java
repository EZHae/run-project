package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.TPost;

public interface TPostDao {

	List<TPost> selectTPostByAll();
	
	TPost selectTPostById(Integer id);
	
	int insertTPost(TPost post);
	
	int deleteTPostById(Integer id);
}
