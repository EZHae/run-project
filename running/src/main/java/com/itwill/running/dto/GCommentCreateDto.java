package com.itwill.running.dto;

import java.time.LocalDateTime;

import com.itwill.running.domain.GComment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class GCommentCreateDto {
	private Integer postId;
	private String ctext;
	private String userId;
	private String nickname;
	private Integer commentType;
	private Integer secret;
	private Integer parentId;
	
	public GComment toEntity() {
		return GComment.builder().postId(postId).ctext(ctext)
				.userId(userId).nickname(nickname).commentType(commentType).secret(secret).parentId(parentId).build();
	}
}
