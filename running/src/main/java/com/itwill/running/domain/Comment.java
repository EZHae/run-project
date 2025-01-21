package com.itwill.running.domain;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class Comment {
	Integer id;
	Integer postId;
	String ctext;
	String userId;
	String nickname;
	LocalDateTime createdTime;
	LocalDateTime modifiedTime;
	Integer commentType;
	Integer secret;
	Integer parentId;
}
