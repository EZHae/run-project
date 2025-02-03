package com.itwill.running.dto;

import com.itwill.running.domain.Gpost;

import lombok.Data;

@Data
public class GpostCreateDto {
	
	private String title;
	private String userId;
	private String nickname;
	private String content;
	private Integer category;
	private Integer viewCount = 0; // 기본값 설정

	public Gpost toEntity() {
		return Gpost.builder()
		.title(title).userId(userId).nickname(nickname).content(content).category(category).viewCount(viewCount)
		.build();
	}

}
