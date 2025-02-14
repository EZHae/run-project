package com.itwill.running.domain;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
	private String durationTime;
	private String content;
	private Integer category;
	private Integer viewCount;
	private Integer likeCount;
	private LocalDateTime createdTime;
	private LocalDateTime modifiedTime;
	
	public String getFormattedCreatedTime() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분");
		return this.createdTime.format(formatter);
	}
	
	public String getFormattedModifiedTime() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 HH시 mm분");
		return this.modifiedTime.format(formatter);
	}
}