package com.itwill.running.web;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.dto.TApplicationItemDto;
import com.itwill.running.dto.TMemberCreateDto;
import com.itwill.running.dto.TMemberItemDto;
import com.itwill.running.service.TApplicationService;
import com.itwill.running.service.TMemberService;
import com.itwill.running.service.TeamService;
import com.itwill.running.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/api/teamapplication")
public class TeamApplicationController {
	private final TApplicationService tappService;
	private final TMemberService tmemService;

	@PostMapping
	public ResponseEntity<Integer> createTeamApplication(@RequestBody TApplicationItemDto dto) {
		int result = tappService.createApplication(dto);
		return ResponseEntity.ok(result);
	}

	@DeleteMapping("/cancel")
	public ResponseEntity<Integer> deleteApplication(@RequestParam Integer teamid, @RequestParam String userid) {
		int result = tappService.deleteApplication(userid, teamid);
		return ResponseEntity.ok(result);
	}

}
