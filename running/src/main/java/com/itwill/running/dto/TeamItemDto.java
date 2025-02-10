package com.itwill.running.dto;

import java.time.LocalDateTime;

import com.itwill.running.domain.Team;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class TeamItemDto {
	private Integer teamId;
	private String teamName;
	private String userId;
	private String nickname;
	private String uniqueName;
	private String imagepath;
	private String title;
	private String content;
	private Integer parkId;
	private Integer currentNum;
	private Integer maxNum;
	private Integer ageLimit;
	private Integer genderLimit;
	private LocalDateTime createdTime;
	private LocalDateTime modifiedTime;
	
	public static TeamItemDto fromEntity(Team team) {
		return TeamItemDto.builder().teamId(team.getTeamId()).teamName(team.getTeamName()).userId(team.getUserId()).nickname(team.getNickname())
				.uniqueName(team.getUniqueName())
				.imagepath(team.getImagepath()).title(team.getTitle()).content(team.getContent()).parkId(team.getParkId()).currentNum(team.getCurrentNum())
				.maxNum(team.getMaxNum()).ageLimit(team.getAgeLimit()).genderLimit(team.getGenderLimit())
				.createdTime(team.getCreatedTime()).modifiedTime(team.getModifiedTime()).build();
	}
}
