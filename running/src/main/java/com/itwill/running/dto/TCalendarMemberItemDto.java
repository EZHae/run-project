package com.itwill.running.dto;

import java.time.LocalDateTime;

import com.itwill.running.domain.TCalendarMember;

import lombok.Data;

@Data
public class TCalendarMemberItemDto {
    private String takeUserId; //fk, take_user_id
    private String nickname; //fk
    private LocalDateTime createdTime;// created_time // 일정 모집 가입시간
    
    public TCalendarMember toEntity() {
        return TCalendarMember.builder().takeUserId(takeUserId).nickname(nickname).createdTime(createdTime).build();
    }
    
    //엔터티 -> DTO
    public static TCalendarMemberItemDto fromEntity(TCalendarMember entity) {
        TCalendarMemberItemDto dto = new TCalendarMemberItemDto();
        dto.setTakeUserId(entity.getTakeUserId());
        dto.setNickname(entity.getNickname());
        dto.setCreatedTime(entity.getCreatedTime());
        return dto;
    }
}

