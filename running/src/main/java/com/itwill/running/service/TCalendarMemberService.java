package com.itwill.running.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.TCalendarMember;
import com.itwill.running.dto.TCalendarMemberItemDto;
import com.itwill.running.repository.TCalendarMemberDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class TCalendarMemberService {
    private final TCalendarMemberDao tCalendarMemberDao;

    // 일정 모집글에 신청된 팀원들 검색
    public List<TCalendarMemberItemDto> getTCalendarMembers(Integer teamId, Integer calendarId) {
        log.debug("getTCalendarMembers(teamId={}, calendarId={}) 호출", teamId, calendarId);

        // 유효성 검사
        if (teamId == null || calendarId == null) {
            throw new IllegalArgumentException("teamId와 calendarId는 필수입니다.");
        }

        // DAO 메서드 호출
        List<TCalendarMember> tCalendarMembers = tCalendarMemberDao.selectAllTCalendarMemberByCalendarId(teamId, calendarId);

        log.debug("조회된 멤버 수: {}", tCalendarMembers.size());

        List<TCalendarMemberItemDto> tCalendarmemberDtos = tCalendarMembers.stream()
                .map(TCalendarMemberItemDto::fromEntity)
                .collect(Collectors.toList());

        return tCalendarmemberDtos;
    }
}
