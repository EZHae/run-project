package com.itwill.running.web;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.itwill.running.dto.TCommentCreateDto;
import com.itwill.running.dto.TCommentItemDto;
import com.itwill.running.service.TCommentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/teampage/{teamId}/post/api/tcomment")
public class TCommentController {

	private final TCommentService commentService;
	
	@PostMapping
	public ResponseEntity<Integer> registerComment(@RequestBody TCommentCreateDto dto) {
		log.debug("registerComment(dto={})", dto);
		
		int result = commentService.create(dto);
		
		return ResponseEntity.ok(result);
	}
	
	@GetMapping("/all/{postId}")
	public ResponseEntity<List<TCommentItemDto>> getAllCommentsByPostId(@PathVariable Integer teamId, @PathVariable Integer postId) {
		log.debug("getAllCommentsByPostId(postId={})", postId);
		
		List<TCommentItemDto> list = commentService.read(postId);
		
		return ResponseEntity.ok(list);
	}
}
