package com.itwill.running.dto;

import com.itwill.running.domain.TMember;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class TMemberCreateDto {
	private Integer leaderCheck;
	private Integer teamId;
	private String userId;
	
	public TMember toEntity() {
		return TMember.builder().leaderCheck(leaderCheck).teamId(teamId).userId(userId).build();
	}
}
