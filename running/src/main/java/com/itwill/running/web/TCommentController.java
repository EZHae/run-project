package com.itwill.running.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwill.running.dto.TCommentCreateDto;
import com.itwill.running.dto.TCommentItemDto;
import com.itwill.running.dto.TCommentUpdateDto;
import com.itwill.running.service.TCommentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/teampage/{teamId}/post/api/tcomment")
public class TCommentController {

	private final TCommentService commentService;
	
	@PostMapping()
	public ResponseEntity<Integer> createComment(@RequestBody TCommentCreateDto dto) {
		log.debug("TCommentController::createComment(dto={})", dto);
		
		int result = commentService.create(dto);
		
		return ResponseEntity.ok(result);
	}
	
	@GetMapping("/all/{postId}")
	public ResponseEntity<List<TCommentItemDto>> getAllCommentsByPostId(@PathVariable Integer teamId, @PathVariable Integer postId) {
		log.debug("TCommentController::getAllCommentsByPostId(postId={})", postId);
		
		List<TCommentItemDto> list = commentService.read(postId);
		
		return ResponseEntity.ok(list);
	}
	
	@GetMapping("/{id}")
	public ResponseEntity<TCommentItemDto> getCommentById(@PathVariable Integer teamId, @PathVariable Integer id) {
		log.debug("TCommentController::getCommentById(id={})", id);
		
		TCommentItemDto comment = commentService.readById(id);
		
		return ResponseEntity.ok(comment);
	}
	
	@GetMapping("/nickname/{parentId}")
	public ResponseEntity<String> getNickname(@PathVariable Integer teamId, @PathVariable Integer parentId) {
		log.debug("TCommentController::getNickname(parentId={})", parentId);
		
		String nickname = commentService.readNicknameByParentId(parentId);
		
		return ResponseEntity.ok(nickname);
	}
	
	@PutMapping("/update/{id}")
	public ResponseEntity<Integer> updateComment(@PathVariable Integer id, @RequestBody TCommentUpdateDto dto) {
		log.debug("TCommentController::deleteComment(id={})", id);
		
		int result = commentService.update(dto);
		
		return ResponseEntity.ok(result);
	}
	
	@PutMapping("/delete/{id}")
	public ResponseEntity<Integer> deleteComment(@PathVariable Integer id) {
		log.debug("TCommentController::deleteComment(id={})", id);
		
		int result = commentService.delete(id);
		
		return ResponseEntity.ok(result);
	}
	
	// TODO 페이징 처리
	@GetMapping("/paged/{postId}")
	public ResponseEntity<Map<String, Object>> getPagedComments(
	        @PathVariable Integer teamId,
	        @PathVariable Integer postId,
	        @RequestParam(defaultValue = "0") int page,
	        @RequestParam(defaultValue = "10") int size) {
	    log.debug("TCommentController::getPagedComments(postId={}, page={}, size={})", postId, page, size);

	    int offset = page * size;
	    List<TCommentItemDto> comments = commentService.readPagedComments(postId, offset, size);
	    int totalComments = commentService.countComments(postId);
	    int totalPages = (int) Math.ceil((double) totalComments / size);

	    Map<String, Object> response = new HashMap<>();
	    response.put("comments", comments);
	    response.put("currentPage", page);
	    response.put("totalPages", totalPages);

	    return ResponseEntity.ok(response);
	}
}
