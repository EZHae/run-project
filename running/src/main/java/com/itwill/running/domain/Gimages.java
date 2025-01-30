package com.itwill.running.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Gimages {
	private Integer id;
	private Integer postId;
	private String originName;
	private String uniqName;
	private String imagePath;
	//테스트 수정11

}
