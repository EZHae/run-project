package com.itwill.running.web;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.dto.TMemberCreateDto;
import com.itwill.running.service.TMemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/api/tmember")
public class TMemberController {
	private final TMemberService tmemService;
	
	@PostMapping("/confirm")
	public ResponseEntity<Integer> createTMember(@RequestBody TMemberCreateDto dto) {
		int result = tmemService.createNewTMember(dto);
		return ResponseEntity.ok(result);
	}

	@DeleteMapping("/delete")
	public ResponseEntity<Integer> deleteMember(@RequestParam("teamid") Integer teamId,
			@RequestParam("userid") String userId) {
		int result = tmemService.deleteMember(teamId, userId);
		return ResponseEntity.ok(result);
	}
}
