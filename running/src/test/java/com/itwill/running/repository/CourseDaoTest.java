package com.itwill.running.repository;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.itwill.running.domain.Course;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/application-context.xml" })
public class CourseDaoTest {
	
	@Autowired
	CourseDao courseDao;
	
//	@Test
	public void testInsertCourse() {
		Course course = Course.builder().title("집").userId("user1").nickname("nick123").courseName("모란역").content("붕어빵").category(1).viewCount(0).likeCount(0).build();
		
		courseDao.insertCourse(course);
	}
	
//	@Test
	public void testSelectCourseByAll() {
		List<Course> courses = courseDao.selectCourseByAll();
		
		log.debug("# of size({})", courses.size());
	}
	
	@Test
	public void testSelectCourseByCategory() {
		List<Course> courses = courseDao.selectCourseByCategory(0);
		
		log.debug("# of size({})", courses.size());
	}
}
