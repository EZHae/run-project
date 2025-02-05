package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.TPost;
import com.itwill.running.dto.TPostCreateDto;
import com.itwill.running.dto.TPostSearchDto;
import com.itwill.running.dto.TPostUpdateDto;
import com.itwill.running.repository.TPostDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class TPostService {

	private final TPostDao postDao;
	
	public List<TPost> read() {
		log.debug("TPostService::read()");
		
		List<TPost> posts = postDao.selectTPostByAll();
		log.debug("# of read() result = {}", posts.size());
		
		return posts;
	}
	
	public List<TPost> readByTeamId(Integer teamId) {
		log.debug("TPostService::readByTeamId(teamId={})", teamId);
		
		List<TPost> posts = postDao.selectTPostByTeamId(teamId);
		log.debug("# of readByTeamId result = {}", posts.size());
		
		return posts;
	}
	
	public TPost read(Integer id) {
		log.debug("TPostService::read(id={})", id);
		
		TPost post = postDao.selectTPostById(id);
		
		return post;
	}
	
	public int create(TPostCreateDto dto) {
		log.debug("TPostService::create(dto={})", dto);
		
		TPost post = dto.toEntity();
		
		postDao.insertTPost(post);
		
		int result = post.getId();
		
		return result;
	}
	
	public int update(TPostUpdateDto dto) {
		log.debug("TPostService::update(dto={})", dto);
		
		TPost post = dto.toEntity();
		
		postDao.updateTPostByid(post);
		
		int result = post.getId();
		
		return result;
	}
	
	public List<TPost> search(TPostSearchDto dto) {
		log.debug("TPostService::search(dto={})", dto);
		
		List<TPost> posts = postDao.selectTPostByKeyword(dto);
		log.debug("# of read() result = {}", posts.size());
		
		return posts;
	}
	
	public void delete(Integer id) {
		log.debug("TPostService::delete(id={})", id);
		
		postDao.deleteTPostById(id);
	}
	
	public void updateViewCount(Integer id) {
		log.debug("TPostService::updateViewCount(id={})", id);
		
		postDao.updateViewCountById(id);
	}
}
