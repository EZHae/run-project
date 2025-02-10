package com.itwill.running.dto;

import com.itwill.running.domain.Course;

import lombok.Data;

@Data
public class CourseCreateDto {
	
	String title;
	String userId;
	String nickname;
	String courseName;
	String durationTime;
	String content;
	Integer category;
	
	
	public Course toEntity() {
		return Course.builder()
				.title(title)
				.userId(userId)
				.nickname(nickname)
				.courseName(courseName)
				.durationTime(durationTime)
				.content(content)
				.category(category)
				.build();
	}
}