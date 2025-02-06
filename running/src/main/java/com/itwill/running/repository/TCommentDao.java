package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.TComment;

public interface TCommentDao {

	int insertTComment(TComment comment);
	
	List<TComment> selectTCommentHierarchyByPostId(Integer postId);
	
	int updateTCommentLikeDeleteById(Integer id);
	
	int deleteTCommentById(Integer id);
}
