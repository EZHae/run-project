package com.itwill.running.repository;



import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.itwill.running.domain.Comment;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/application-context.xml")
public class CommentDaoTest {
	@Autowired
	private CommentDao commentDao;

//	@Test
//	public void readByPostIdOrderByLevelTest() {
//		List<Comment> comments=commentDao.readByPostIdOrderByLevels(1);
//		log.debug("readByCommentId={}",comments);
//		Assertions.assertNotNull(comments);	
//	}

//	@Test
//	public void readByUserIdTest() {
//		List<Comment> comments=commentDao.readByUserId("user1");
//		log.debug("readByUserId={}",comments);
//		Assertions.assertNotNull(comments);
//		
//	}

	@Test
	public void insertCommentTest() {
		Comment comment = Comment.builder().postId(1).userId("user1").nickname("nick123").ctext("다오테스트??").commentType(0)
				.secret(0).parentId(2).build();
		int result = commentDao.insertComment(comment);
		log.debug("Parent ID: {}", comment.getParentId());
		Assertions.assertEquals(1, result);
	}
	
//	@Test
//	public void updateCommentTest() {
//		Comment comment=Comment.builder().ctext("수정테스트").id(2).secret(1).build();
//		int result=commentDao.updateComment(comment);
//		Assertions.assertEquals(1, result);
//		log.debug("updateResul={}",result);
//	}
	
//	@Test
//	public void deleteByPostId() {
//		int result=commentDao.deleteByPostId(12);
//		Assertions.assertEquals(1, result);
//	}
//	
//	@Test
//	public void deleteById() {
//		int result=commentDao.deleteById(3);
//		log.debug("deleteresult={}",result);
//		Assertions.assertEquals(1, result);
//	}

}
