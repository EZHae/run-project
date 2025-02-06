package com.itwill.running.dto;

import java.time.LocalDateTime;

import com.itwill.running.domain.TComment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TCommentItemDto {

	private Integer id;
	private Integer teamId;
	private Integer postId;
	private String ctext;
	private String userId;
	private String nickname;
	private LocalDateTime createdTime;
	private LocalDateTime modifiedTime;
	private Integer parentId;
	private Integer commentType;
	private Integer deleted;
	
	public static TCommentItemDto fromEntity(TComment comment) {
		if (comment != null) {
			return TCommentItemDto.builder()
					.id(comment.getId())
					.teamId(comment.getTeamId())
					.postId(comment.getPostId())
					.ctext(comment.getCtext())
					.userId(comment.getUserId())
					.nickname(comment.getNickname())
					.createdTime(comment.getCreatedTime())
					.modifiedTime(comment.getModifiedTime())
					.parentId(comment.getParentId())
					.commentType(comment.getCommentType())
					.deleted(comment.getDeleted())
					.build();
		} else {
			return null;
		}
	}
}
