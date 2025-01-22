package com.itwill.running.web;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwill.running.dto.CommentCreateDto;
import com.itwill.running.dto.CommentItemDto;
import com.itwill.running.dto.CommentUpdateDto;
import com.itwill.running.service.CommentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/api/comment")
public class G_CommentController {
	private final CommentService commentService;
	
	@GetMapping("/all/{postId}")
	public ResponseEntity<List<CommentItemDto>> getAllCommentsByPostId(@PathVariable("postId") Integer postId){
		log.debug("getAllCommentsByPostId(postId={})",postId);
		List<CommentItemDto> list=commentService.readAllByPostId(postId);
		return ResponseEntity.ok(list);
	}
	
	@PutMapping("/{id}")
	public ResponseEntity<Integer> updateComment(@PathVariable("id") Integer id, @RequestBody CommentUpdateDto dto){
		log.debug("updateComment(id={},dto={})",id,dto);
		Integer result=commentService.updateComment(dto);
		return ResponseEntity.ok(result);
	}
	
	@PostMapping
	public ResponseEntity<Integer> createComment(@RequestBody CommentCreateDto dto){
		log.debug("createComment(dto={})",dto);
		Integer result=commentService.createComment(dto);
		return ResponseEntity.ok(result);
	}
	
	@DeleteMapping("/{id}")
	public ResponseEntity<Integer> deleteComment(@PathVariable("id") Integer id){
		log.debug("deleteComment(id={})",id);
		Integer result=commentService.deleteComment(id);
		return ResponseEntity.ok(result);
	}
	
	
	
}
