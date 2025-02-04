package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.TCalendar;
import com.itwill.running.dto.TCalendarCreateDto;
import com.itwill.running.repository.TCalendarDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class TCalendarService {
	
	private final TCalendarDao tCalendarDao;
	
	//게시글 목록보기 서비스
	public List<TCalendar> read() {
		log.debug("TCalendarService::read()");
		
		List<TCalendar> tCalendars = tCalendarDao.selectTCalendarOrderByIdDesc();
		log.debug("# of read() result = {}", tCalendars.size());
		return tCalendars;
	}
	
	//게시글 아이디로 검색 서비스
	public TCalendar read(Integer id) {
		log.debug("TCalendarService::read()");
		
		TCalendar tCalendar = tCalendarDao.selectTCalendartById(id);
		log.debug(" tCalendar = {}",  tCalendar);
		
		return tCalendar;
	}
	
	//새글 작성 서비스
	public int create(TCalendarCreateDto dto) {
		log.debug("create(dto={})", dto);
		
		int result = tCalendarDao.insertTCalendar(dto.toEntity());
		log.debug("insert result = {}", result);
		
		return result;
	}

}
