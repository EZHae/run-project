package com.itwill.running.dto;

import com.itwill.running.domain.GComment;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class GCommentUpdateDto {
	private Integer id;
	private String ctext;
	private Integer secret;
	
	public GComment toEntity() {
		return GComment.builder().ctext(ctext).secret(secret).id(id).build();
	}
	
}
