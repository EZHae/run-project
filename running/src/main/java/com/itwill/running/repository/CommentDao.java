package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.GComment;

public interface CommentDao {
	List<GComment> selectByPostIdOrderByLevels(Integer postId);
	List<GComment> selectByUserId(String userId);
	Integer insertComment(GComment comment);
	Integer updateComment(GComment comment);
	Integer deleteByPostId(Integer postId);
	Integer deleteById(Integer id);
}
