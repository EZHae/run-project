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
public class TPost {
	private Integer id;
	private Integer teamId;
	private String userId;
	private String title;
	private String nickname;
	private String content;
	private Integer viewCount;
	private LocalDateTime createdTime;
	private LocalDateTime modifiedTime;
}
