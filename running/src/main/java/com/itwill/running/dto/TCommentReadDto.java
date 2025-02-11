package com.itwill.running.dto;

import lombok.Data;

@Data
public class TCommentReadDto {

	private Integer postId;
	private int offset;
	private int limit;
	private int startPage;
	private int endPage;
	private int totalPage;
}
