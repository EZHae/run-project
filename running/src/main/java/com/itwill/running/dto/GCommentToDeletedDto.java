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
public class GCommentToDeletedDto {
	private Integer id;
	private String ctext;
	private String userId;
	private String nickname;
	
	public GComment toEntity() {
		return GComment.builder().ctext(ctext).userId(userId).nickname(nickname).id(id).build();
	}
}
