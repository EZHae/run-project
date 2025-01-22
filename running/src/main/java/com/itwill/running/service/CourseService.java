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
	
	// DB에 저장된 Course들을 모두 불러옴.
	public List<Course> read() {
		log.debug("CourseService::read()");
		
		List<Course> courses = courseDao.selectCourseByAll();
		log.debug("# of read() result = {}", courses.size());
		
		return courses;
	}
	
	// 코스의 id로 1개의 Course를 호출
	public Course read(Integer id) {
		log.debug("CourseService::read()");
		
		Course course = courseDao.selectCourseById(id);
		
		return course;
	}
	
	// 검색 조건을 활용한 Course들을 호출
	public List<Course> read(Integer category, String order, String keyword) {
		log.debug("CourseService::read()");
		
		List<Course> courses = courseDao.selectCourse(category, order, keyword);
		log.debug("# of read() result = {}", courses.size());
		
		return courses;
	}
}
