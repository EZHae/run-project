package com.itwill.running.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwill.running.domain.TCalendar;
import com.itwill.running.dto.TCalendarCreateDto;
import com.itwill.running.repository.TCalendarDao;
import com.itwill.running.repository.TCalendarMemberDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class TCalendarService {
    
    private final TCalendarDao tCalendarDao;
    private final TCalendarMemberDao tCalendarMemberDao;
    
    // 일정 게시글 목록 보기 서비스
    public List<TCalendar> read(Integer teamId) {
        log.debug("TCalendarService::read(teamId={})", teamId);
        
        List<TCalendar> tCalendars = tCalendarDao.selectTCalendarOrderByIdDesc(teamId);
        log.debug("# of tCalendars = {}", tCalendars.size());
        return tCalendars;
    }
    
    // 일정 게시글 아이디로 검색 서비스
    public TCalendar read(Integer id, Integer teamId) {
        log.debug("TCalendarService::read(id={}, teamId={})", id, teamId);
        
        TCalendar tCalendar = tCalendarDao.selectTCalendarById(id, teamId);
        log.debug("tCalendar = {}", tCalendar);
        
        return tCalendar;
    }
    
    // 새글 작성 서비스
    @Transactional
    public int create(TCalendarCreateDto dto) {
        log.debug("create(dto={})", dto);

        TCalendar tCalendar = dto.toEntity();
        tCalendar.setCreatedTime(LocalDateTime.now());
        tCalendar.setModifiedTime(LocalDateTime.now());

        // 데이터베이스에 저장
        tCalendarDao.insertTCalendar(tCalendar);
        
        // 이제 tCalendar 객체의 id 필드에 id 자동 생성
        Long generatedId = tCalendar.getId();
        log.debug("Generated ID: {}", generatedId);

        return generatedId.intValue(); 
    }
    
    // 현재 인원 수 증가
    public void incrementCurrentNum(Integer calendarId, Integer teamId) {
        tCalendarDao.updateCurrentNum(calendarId, teamId, 1);
    }

    // 현재 인원 수 감소
    public void decrementCurrentNum(Integer calendarId, Integer teamId) {
        tCalendarDao.updateCurrentNum(calendarId, teamId, -1);
    }

    //신청
    @Transactional
    public void apply(Integer calendarId, Integer teamId, String userId) throws Exception {
        // 일정 조회
        TCalendar tCalendar = tCalendarDao.selectTCalendarById(calendarId, teamId);
        if (tCalendar == null) {
            throw new Exception("일정을 찾을 수 없거나 권한이 없습니다.");
        }

        int currentNum = tCalendar.getCurrentNum();
        int maxNum = tCalendar.getMaxNum();

        // 최대 인원수 초과 여부 확인
        if (currentNum >= maxNum) {
            throw new Exception("최대 인원수에 도달했습니다.");
        }

        // 신청 처리
        tCalendarMemberDao.insert(calendarId, userId);

        // 현재인원수 증가
        tCalendarDao.updateCurrentNum(calendarId, teamId, teamId);
    }
    
    //신청 취소
    @Transactional
    public void cancelApplication(Integer calendarId, Integer teamId, String userId) throws Exception {
        // 일정 조회
        TCalendar tCalendar = tCalendarDao.selectTCalendarById(calendarId, teamId);
        if (tCalendar == null) {
            throw new Exception("일정을 찾을 수 없거나 권한이 없습니다.");
        }

        // 신청 취소 처리
        tCalendarMemberDao.delete(calendarId, userId);

        // 현재인원수 감소
        tCalendarDao.updateCurrentNum(calendarId, teamId, teamId);
    }

}
