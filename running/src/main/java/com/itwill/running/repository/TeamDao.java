package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.Team;
import com.itwill.running.dto.TeamItemDto;

public interface TeamDao {
	List<Team> selectAll();
	List<Team> selectOpenTeams();
	Team selectByTeamId(Integer teamId);
	Integer insertNewTeam(Team team);
	Integer findTeamIdByTeamNameAndUserId(String teamName, String userId);
	Integer selectCountByTeamName(String teamName);
	Integer deleteTeam(Integer teamId);
}
