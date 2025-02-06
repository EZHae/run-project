package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.TMember;
import com.itwill.running.dto.TMemberCreateDto;
import com.itwill.running.dto.TMemberItemDto;
import com.itwill.running.repository.TMemberDao;
import com.itwill.running.repository.TeamDao;

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
}
