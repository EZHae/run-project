package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.Team;

public interface TeamDao {
	// 이지해
	List<Team> selectTeamByAll();
	Team selectTeamByTeamId(Integer teamId);
	
	// 최호철
	List<Team> selectAll();
	List<Team> selectOpenTeams();
	List<Team> selectClosedTeams();
	Team selectByTeamId(Integer teamId);

}
