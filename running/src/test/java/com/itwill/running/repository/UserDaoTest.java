package com.itwill.running.repository;

import org.junit.jupiter.api.extension.ExtendWith;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/application-context.xml" })
public class UserDaoTest {

	@Autowired SqlSessionFactoryBean session;
	
	@Autowired
	private UserDao userDao;
	
//	@Test
//	public void testSelectById() {
//		log.debug("{}", session);
//		log.debug("{}", userDao);
//		log.debug("testSelectById");
//		User user = userDao.selectById(1);
//		
//		log.debug("user={}", user);
//	}
	
//	@Test
//	public void testInsertUser() {
//		
//		User user = User.builder().userId("admin4").password("admin4").nickname("어드민4").username("어dmin4")
//		.gender(1).age(22).phonenumber("010-0000-0005").residence("동대문구").email("admin4@itwill.com").authCheck(1).imgId(1).build();
//		
//		Integer result = userDao.insertUser(user);
//		
//		Assertions.assertEquals(1, result); // 기대값 result가 1과 같다.
//	}
}
