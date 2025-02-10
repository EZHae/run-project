package com.itwill.running.dto;

import com.itwill.running.domain.UImages;

import lombok.Data;

@Data
public class UImagesDto {
	private String userId;
	private String imageName;
	private String imagePath;
	
	
	public UImages toEntity() {
		return UImages.builder().userId(userId).imageName(imageName).imagePath(imagePath).build();
	}
}
