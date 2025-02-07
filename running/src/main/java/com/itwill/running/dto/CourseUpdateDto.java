package com.itwill.running.dto;

import com.itwill.running.domain.Course;

import lombok.Data;

@Data
public class CourseUpdateDto {

	private Integer id;
	private String title;
	private String courseName;
	private String durationTime;
	private String content;
	private Integer category;
	
	public Course toEntity() {
		return Course.builder()
				.id(id)
				.title(title)
				.courseName(courseName)
				.durationTime(durationTime)
				.content(content)
				.category(category)
				.build();
	}
}