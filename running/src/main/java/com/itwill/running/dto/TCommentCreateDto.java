package com.itwill.running.dto;

import com.itwill.running.domain.TComment;

import lombok.Data;

@Data
public class TCommentCreateDto {
	
	private Integer teamId;
	private Integer postId;
	private String ctext;
	private String userId;
	private String nickname;
	private Integer parentId;
	private Integer commentType;
	
	public TComment toEntity() {
		return TComment.builder()
				.teamId(teamId)
				.postId(postId)
				.ctext(ctext)
				.userId(userId)
				.nickname(nickname)
				.parentId(parentId)
				.commentType(commentType)
				.build();
	}
}
