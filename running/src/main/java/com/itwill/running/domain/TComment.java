package com.itwill.running.domain;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TComment {
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
}
