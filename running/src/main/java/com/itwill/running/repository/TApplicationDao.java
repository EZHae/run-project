package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.TApplication;

public interface TApplicationDao {
	List<TApplication> selectAllApplicationsByTeamId(Integer teamId);
	Integer insertApplication(TApplication tapp);
	Integer deleteApplication(String userId, Integer teamId);
}
