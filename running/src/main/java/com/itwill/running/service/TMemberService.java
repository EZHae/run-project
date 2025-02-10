package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.TMember;
import com.itwill.running.dto.TMemberCreateDto;
import com.itwill.running.dto.TMemberItemDto;
import com.itwill.running.repository.TMemberDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class TMemberService {

	private final TMemberDao tmemberDao;

	public List<TMemberItemDto> readAllByTeamId(Integer teamId) {
		List<TMember> tmembers = tmemberDao.selectAllByTeamId(teamId);
		return tmembers.stream().map(TMemberItemDto::fromEntity).toList();
	}

	public Integer createNewTMember(TMemberCreateDto dto) {
		return tmemberDao.insertNewMember(dto.toEntity());
	}
	
	public Integer deleteMember(Integer teamId, String userId) {
		return tmemberDao.deleteMember(teamId, userId);
	}
	
	// 사용자가 팀 멤버인지 확인하는 메서드
	public boolean isTeamMember(Integer teamId, String userId) {
	    int count = tmemberDao.selectTeamMember(teamId, userId);
	    log.debug("팀 멤버 여부 확인 - teamId: {}, userId: {}, count: {}", teamId, userId, count);
	    return count > 0;
	}
	
	//팀장
	public String getTeamLeaderId(int teamId) {
	    return tmemberDao.getTeamLeaderId(teamId);
	}
	
}
