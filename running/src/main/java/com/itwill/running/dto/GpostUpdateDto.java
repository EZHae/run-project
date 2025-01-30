package com.itwill.running.dto;

import com.itwill.running.domain.Gpost;

import lombok.Data;

@Data
public class GpostUpdateDto {

	private Integer id;
	private String title;
	private String content;
	
	public Gpost toEntity() {
		return Gpost.builder().id(id).title(title).content(content).build();
	}
}
