package com.itwill.running.dto;

import com.itwill.running.domain.Team;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class TeamUpdateDto {
	private Integer teamId;
	private String teamName;
	private String uniqName;
	private String imagePath;
	private String title;
	private String content;
	private Integer maxNum;
	private Integer ageLimit;
	private Integer genderLimit;
	
	public Team toEntity() {
		return Team.builder().teamId(teamId).teamName(teamName).uniqName(uniqName).imagePath(imagePath).title(title).content(content)
				.maxNum(maxNum).ageLimit(ageLimit).genderLimit(genderLimit).build();
	}

}
