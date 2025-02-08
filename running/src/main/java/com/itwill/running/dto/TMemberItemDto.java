package com.itwill.running.dto;

import java.time.LocalDateTime;

import com.itwill.running.domain.TMember;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class TMemberItemDto {
	private Integer id;
	private Integer leaderCheck;
	private Integer teamId;
	private String userId;
	private String nickname;
	private LocalDateTime createdTime;
	
	public static TMemberItemDto fromEntity(TMember tmember) {
		return TMemberItemDto.builder().id(tmember.getId()).leaderCheck(tmember.getLeaderCheck()).teamId(tmember.getTeamId()).nickname(tmember.getNickname())
				.userId(tmember.getUserId()).createdTime(tmember.getCreatedTime()).build();

	}
}