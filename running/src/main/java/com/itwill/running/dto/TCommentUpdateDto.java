package com.itwill.running.dto;

import com.itwill.running.domain.TComment;

import lombok.Data;

@Data
public class TCommentUpdateDto {
	
	private Integer id;
	private String ctext;
	
	public TComment toEntity() {
		return TComment.builder()
				.id(id)
				.ctext(ctext)
				.build();
	}
}
