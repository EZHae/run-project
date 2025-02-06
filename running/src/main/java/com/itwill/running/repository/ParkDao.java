package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.Park;

public interface ParkDao {
	List<Park> selectAll();
	List<String> selectDistinctParkLocs();
	List<Park> selectParksByParkLoc(String parkLoc);
	Park selectParkByParkId(Integer id);
}
