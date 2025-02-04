package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.Team;

public interface TeamDao {
	List<Team> selectAll();
	List<Team> selectOpenTeams();
	Team selectByTeamId(Integer teamId);
}
