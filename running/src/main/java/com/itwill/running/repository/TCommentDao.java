package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.TComment;

public interface TCommentDao {

	int insertTComment(TComment comment);
	
	List<TComment> selectTCommentHierarchyByPostId(Integer postId);
	
	TComment selectTCommentById(Integer id);
	
	String selectNicknameByParentId(Integer parentId);
	
	int updateTCommentById(TComment comment);
	
	int updateTCommentLikeDeleteById(Integer id);
	
	int deleteTCommentById(Integer id);
}
