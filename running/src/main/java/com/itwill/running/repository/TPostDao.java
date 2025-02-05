package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.TPost;
import com.itwill.running.dto.TPostSearchDto;

public interface TPostDao {

	List<TPost> selectTPostByAll();
	
	List<TPost> selectTPostByTeamId(Integer teamId);
	
	TPost selectTPostById(Integer id);
	
	List<TPost> selectTPostByKeyword(TPostSearchDto dto);
	
	int insertTPost(TPost post);
	
	int updateTPostByid(TPost post);
	
	int deleteTPostById(Integer id);
	
	int updateViewCountById(Integer id);
}
