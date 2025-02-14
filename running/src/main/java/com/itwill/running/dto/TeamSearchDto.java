package com.itwill.running.dto;

import lombok.Data;

@Data
public class TeamSearchDto {
	private String district;
	private String keyword;
	private String status;
	private Integer page;
	private Integer offset;
	private Integer limit;
}
