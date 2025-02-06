package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.TComment;
import com.itwill.running.dto.TCommentCreateDto;
import com.itwill.running.dto.TCommentItemDto;
import com.itwill.running.repository.TCommentDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class TCommentService {

	private final TCommentDao commentDao;
	
	public int create(TCommentCreateDto dto) {
		log.debug("TCommentService::create(dto={})", dto);
		
		TComment comment = dto.toEntity();
		
		int result = commentDao.insertTComment(comment);
		
		return result;
	}
	
	public List<TCommentItemDto> read(Integer postId) {
		log.debug("TCommentService::read(postId={})", postId);
		
		List<TComment> comments = commentDao.selectTCommentHierarchyByPostId(postId);
		
		return comments.stream().map(TCommentItemDto::fromEntity).toList();
	}
	
	public int delete(Integer id) {
		log.debug("TCommentService::delete(id={})", id);
		
		int result = commentDao.updateTCommentLikeDeleteById(id);
		
		return result;
	}
}
