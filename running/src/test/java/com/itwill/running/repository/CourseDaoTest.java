package com.itwill.running.repository;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.itwill.running.domain.Course;
import com.itwill.running.domain.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/application-context.xml" })
public class CourseDaoTest {
	
	@Autowired
	CourseDao courseDao;
	
//	@Test
	public void testInsertCourse() {
		Course course = Course.builder()
				.title("집")
				.userId("user1")
				.nickname("nick123")
				.courseName("모란역")
				.content("붕어빵")
				.category(1)
				.viewCount(0)
				.likeCount(0)
				.build();
		courseDao.insertCourse(course);
	}
	
//	@Test
	public void testSelectCourseByAll() {
		List<Course> courses = courseDao.selectCourseByAll();
		
		log.debug("# of size({})", courses.size());
	}
	
//	@Test
	public void testSelectCourseByCategory() {
		List<Course> courses = courseDao.selectCourseByCategory(0);
		
		log.debug("# of size({})", courses.size());
	}
	
//	@Test
	public void testSelectCourse() {
		log.debug("testSelectCourse");
		List<Course> courses = courseDao.selectCourse(0, "v", "강");
		
		for (Course course : courses) {
			log.debug("{}",course);
		}
	}
	
//	@Test
	public void testDeleteCourse() {
		log.debug("testDeleteCourse");
		Integer id = 1;
		courseDao.deleteCourse(id);
		log.debug("testDeleteCourse(id={})", id);
	}
	
//	@Test
	public void testUpdateCourse() {
		log.debug("testUpdateCourse");
		Course course = Course.builder().id(17).title("제목 수정").courseName("코스 이름 수정").durationTime("소요시간 수정").content("내용 수정").category(1).build();
		
		courseDao.updateCourse(course);
	}
		
//	@Test
	public void testSelectLikeUserId() {
		log.debug("testSelectLikeUserId");
		
		List<String> users = courseDao.selectLikeUserId(18);
		
		for(String user_id : users) {
			log.debug("{}", user_id);
		}
	}
	
//	@Test
	public void testUpdateLikeCount() {
		log.debug("testUpdateLikeCount");
		Integer id = 14;
		courseDao.updateLikeCount(id); // 14번 게시글 좋아요수 36 -> 37

	}
	
//	@Test
	public void testUpdateViewCount() {
		log.debug("testUpdateViewCount");
		Integer id = 19;
		courseDao.updateViewCount(id); //19번 게시글 조회수 33 -> 34
	}
}
