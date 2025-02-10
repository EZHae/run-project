package com.itwill.running.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

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
    
    // 최대 인원수 업데이트
    public void updateMaxNum(Integer teamId, Integer calendarId, Integer maxNum) {
        tCalendarDao.updateMaxNum(teamId, calendarId, maxNum);
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
    public void apply(Integer calendarId, Integer teamId, String userId, String nickname) throws Exception {
        // 일정 조회
        TCalendar tCalendar = tCalendarDao.selectTCalendarById(calendarId, teamId);
        if (tCalendar == null) {
            throw new Exception("일정을 찾을 수 없거나 권한이 없습니다.");
        }

        // 사용자가 이미 신청했는지 확인
        int appliedCount = tCalendarMemberDao.selectAppliedCalendarMember(calendarId, userId, teamId);
        if (appliedCount > 0) {
            throw new Exception("이미 신청하셨습니다.");
        }

        int currentNum = tCalendar.getCurrentNum();
        int maxNum = tCalendar.getMaxNum();

        // 최대 인원수 초과 여부 확인
        if (currentNum >= maxNum) {
            throw new Exception("최대 인원수에 도달했습니다.");
        }

        // 신청 처리
        tCalendarMemberDao.insertTCalendarMember(calendarId, teamId, userId, nickname);

        // 현재인원수 증가
        int delta = 1;
        tCalendarDao.updateCurrentNum(calendarId, teamId, delta);
    }
    
    //신청 취소
    @Transactional
    public void cancelApplication(Integer calendarId, Integer teamId, String userId) throws Exception {
    	log.debug("cancelApplication(calendarId={}, teamId={}, userId={})", calendarId, teamId, userId);

        // 일정 조회
        TCalendar tCalendar = tCalendarDao.selectTCalendarById(calendarId, teamId);
        if (tCalendar == null) {
            throw new Exception("일정을 찾을 수 없거나 권한이 없습니다.");
        }

        // 신청 여부 확인
        int appliedCount = tCalendarMemberDao.selectAppliedCalendarMember(calendarId, userId, teamId);
        if (appliedCount == 0) {
            throw new Exception("신청 내역이 없습니다.");
        }

        int deleteCount = tCalendarMemberDao.deleteTCalendarMember(calendarId, userId, teamId);
        if (deleteCount == 0) {
            throw new Exception("신청 취소에 실패하였습니다.");
        }
        
        // 신청 취소 처리
        tCalendarMemberDao.deleteTCalendarMember(calendarId, userId, teamId);

        // 현재인원수 감소
        int delta = -1;
        tCalendarDao.updateCurrentNum(calendarId, teamId, delta);
    }
    
    // 현재 인원 수와 최대 인원 수 조회
    public Map<String, Integer> getCurrentAndMaxNum(Integer calendarId, Integer teamId) {
        return tCalendarDao.getCurrentAndMaxNum(calendarId, teamId);
    }
    
    //해당 일정 글 삭제
    public void delete(Integer teamId, Integer calendarId) {
        tCalendarDao.delete(teamId, calendarId);
    }
    
}
