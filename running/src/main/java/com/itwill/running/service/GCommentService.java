package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.GComment;
import com.itwill.running.dto.GCommentCreateDto;
import com.itwill.running.dto.GCommentItemDto;
import com.itwill.running.dto.GCommentToDeletedDto;
import com.itwill.running.dto.GCommentUpdateDto;
import com.itwill.running.repository.GCommentDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class GCommentService {
	private final GCommentDao commentDao;
	
	public List<GCommentItemDto> readAllByPostId(Integer postId) {
		List<GComment> comments=commentDao.selectByPostIdOrderByLevels(postId);
		return comments.stream().map(GCommentItemDto::fromEntity).toList();
	}
	
	public GCommentItemDto readById(Integer id) {
		GComment comment=commentDao.selectById(id);
		return GCommentItemDto.fromEntity(comment);
	}
	
	public Integer checkDeletable(Integer id) {
		return commentDao.isCommentDeletable(id);
	}
	
	public Integer toUnknown(GCommentToDeletedDto dto) {
		return commentDao.updateToUnknown(dto.toEntity());
	}
	
	public Integer updateComment(GCommentUpdateDto commentUpdateDto) {
		Integer result=commentDao.updateComment(commentUpdateDto.toEntity());
		return result;
	}
	
	public Integer createComment(GCommentCreateDto commentCreateDto) {
		Integer result=commentDao.insertComment(commentCreateDto.toEntity());
		return result;
	}
	
	public Integer deleteComment(Integer id) {
		Integer result=commentDao.deleteById(id);
		return result;
	}
	
	public Integer deleteUnknownComments() {
		return commentDao.deleteUnknownComments();
	}
}
