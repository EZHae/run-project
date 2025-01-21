package com.itwill.running.datasource;

import java.sql.Connection;
import java.sql.SQLException;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.zaxxer.hikari.HikariDataSource;

import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/application-context.xml"})
public class DataSourceTest {
	@Autowired
	private HikariDataSource ds;
	
	@Autowired
	private SqlSessionFactoryBean sqlSession;
	
	@Test
	public void testDataSource() throws SQLException {
		Assertions.assertNotNull(ds);
		log.debug("ds={}",ds);
		
		Connection conn=ds.getConnection();
		Assertions.assertNotNull(conn);
		log.debug("conn={}",conn);
		
		conn.close();
		log.debug("커넥션 객체를 풀에 반환 성공");
		
	}
	
	@Test
	public void testSqlSession() {
		Assertions.assertNotNull(sqlSession);
		log.debug("sqlSession={}",sqlSession);
	}
	
	
	
}
