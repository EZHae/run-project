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
public class Gpost {
	private Integer id;
	private String title;
	private String userId;
	private String nickname;
	private String content;
	private Integer category;
	private Integer viewCount;
	private LocalDateTime createdTime;
	private LocalDateTime modifiedTime;
}
