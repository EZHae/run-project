package com.itwill.running.dto;

import java.time.LocalDateTime;

import com.itwill.running.domain.TApplication;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class TApplicationItemDto {
	private Integer id;
	private Integer teamId;
	private String userId;
	private String nickname;
	private String introMsg;
	private LocalDateTime createdTime;
	
	public static TApplicationItemDto fromEntity(TApplication tapplication) {
		return TApplicationItemDto.builder().id(tapplication.getId()).teamId(tapplication.getTeamId()).userId(tapplication.getUserId())
				.nickname(tapplication.getNickname()).introMsg(tapplication.getIntroMsg())
				.createdTime(tapplication.getCreatedTime()).build();
	}
	
	public TApplication toEntity(){
		return TApplication.builder().teamId(teamId).userId(userId).introMsg(introMsg).build();
	}

}
