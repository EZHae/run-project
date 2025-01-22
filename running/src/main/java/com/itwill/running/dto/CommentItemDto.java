package com.itwill.running.dto;

import java.time.LocalDateTime;

import com.itwill.running.domain.Comment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class CommentItemDto {
	private Integer id;
	private Integer postId;
	private String ctext;
	private String userId;
	private String nickname;
	private LocalDateTime createdTime;
	private LocalDateTime modifiedTime;
	private Integer commentType;
	private Integer secret;
	private Integer parentId;
	
	public static CommentItemDto fromEntity(Comment comment) {
		if(comment!=null) {
			return CommentItemDto.builder().id(comment.getId()).ctext(comment.getCtext()).postId(comment.getPostId())
					.userId(comment.getUserId()).nickname(comment.getNickname()).createdTime(comment.getCreatedTime())
					.modifiedTime(comment.getModifiedTime()).commentType(comment.getCommentType()).secret(comment.getSecret())
					.parentId(comment.getParentId()).build();
		}else {
			return null;
		}
	}
}
