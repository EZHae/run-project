package com.itwill.running.web;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwill.running.dto.NotificationCreateDto;
import com.itwill.running.dto.NotificationItemDto;
import com.itwill.running.service.GCommentService;
import com.itwill.running.service.NotificationService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/api/notification")
public class NotificationController {
	private final NotificationService notiService;

	@PostMapping
	public ResponseEntity<Integer> addNotification(@RequestBody NotificationCreateDto dto){
		int result=notiService.createNewNotification(dto);
		return ResponseEntity.ok(result);
	}

	@GetMapping("/{userid}")
	public ResponseEntity<List<NotificationItemDto>> readAllByUserId(@PathVariable("userid") String userId){
		List<NotificationItemDto> notis=notiService.readNotisByUserId(userId);
		return ResponseEntity.ok(notis);
	}
	
	@GetMapping("/{userid}/unread")
	public ResponseEntity<List<NotificationItemDto>> readUnreadsByUserId(@PathVariable("userid") String userId){
		List<NotificationItemDto> notis=notiService.readUnreadNotisByUserId(userId);
		return ResponseEntity.ok(notis);
	}
	
	@DeleteMapping("/{notificationid}")
	public ResponseEntity<Integer> deleteNotification(@PathVariable("notificationid") Integer notiId){
		int result=notiService.deleteNotification(notiId);
		return ResponseEntity.ok(result);
	}
}
