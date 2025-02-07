package com.itwill.running.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	
	// 페이징 처리 메서드
	public List<Gpost> readPageWithOffset(GpostCategoryDto dto,int offset, int limit) {
        log.debug("CourseService::readPageWithOffset()");
        Map<String, Object> params = new HashMap<>();
        params.put("keyword", dto.getKeyword() != null ? dto.getKeyword() : "");
        params.put("offset", offset);
        params.put("limit", limit);
        params.put("search", dto.getSearch());
        params.put("category", dto.getCategory());
        
        return gPostDao.readPageWithOffset(params);
    }
	
	// 검색된 페이지 개수를 가져오는 메서드
	public int countPostsBySearch(GpostCategoryDto dto) {
		return gPostDao.selectCountPostsBySearch(dto);
	}
}
