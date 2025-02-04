package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.TCalendar;

public interface TCalendarDao {
	List<TCalendar> selectTCalendarOrderByIdDesc(); // 일정 게시글 목록
	TCalendar selectTCalendartById(Integer id); //일정 게시글 상세보기 by id
	int insertTCalendar(TCalendar tcalendar); // 일정 새글 작성
	
}
