package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.Course;
import com.itwill.running.dto.CourseSearchDto;
import com.itwill.running.dto.CourseUpdateDto;
import com.itwill.running.repository.CourseDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CourseService {

	private final CourseDao courseDao;
	
	// DB에 저장된 Course들을 모두 불러오는 서비스
	public List<Course> read() {
		log.debug("CourseService::read()");
		
		List<Course> courses = courseDao.selectCourseByAll();
		log.debug("# of read() result = {}", courses.size());
		
		return courses;
	}
	
	// Course의 id로 Course를 검색하는 서비스
	public Course read(Integer id) {
		log.debug("CourseService::read()");
		
		Course course = courseDao.selectCourseById(id);
		log.debug("read(id={})", id);
		
		return course;
	}
	
	// 검색 조건에 맞는 Course들을 검색하는 서비스
	public List<Course> read(CourseSearchDto dto) {
		log.debug("CourseService::read()");
		
		List<Course> courses = courseDao.selectCourse(dto);
		log.debug("dto={}", dto);
		log.debug("# of read() result = {}", courses.size());
		
		return courses;
	}
	
	// 사용자가 Course를 수정하기 위한 서비스
	public int update(CourseUpdateDto dto) {
		log.debug("CourseService::update()");
		
		int result = courseDao.updateCourse(dto.toEntity());
		
		return result;
	}
	
	// 사용자가 Course를 삭제하기 위한 서비스
	public int delete(Integer id) {
		log.debug("CourseService::delete()");
		
		int result = courseDao.deleteCourseById(id);
		log.debug("delete(id={}", id);
		
		return result;
	}
	
	// 사용자가 Course를 상세보기 했을 때 Course의 조회수가 올라가는 서비스 (COURSE.view_count += 1)
	public void viewCount(Integer id) {
		log.debug("CourseService::viewCount");
		
		courseDao.updateViewCountById(id);
	}
	
	// 사용자가 Course에 좋아요를 했을 때 Course의 좋아요가 올라가는 서비스 (COURSE.like_count += 1)
	public void likeCount(Integer id) {
		log.debug("CourseService::likeCount");
		
		courseDao.updateLikeCountById(id);
	}
	
	// 사용자가 Course에 좋아요를 했을 때 COURSE_LIKE 테이블에 생성될 데이터
	// ex) 8번 글에 admin이 좋아요를 누르면 COURSE_LIKE 테이블에 해당 데이터가 생성된다.
	public void createCourseLike(Integer courseId, String likeUserId) {
		log.debug("CourseService::createCourseLike");
		
		courseDao.insertCourseLike(courseId, likeUserId);
		log.debug("userId({}) like to courseId({})", likeUserId, courseId);
	}
	
	// Course의 id에 어떤 사용자가 좋아요를 눌렀는지 검색하는 서비스
	// 좋아요 중복 방지를 위한 메서드에 사용
	public List<String> readLikeUserId(Integer courseId){
		log.debug("CourseService::readLikeUserId");
		
		List<String> likeUserIds = courseDao.selectLikeUserIdByCourseId(courseId);
		log.debug("# of readLikeUserId() result = {}", likeUserIds.size());
		return likeUserIds; 
	}
}
