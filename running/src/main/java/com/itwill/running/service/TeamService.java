package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.Team;
import com.itwill.running.dto.TeamCreateDto;
import com.itwill.running.dto.TeamItemDto;
import com.itwill.running.dto.TeamSearchDto;
import com.itwill.running.dto.TeamUpdateDto;
import com.itwill.running.repository.TeamDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class TeamService {

	private final TeamDao teamDao;
	
	// 이지해
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
	
	// 최호철
	public List<TeamItemDto> readAllTeams(){
		List<Team> teams =teamDao.selectAll();
		return teams.stream().map(TeamItemDto::fromEntity).toList();
	}
	
	public TeamItemDto readByTeamid(Integer teamId) {
		Team team=teamDao.selectByTeamId(teamId);
		return TeamItemDto.fromEntity(team);
	}
	public List<Team> getUserTeams(String userId) {
		return teamDao.selectTeamsByUserId(userId);
	}
	public Integer deleteTeamMember(Integer teamId, String userId) {
		return teamDao.deleteTeamMember(teamId, userId);
	}
	public Integer selectTeamLeaderCheck(Integer teamId, String userId) {
		return teamDao.selectTeamLeaderCheck(teamId, userId);
	}
	public Integer deleteTeamLeader(Integer teamId) {
		return teamDao.deleteTeamLeader(teamId);
	};
	
	
	

	public Integer createNewTeam(TeamCreateDto dto) {
		return teamDao.insertNewTeam(dto.toEntity());
	}
	
	public Integer findTeamId(String teamName, String userId) {
		return teamDao.findTeamIdByTeamNameAndUserId(teamName, userId);
	}
	
	public Integer selectCountByTeamName(String teamName){
		return teamDao.selectCountByTeamName(teamName);
	}
	
	public Integer updateTeam(TeamUpdateDto dto) {
		return teamDao.updateTeam(dto.toEntity());
	}
	
	public Integer deleteTeam(Integer teamId) {
		return teamDao.deleteTeam(teamId);
	}
	
	public List<Team> searchTeams(TeamSearchDto dto){
		return teamDao.searchTeams(dto);
	}
	
	
	public List<TeamItemDto> readOpenTeams(){
		List<Team> teams = teamDao.selectOpenTeams();
		return teams.stream().map(TeamItemDto::fromEntity).toList();
	}
	
	public List<TeamItemDto> readClosedTeams() {
		List<Team> teams = teamDao.selectClosedTeams();
		return teams.stream().map(TeamItemDto::fromEntity).toList();
	}

}

