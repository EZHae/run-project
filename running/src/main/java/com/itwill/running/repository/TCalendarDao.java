package com.itwill.running.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwill.running.domain.TCalendar;

public interface TCalendarDao {
	List<TCalendar> selectTCalendarOrderByIdDesc(@Param("teamId") Integer teamId);// 일정 게시글 목록
	TCalendar selectTCalendartById(@Param("id") Integer id, @Param("teamId") Integer teamId); //일정 게시글 상세보기 by id
	int insertTCalendar(TCalendar tcalendar); // 일정 새글 작성
	
}
