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
public class TMember {
	private Integer id;
	private Integer leaderCheck;
	private Integer teamId;
	private String userId;
	private String nickname;
	private LocalDateTime createdTime;
	
}