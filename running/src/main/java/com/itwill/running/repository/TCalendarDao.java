package com.itwill.running.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.itwill.running.domain.TCalendar;

public interface TCalendarDao {
	// 일정 게시글 목록
	List<TCalendar> selectTCalendarOrderByIdDesc(@Param("teamId") Integer teamId);
	
	//일정 게시글 상세보기 by id
	TCalendar selectTCalendarById(@Param("id") Integer id, @Param("teamId") Integer teamId); 

	//일정 글 업데이트(최대인원수만 올릴 수 있음)
	void updateMaxNum(@Param("teamId") Integer teamId, @Param("calendarId") Integer calendarId, @Param("maxNum") Integer maxNum);
	
	// 일정 새글 작성
	int insertTCalendar(TCalendar tcalendar);
	
	// 현재인원수 증가
	void updateCurrentNum(@Param("id") Integer id, @Param("teamId") Integer teamId, @Param("delta") Integer delta);
	
	// 현재 인원 수와 최대 인원 수 조회
    Map<String, Integer> getCurrentAndMaxNum(@Param("id") Integer id,
                                             @Param("teamId") Integer teamId);
    
    //해당 일정 글 삭제
    void delete(@Param("teamId") Integer teamId, @Param("calendarId") Integer calendarId);
    
}
