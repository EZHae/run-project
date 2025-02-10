package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.Team;
import com.itwill.running.repository.TeamDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class TeamService {

	private final TeamDao teamDao;
	
	public List<Team> read() {
		log.debug("TeamService::read()");
		
		List<Team> teams = teamDao.selectTeamByAll();
		log.debug("# of read() result = {}", teams.size());
		
		return teams;
	}
	
	public Team read(Integer teamId) {
		log.debug("TeamService::read(teamId={})");
		
		Team team = teamDao.selectTeamByTeamId(teamId);
		
		return team;
	}
}
