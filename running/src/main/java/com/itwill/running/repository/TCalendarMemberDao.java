package com.itwill.running.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.itwill.running.domain.TCalendarMember;

@Mapper
public interface TCalendarMemberDao {
    List<TCalendarMember> selectAllTCalendarMemberByCalendarId(@Param("teamId") Integer teamId, @Param("calendarId") Integer calendarId);
}
