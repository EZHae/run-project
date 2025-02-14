package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.Team;
import com.itwill.running.dto.TeamSearchDto;


public interface TeamDao {
	// 이지해
	List<Team> selectTeamByAll();
	Team selectTeamByTeamId(Integer teamId);
	
	// 최호철
	List<Team> selectAll();
	Team selectByTeamId(Integer teamId);
	List<Team> selectTeamsByUserId(String userId);
	Integer deleteTeamMember(Integer teamId, String userId);
	Integer selectTeamLeaderCheck(Integer teamId,String userId);
	Integer deleteTeamLeader(Integer teamId);

	// 이수빈
	Integer insertNewTeam(Team team);
	Integer findTeamIdByTeamNameAndUserId(String teamName, String userId);
	Integer selectCountByTeamName(String teamName); 
	Integer deleteTeam(Integer teamId); 
	Integer updateTeam(Team team);
	List<Team>searchPagedTeams(TeamSearchDto dto);
	Integer countTeamsByFilter(TeamSearchDto dto);
	
}
