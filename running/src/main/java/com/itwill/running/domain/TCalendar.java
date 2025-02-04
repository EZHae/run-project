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
public class TCalendar {
	private Integer id;
	private Integer teamId; //fk, team_id
	private String title;
	private String userId; //fk, user_id
	private String nickname; //fk
	private LocalDateTime dateTime; //date_time
	private String content;
	private Integer currentNum; //current_num
	private Integer maxNum; //max_num
	private LocalDateTime createdTime; //created_time
	private LocalDateTime modifiedTime; //modified_time
}
