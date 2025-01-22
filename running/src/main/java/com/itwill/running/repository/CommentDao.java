package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.Comment;

public interface CommentDao {
	List<Comment> selectByPostIdOrderByLevels(Integer postId);
	List<Comment> selectByUserId(String userId);
	Integer insertComment(Comment comment);
	Integer updateComment(Comment comment);
	Integer deleteByPostId(Integer postId);
	Integer deleteById(Integer id);
}
