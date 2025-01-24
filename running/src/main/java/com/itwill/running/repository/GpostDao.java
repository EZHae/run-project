package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.Gpost;
import com.itwill.running.dto.GpostCategoryDto;
import com.itwill.running.dto.GpostSearchDto;

public interface GpostDao {
	List<Gpost> selectOrderByIdDesc();	// 포스트 목록
	List<Gpost> selectByCategorySearch(GpostCategoryDto dto);		// 카테고리 별 목록
	Gpost selectById(Integer id);			// 포스트 상세보기 아이디로 찾기
	Integer insertPost(Gpost gPost);	// 포스트 글 작성
	Integer updatePost(Gpost gPost);	// 포스트 글 수정
	Integer deletePost(Integer id);		// 포스트 글 삭제
	Integer updateViewCountPost(Integer id);	// 포스트 뷰 카운트
	
}
