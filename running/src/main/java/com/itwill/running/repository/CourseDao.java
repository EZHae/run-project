package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.Course;
import com.itwill.running.domain.User;

public interface CourseDao {
	
	int insertCourse(Course course); 
	
	List<Course> selectCourseByAll();
	
	List<Course> selectCourseByCategory(Integer category);
	
	List<Course> selectCourse(Integer category, String orderCategory, String keyword);
	
	int updateCourse(Course course);
	
	int deleteCourse(Integer id);
	
	// TODO
	List<User> selectLikeUserId(Integer courseId); // 코스 아이디를 검색하여 해당 코스에 좋아요한 유저의 리스트 리턴
	
	int updateLikeCount(Integer id); // 조건을 만족했을 때 코스의 아이디로 검색하여 해당 코스의 like_count +1
}
