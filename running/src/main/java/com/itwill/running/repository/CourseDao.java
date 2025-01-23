package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.Course;
import com.itwill.running.dto.CourseSearchDto;

public interface CourseDao {
	
	int insertCourse(Course course); 
	
	List<Course> selectCourseByAll();
	
	Course selectCourseById(Integer id);
	
	List<Course> selectCourse(CourseSearchDto dto);
	
	int updateCourse(Course course);
	
	int deleteCourseById(Integer id);
	
	int insertCourseLike(Integer courseId, String likeUserId);
	
	List<String> selectLikeUserIdByCourseId(Integer courseId); 
	
	int updateLikeCountById(Integer id);
	
	int updateViewCountById(Integer id);
}
