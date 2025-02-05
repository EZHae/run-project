package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwill.running.domain.Park;
import com.itwill.running.repository.GpostDao;
import com.itwill.running.repository.ParkDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
@RequiredArgsConstructor 
@Transactional
public class ParkService {
	private final ParkDao parkDao;
	
	public List<Park> readAll(){
		return parkDao.selectAll();
	}
	
	public List<Park> readByParkLoc(String parkLoc){
		return parkDao.selectParksByParkLoc(parkLoc);
	}
	
	public List<String> readAllParkLocs(){
		return parkDao.selectDistinctParkLocs();
	}
	
}
