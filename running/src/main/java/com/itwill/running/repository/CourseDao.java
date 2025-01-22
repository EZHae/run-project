package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.Course;
import com.itwill.running.domain.User;

public interface CourseDao {
	
	int insertCourse(Course course); 
	
	List<Course> selectCourseByAll();
	
	Course selectCourseById(Integer id);
	
	List<Course> selectCourse(Integer category, String order, String keyword);
	
	int updateCourse(Course course);
	
	int deleteCourse(Integer id);
	
	int insertCourseLike(Integer courseId, String likeUserId);
	
	List<String> selectLikeUserId(Integer courseId); 
	
	int updateLikeCount(Integer id);
	
	int updateViewCount(Integer id);
}
