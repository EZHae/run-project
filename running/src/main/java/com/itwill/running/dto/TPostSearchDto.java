package com.itwill.running.dto;

import lombok.Data;

@Data
public class TPostSearchDto {

	private Integer teamId;
	private String type;
	private String keyword;
	private int offset;
	private int limit;
	private int startPage;
	private int endPage;
}
