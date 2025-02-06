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
	private Long id; // 시퀀스 값을 받을 필드
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
	
	//고민중....
//	public String getRecruitmentStatus() {
//        LocalDateTime now = LocalDateTime.now();
//        return now.isBefore(this.dateTime) ? "모집 중" : "모집 완료";
//    }
}
