package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.GComment;

public interface GCommentDao {
	List<GComment> selectByPostIdOrderByLevels(Integer postId);
	List<GComment> selectByUserId(String userId);
	Integer insertComment(GComment comment);
	Integer updateComment(GComment comment);
	Integer deleteByPostId(Integer postId);
	Integer deleteById(Integer id);
	GComment selectById(Integer id);
	Integer isCommentDeletable(Integer id);
	Integer updateToUnknown(GComment comment);
	Integer deleteUnknownComments();
	
	// 이지해 추가
	Integer updateToUnknownByUserId(String userId);
}
