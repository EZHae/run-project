package com.itwill.running.domain;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TCalendarMember {
	private Integer id; //pk
	private Integer teamId; //fk, team_id
	private Integer calendarId; //fk, calendar_id
	private String takeUserId; //fk, take_user_id
	private String nickname; //fk
	private LocalDateTime createdTime;// created_time // 일정 모집 가입시간
}
