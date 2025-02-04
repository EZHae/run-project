package com.itwill.running.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UImages {
	private Integer id;
	private String userId;
	private String imageName;
	private String imagePath;

}
