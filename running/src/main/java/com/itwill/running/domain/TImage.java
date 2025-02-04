package com.itwill.running.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TImage {
	private Integer id;
	private Integer teamId;
	private Integer postId;
	private String originName;
	private String uniqName;
	private String imagePath;
}
