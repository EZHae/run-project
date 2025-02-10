package com.itwill.running.dto;

import lombok.Data;

@Data
public class TCalendarItemDto {
	private Long id;
    private String title;
    private String nickname;
    private String content;
    private Integer currentNum;
    private Integer maxNum;
    private String formattedDateTime; // 포맷팅된 날짜와 시간
    private boolean isExpired; //만료되었는지
    
    
}
