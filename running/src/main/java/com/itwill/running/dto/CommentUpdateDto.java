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
public class CommentUpdateDto {
	private Integer id;
	private String ctext;
	private Integer secret;
	
	public Comment toEntity() {
		return Comment.builder().ctext(ctext).secret(secret).id(id).build();
	}
	
}
