package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.TComment;
import com.itwill.running.dto.TCommentReadDto;

public interface TCommentDao {

	int insertTComment(TComment comment);
	
	int countSearchedTComment(Integer postId);
	
	List<TComment> selectTCommentHierarchyByPostId(Integer postId);
	
	TComment selectTCommentById(Integer id);
	
	String selectNicknameByParentId(Integer parentId);
	
	int updateTCommentById(TComment comment);
	
	int updateTCommentLikeDeleteById(Integer id);
	
	int deleteTCommentById(Integer id);
}
