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

import com.itwill.running.domain.GComment;
import com.itwill.running.dto.GCommentCreateDto;
import com.itwill.running.dto.GCommentItemDto;
import com.itwill.running.dto.GCommentToDeletedDto;
import com.itwill.running.dto.GCommentUpdateDto;
import com.itwill.running.service.GCommentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/api/comment")
public class GCommentController {
	private final GCommentService commentService;
	
	@GetMapping("/all/{postId}")
	public ResponseEntity<List<GCommentItemDto>> getAllCommentsByPostId(@PathVariable("postId") Integer postId){
		log.debug("getAllCommentsByPostId(postId={})",postId);
		List<GCommentItemDto> list=commentService.readAllByPostId(postId);
		return ResponseEntity.ok(list);
	}
	
	@GetMapping("/{id}")
	public ResponseEntity<GCommentItemDto> getCommentById(@PathVariable("id") Integer id){
		log.debug("getCommentById(id={})",id);
		GCommentItemDto commentDto=commentService.readById(id);
		return ResponseEntity.ok(commentDto);
		
	}
	
	@GetMapping("/deletetest/{id}")
	public ResponseEntity<Integer> checkDeletable(@PathVariable("id") Integer id){
		log.debug("checkDeletable(id={})",id);
		Integer result=commentService.checkDeletable(id);
		return ResponseEntity.ok(result);
	}
	
	@PutMapping("/{id}")
	public ResponseEntity<Integer> updateComment(@PathVariable("id") Integer id, @RequestBody GCommentUpdateDto dto){
		log.debug("updateComment(id={},dto={})",id,dto);
		Integer result=commentService.updateComment(dto);
		return ResponseEntity.ok(result);
	}
	
	@PutMapping("/deleteinvalidcomment/{id}")
	public ResponseEntity<Integer> toDeleted(@PathVariable("id") Integer id, @RequestBody GCommentToDeletedDto dto){
		log.debug("toDeleted(id={},dto={})",id,dto);
		Integer result=commentService.toDeleted(dto);
		return ResponseEntity.ok(result);
	}
	
	@PostMapping
	public ResponseEntity<Integer> createComment(@RequestBody GCommentCreateDto dto){
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
