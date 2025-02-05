package com.itwill.running.dto;

import java.time.LocalDateTime;

import com.itwill.running.domain.TCalendar;

import lombok.Data;

@Data
public class TCalendarCreateDto {
	private Integer id;
	private Integer teamId;
	private String title;
	private String userId; 
	private String nickname; 
	private LocalDateTime dateTime;
	private String content;
	private Integer currentNum = 0; //현재 인원수 0으로
	private Integer maxNum;
	
	public TCalendar toEntity() {
		return TCalendar.builder().id(id).teamId(teamId).title(title).userId(userId).nickname(nickname).dateTime(dateTime).
				content(content).currentNum(currentNum).maxNum(maxNum).build();
	}
}
