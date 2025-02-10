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
public class Team {


	private Integer teamId;
	private String teamName;
	private String userId;
	private String nickname;
	private String uniqName;
	private String imagePath;
	private String title;
	private String content;
	private Integer parkId;
	private Integer currentNum;
	private Integer maxNum;
	private Integer ageLimit;
	private Integer genderLimit;
	private LocalDateTime createdTime;
	private LocalDateTime modifiedTime;
}
