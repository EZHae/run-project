package com.itwill.running.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwill.running.domain.TMember;

public interface TMemberDao {
	List<TMember> selectAllByTeamId(Integer teamId);

	Integer insertNewMember(TMember tmem);
	Integer deleteMember(Integer teamId, String userId);
	
	//팀멤버 확인 메서드
	int selectTeamMember(@Param("teamId") Integer teamId, @Param("userId") String userId);
	
	//팀장
	String getTeamLeaderId(@Param("teamId") int teamId);
}
