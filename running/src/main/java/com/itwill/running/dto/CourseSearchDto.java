package com.itwill.running.dto;

import lombok.Data;

@Data
public class CourseSearchDto {

	private Integer category;
	private String order;
	private String keyword;
	
	private int offset; 
    private int limit;
}