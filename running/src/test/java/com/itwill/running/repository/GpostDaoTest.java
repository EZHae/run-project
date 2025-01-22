package com.itwill.running.repository;

import java.util.List;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.itwill.running.domain.Gpost;
import com.itwill.running.dto.GpostCreateDto;
import com.itwill.running.dto.GpostSearchDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/application-context.xml" })
public class GpostDaoTest {
	
	@Autowired
	private GpostDao gPostDao;
	
//	@Test
	public void testGpostDao() {
		Assertions.assertNotNull(gPostDao);
		log.debug("gPostDao={}",gPostDao);
	}
	
	// 테스트 포스트 목록 내림차순
//	@Test
	public void testSelectOrderByIdDesc() {
		List<Gpost> list = gPostDao.selectOrderByIdDesc();
		log.debug("list = {}",list);
	}
	
	// 테스트 포스트 아이디 상세보기
//	@Test
	public void testSelectById() {
		Gpost post1 = gPostDao.selectById(1);
		log.debug("post1={}",post1);
		Assertions.assertNotNull(post1);
		Gpost post2 = gPostDao.selectById(2);
		log.debug("post2={}",post2);
		Assertions.assertNotNull(post2);
	}
	
	// 테스트 포스트 글 생성 
//	@Test
//	public void testInsertPost() {
//		
//		Gpost gPost = Gpost.builder()
//				.title("세번째 타이틀").userId("user1").nickname("nick123").content("세번째 글.")
//				.category(1).viewCount(0).build();
//		
//		
//	    int result = gPostDao.insertPost(gPost);
//		Assertions.assertNotNull(result);
//	}
	
	// 테스트 포스트 글 삭제
//	@Test
	public void testDeletePost() {
		
		int result = gPostDao.deletePost(3);
		Assertions.assertEquals(1, result);
	}
	
	// 테스트 포스트 글 업데이트
//	@Test
	public void testUpdatePost() {
		Gpost gPost = Gpost.builder().title("두번째 수정").content("두번째 내용 수정").id(2).build();
		
		int result = gPostDao.updatePost(gPost);
		Assertions.assertEquals(1, result);
	}
	
	// 테스트 포스트 글 제목 검색
//	@Test
	public void testSearchPost() {
		GpostSearchDto dto = new GpostSearchDto();
		
		// 타이틀로 검색
		dto.setCategory("t");
		dto.setKeyword("test");
		
		List<Gpost> list1 = gPostDao.searchPost(dto);
		Assertions.assertNotNull(list1);
		log.debug("title = {}", list1.stream().map(Gpost::getTitle).toList());
		
		// 닉네임으로 검색
		dto.setCategory("n");
		dto.setKeyword("nick");
	 	List<Gpost> list2 = gPostDao.searchPost(dto);
		Assertions.assertNotNull(list2);
		log.debug("nickname = {}", list2.stream().map(Gpost::getNickname).toList()); 
	}
	
	// 테스트 포스트 뷰 카운트
//	@Test
	public void testViewCountPost() {
		Gpost post = gPostDao.selectById(1);
		int viewCount = post.getViewCount();
		log.debug("view Count= {}",viewCount);
		
		int result = gPostDao.updateViewCountPost(1);
		Assertions.assertEquals(1, result);
		
		Gpost updateCount = gPostDao.selectById(1);
		log.debug("view Count= {}",updateCount);
	}
}
