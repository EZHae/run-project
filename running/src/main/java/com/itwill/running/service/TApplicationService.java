package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.TApplication;
import com.itwill.running.dto.TApplicationItemDto;
import com.itwill.running.repository.TApplicationDao;
import com.itwill.running.repository.TeamDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class TApplicationService {
	private final TApplicationDao tappDao;
	
	public List<TApplicationItemDto> readAllApplications(Integer teamId){
		List<TApplication> tapplist=tappDao.selectAllApplicationsByTeamId(teamId);
		return tapplist.stream().map(TApplicationItemDto::fromEntity).toList();
	}

}
