package com.itwill.running.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwill.running.dto.TCalendarMemberItemDto;

@Mapper
public interface TCalendarMemberDao {
    // 일정 게시글의 모든 멤버 조회
    List<TCalendarMemberItemDto> selectAllTCalendarMemberByCalendarId(@Param("teamId") Integer teamId, @Param("calendarId") Integer calendarId);

    // 신청한 멤버 조회
    int selectAppliedCalendarMember(@Param("calendarId") int calendarId,
                                    @Param("userId") String userId, @Param("teamId") Integer teamId);

    // insert
    int insertTCalendarMember(@Param("calendarId") Integer calendarId,
                              @Param("teamId") Integer teamId,
                              @Param("userId") String userId,
                              @Param("nickname") String nickname);

    // delete
    int deleteTCalendarMember(@Param("calendarId") Integer calendarId,
                              @Param("userId") String userId,
                              @Param("teamId") Integer teamId);
}

