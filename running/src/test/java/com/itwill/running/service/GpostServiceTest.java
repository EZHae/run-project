package com.itwill.running.service;

import java.util.List;

import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.itwill.running.domain.Gpost;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/application-context.xml"})
public class GpostServiceTest {
	
	// 애너테이션 의존성 주입.
	@Autowired private GpostService gPostService; 
	
	// 목록보기 서비스 테스트
//	@Test
	public void testRead() {
		
		List<Gpost> list = gPostService.read();
		list.forEach(x -> log.debug("{}",x));
	}
	
	// 상세보기 서비스 테스트
//	@Test
//	public void testReadById() {
//		
//		Gpost post = gPostService.read(1);
//		Assertions.assertNotNull(post);
//		log.debug("post by id = {}", post);
//	}
//	
	// 삭제하기 서비스 테스트
//	@Test
//	public void testDelete() {
//		int result = gPostService.deletePost(43);
//		Assertions.assertNotNull(result);
//	}
	
	

}
