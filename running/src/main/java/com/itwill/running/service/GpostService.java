package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwill.running.domain.Gpost;
import com.itwill.running.dto.GpostCategoryDto;
import com.itwill.running.dto.GpostCreateDto;
import com.itwill.running.dto.GpostUpdateDto;
import com.itwill.running.repository.GpostDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor // final 필드 초기화 생성자
@Transactional
public class GpostService {
	
	private final GpostDao gPostDao;
	
	// 포스트 목록보기 서비스
	public List<Gpost> read() {
		
		List<Gpost> list = gPostDao.selectOrderByIdDesc();
		log.debug("Gpost = {}",list);
		return list;
	}
	
	// 포스트 카테고리별 서비스
	public List<Gpost> readByCategorySearch(GpostCategoryDto dto) {
		log.debug("GpostService::read()");
		
		List<Gpost> list = gPostDao.selectByCategorySearch(dto);
		log.debug("Gpost = {}",list);
		return list;
	}
	
	
	// 포스트 생성 서비스
	public Integer create(GpostCreateDto dto) {
		Gpost post = dto.toEntity(); 
		gPostDao.insertPost(post);
		
		return post.getId();
	}
	
	// 포스트 상세보기 서비스
	public Gpost read(Integer id) {
		
		Gpost post = gPostDao.selectById(id);
		return post;
	}	

	
	// 포스트 삭제하기 서비스
	public int deletePost(Integer id) {
		
		Integer result = gPostDao.deletePost(id);
		log.debug("deletePost ={}",result);
		
		return result;
	}
	
	// 포스트 업데이트 서비스
	public int updatePost(GpostUpdateDto dto) {
		
		Integer result = gPostDao.updatePost(dto.toEntity());
		log.debug("result = {}, updatePost = {}", result, dto);
		return result;
				
	}
	
	// 포스트 조회수 서비스	
	public void viewCountPost(Integer id) {
		gPostDao.updateViewCountPost(id);
		
	}	

}
