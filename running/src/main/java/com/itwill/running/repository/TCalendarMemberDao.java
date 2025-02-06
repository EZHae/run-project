package com.itwill.running.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.itwill.running.domain.TCalendarMember;
import com.itwill.running.dto.TCalendarMemberItemDto;

@Mapper
public interface TCalendarMemberDao {
	//일정 게시판의 모든 멤버 조회
    List<TCalendarMemberItemDto> selectAllTCalendarMemberByCalendarId(@Param("teamId") Integer teamId, @Param("calendarId") Integer calendarId);
    
    //일정 게시글에 이미 신청했는지 확인(팀캘린터멤버인지 검색)
    int selectTCalendarMembersByCalendarId(@Param("calendarId") Integer calendarId, @Param("takeUserId") String takeUserId);

    //insert
    void insert(@Param("calendarId") Integer calendarId, @Param("userId") String userId);

    //delete
    void delete(@Param("calendarId") Integer calendarId, @Param("userId") String userId);
    
}
