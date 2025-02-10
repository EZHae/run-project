package com.itwill.running.dto;

import com.itwill.running.domain.TImage;

import lombok.Data;

@Data
public class TImageCreateDto {

	private Integer teamId;
	private String userId;
	private String nickname;
	private String originName;
	private String uniqName;
	private String imagePath;
	
	public TImage toEntity (){
		return TImage.builder()
				.teamId(teamId)
				.userId(userId)
				.nickname(nickname)
				.originName(originName)
				.uniqName(uniqName)
				.imagePath(imagePath)
				.build();
	}
}
