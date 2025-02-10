package com.itwill.running.dto;

import com.itwill.running.domain.TPost;

import lombok.Data;

@Data
public class TPostUpdateDto {
	
	private Integer id;
	private Integer teamId;
	private String userId;
	private String title;
	private String nickname;
	private String content;
	
	public TPost toEntity() {
		return TPost.builder()
				.id(id)
				.teamId(teamId)
				.userId(userId)
				.title(title)
				.nickname(nickname)
				.content(content)
				.build();
	}
}
