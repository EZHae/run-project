package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.TComment;
import com.itwill.running.dto.TCommentCreateDto;
import com.itwill.running.dto.TCommentItemDto;
import com.itwill.running.dto.TCommentUpdateDto;
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
	
	public int countSearchedTCommentByPostId(Integer postId) {
		log.debug("TcommentService::countSearchedTCommentByPostId(postId={})", postId);
		
		int result = commentDao.countSearchedTComment(postId);
		
		return result;
	}
	
	public List<TCommentItemDto> read(Integer postId) {
		log.debug("TCommentService::read(postId={})", postId);
		
		List<TComment> comments = commentDao.selectTCommentHierarchyByPostId(postId);
		
		return comments.stream().map(TCommentItemDto::fromEntity).toList();
	}
	
	public TCommentItemDto readById(Integer id) {
		log.debug("TCommentService::read(id={})", id);
		
		TComment comment = commentDao.selectTCommentById(id);
		
		return TCommentItemDto.fromEntity(comment);
	}
	
	public String readNicknameByParentId(Integer parentId) {
		log.debug("TCommentService::readNicknameByParentId(parentId={})", parentId);
		
		String nickname = commentDao.selectNicknameByParentId(parentId);
		
		return nickname;
	}
	
	public int update(TCommentUpdateDto dto) {
		log.debug("TCommentService::update(dto={})", dto);
		
		int result = commentDao.updateTCommentById(dto.toEntity());
		
		return result;
	}
	
	public int delete(Integer id) {
		log.debug("TCommentService::delete(id={})", id);
		
		int result = commentDao.updateTCommentLikeDeleteById(id);
		
		return result;
	}
}
