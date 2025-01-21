package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.Course;

public interface CourseDao {
	
	int insertCourse(Course course); 
	
	List<Course> selectCourseByAll();
	
	List<Course> selectCourseByCategory(Integer category);
	
	List<Course> selectCourse(Integer category, String orderCategory, String keyword);
	
	int updateCourse(Course course);
	
	int deleteCourse(Integer id);
}
