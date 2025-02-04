package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.TPost;
import com.itwill.running.dto.TPostCreateDto;
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
	
	public void delete(Integer id) {
		log.debug("TPostService::delete(id={})", id);
		
		postDao.deleteTPostById(id);
	}
}
