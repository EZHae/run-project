package com.itwill.running.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwill.running.domain.TCalendar;

public interface TCalendarDao {
	// 일정 게시글 목록
	List<TCalendar> selectTCalendarOrderByIdDesc(@Param("teamId") Integer teamId);
	
	//일정 게시글 상세보기 by id
	TCalendar selectTCalendarById(@Param("id") Integer id, @Param("teamId") Integer teamId); 
	
	// 일정 새글 작성
	int insertTCalendar(TCalendar tcalendar);
	
	// 현재인원수 증가
	void updateCurrentNum(@Param("calendarId") Integer calendarId, @Param("teamId") Integer teamId, @Param("delta") Integer delta);
	
}
