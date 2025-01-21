package com.itwill.running.domain;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Comment {
	private Integer id;
	private Integer postId;
	private String ctext;
	private String userId;
	private String nickname;
	private LocalDateTime createdTime;
	private LocalDateTime modifiedTime;
	private Integer parentId;
	private Integer commentType;
	private Integer secret;
}
