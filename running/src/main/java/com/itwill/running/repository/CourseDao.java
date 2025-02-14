package com.itwill.running.repository;

import java.util.List;
import java.util.Map;

import com.itwill.running.domain.Course;
import com.itwill.running.dto.CourseSearchDto;

public interface CourseDao {
	
	int insertCourse(Course course); 							// 새로운 코스 등록
	
	List<Course> selectCourseByAll();							// 전체 코스 목록 조회
		
	Course selectCourseById(Integer id);						// 특정 코스 ID로 조회
	
	List<Course> selectCourse(CourseSearchDto dto);				// 특정 조건에 맞는 코스 목록 조회
	
	int selectCountPostsBySearch(CourseSearchDto dto);			// 특정 검색 조건에 맞는 개시글 개수 조회
	
	int updateCourse(Course course);							// 코스 정보 업데이트
	
	int deleteCourseById(Integer id);							// 코스 ID로 삭제
	
	int insertCourseLike(Integer courseId, String likeUserId);	// 특정 코스 좋아요 추가
	
	List<String> selectLikeUserIdByCourseId(Integer courseId); 	// 특정 코스에 좋아요를 누른 사용자 목록 조회
	
	int updateLikeCountById(Integer id);						// 특정 코스의 좋아요 수 업데이트
	
	int updateViewCountById(Integer id);						// 특정 코스 조회수 업데이트
	
	List<Course> readPageWithOffset(Map<String, Object> params); // Map 파라미터로 데이터를 검색
	
	List<Course> readAllPageWithOffset(Map<String, Object> params); // 추가: 구분 없이 페이징된 코스 조회
	
	int countPosts();											// 전체 코스 개수 조회 (검색 조건 없이)
	
	List<Course> getNewPostById();								// 최근 게시글
}

