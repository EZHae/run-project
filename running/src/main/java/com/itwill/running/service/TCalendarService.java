package com.itwill.running.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwill.running.domain.TCalendar;
import com.itwill.running.dto.TCalendarCreateDto;
import com.itwill.running.repository.TCalendarDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class TCalendarService {
    
    private final TCalendarDao tCalendarDao;
    
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
        
        TCalendar tCalendar = tCalendarDao.selectTCalendartById(id, teamId);
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
        
        // 이제 tCalendar 객체의 id 필드에 자동 생성된 id가 설정됩니다.
        Long generatedId = tCalendar.getId();
        log.debug("Generated ID: {}", generatedId);

        return generatedId.intValue(); 
    }


}
