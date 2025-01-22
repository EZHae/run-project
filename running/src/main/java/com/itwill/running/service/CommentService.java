package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.Comment;
import com.itwill.running.dto.CommentCreateDto;
import com.itwill.running.dto.CommentItemDto;
import com.itwill.running.dto.CommentUpdateDto;
import com.itwill.running.repository.CommentDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CommentService {
	private final CommentDao commentDao;
	
	public List<CommentItemDto> readAllByPostId(Integer postId) {
		List<Comment> comments=commentDao.selectByPostIdOrderByLevels(postId);
		return comments.stream().map(CommentItemDto::fromEntity).toList();
	}
	
	public Integer updateComment(CommentUpdateDto commentUpdateDto) {
		Integer result=commentDao.updateComment(commentUpdateDto.toEntity());
		return result;
	}
	
	public Integer createComment(CommentCreateDto commentCreateDto) {
		Integer result=commentDao.insertComment(commentCreateDto.toEntity());
		return result;
	}
	
	public Integer deleteComment(Integer id) {
		Integer result=commentDao.deleteById(id);
		return result;
	}
}
