package com.itwill.running.repository;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.itwill.running.domain.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/application-context.xml" })
public class UserDaoTest {

	@Autowired SqlSessionFactoryBean session;
	
	@Autowired
	private UserDao userDao;
	
	@Test
	public void testSelectById() {
		log.debug("{}", session);
		log.debug("{}", userDao);
		log.debug("testSelectById");
		User user = userDao.selectById(1);
		//안녕~~/이수빈
		
		log.debug("user={}", user);
	}
}
