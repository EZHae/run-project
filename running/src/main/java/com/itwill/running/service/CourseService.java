package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.Course;
import com.itwill.running.repository.CourseDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CourseService {

	private final CourseDao courseDao;
	
	// DB에 저장된 Course들을 모두 불러옴. // All 검색
	public List<Course> read() {
		log.debug("CourseService::read()");
		
		List<Course> courses = courseDao.selectCourseByAll();
		log.debug("# of read() result = {}", courses.size());
		
		return courses;
	}
	
	// 코스의 id로 1개의 Course를 호출 // 상세보기
	public Course read(Integer id) {
		log.debug("CourseService::read()");
		
		Course course = courseDao.selectCourseById(id);
		
		return course;
	}
	
	// 검색 조건을 활용한 Course들을 호출 //콤보박스(추천 or 리뷰, 조회수순 or 좋아요순)와 키워드(공백도 가능)로 검색
	public List<Course> read(Integer category, String order, String keyword) {
		log.debug("CourseService::read()");
		
		List<Course> courses = courseDao.selectCourse(category, order, keyword);
		log.debug("# of read() result = {}", courses.size());
		
		return courses;
	}
	
	// 조회수 업데이트
	public void viewCount(Integer id) {
		log.debug("CourseService::viewCount");
		
		courseDao.updateViewCount(id);
	}
	
	// 좋아요 업데이트
	public void likeCount(Integer id) { 
		log.debug("CourseService::likeCount");
		
		courseDao.updateLikeCount(id);
	}
	
	
	public void createCourseLike(Integer courseId, String likeUserId) {
		log.debug("CourseService::createCourseLike");
		
		courseDao.insertCourseLike(courseId, likeUserId);
	}
	
	// 좋아요 누른 유저 검색
	public List<String> readLikeUserId(Integer courseId){
		log.debug("CourseService::readLikeUserId");
		
		List<String> likeUserIds = courseDao.selectLikeUserId(courseId);
		log.debug("# of readLikeUserId() result = {}", likeUserIds.size());
		return likeUserIds; 
	}
	
	//추가
	// 코스 새글 작성
	public int createCourse(Course course) {
		log.debug("CourseService::insertCourse");
		
		int result = courseDao.insertCourse(course);
		log.debug("insert result = {}", result);
		
		return result;
	}
	

}
