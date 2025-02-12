package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.TComment;
import com.itwill.running.dto.TCommentReadDto;

public interface TCommentDao {

	int insertTComment(TComment comment);
	
	/* 페이징 처리를 위한 영역 */
	int countSearchedTComment(Integer postId);
	
	List<TComment> selectPagedTCommentHierarchyByPostId(TCommentReadDto dto);
	/***************************/
	
	List<TComment> selectTCommentHierarchyByPostId(Integer postId);
	
	TComment selectTCommentById(Integer id);
	
	String selectNicknameByParentId(Integer parentId);
	
	int updateTCommentById(TComment comment);
	
	int updateTCommentLikeDeleteById(Integer id);
	
	int updateTCommentLikeDeleteByUserId(String userId);
	
	int deleteTCommentById(Integer id);
}
