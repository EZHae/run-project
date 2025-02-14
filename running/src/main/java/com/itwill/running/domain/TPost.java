package com.itwill.running.domain;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TPost {
	private Integer id;
	private Integer teamId;
	private String userId;
	private String title;
	private String nickname;
	private String content;
	private Integer viewCount;
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
