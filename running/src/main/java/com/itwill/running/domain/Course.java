package com.itwill.running.domain;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Course {
	private Integer id;
	private String title;
	private String userId;
	private String nickname;
	private String courseName;
	private LocalDateTime durationTime;
	private String content;
	private Integer category;
	private Integer viewCount;
	private Integer likeCount;
	private LocalDateTime createdTime;
	private LocalDateTime modifiedTime;
}