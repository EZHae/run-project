package com.itwill.running.dto;

import com.itwill.running.domain.TPost;

import lombok.Data;

@Data
public class TPostCreateDto {

	private Integer teamId;
	private String userId;
	private String title;
	private String nickname;
	private String content;
	
	public TPost toEntity() {
		return TPost.builder()
				.teamId(teamId)
				.userId(userId)
				.title(title)
				.nickname(nickname)
				.content(content)
				.build();
	}
}
