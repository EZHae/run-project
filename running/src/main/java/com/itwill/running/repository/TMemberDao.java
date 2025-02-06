package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.TMember;

public interface TMemberDao {
	List<TMember> selectAllByTeamId(Integer teamId);
	Integer insertNewMember(TMember tmem);
	Integer deleteMember(Integer teamId, String userId);
}
