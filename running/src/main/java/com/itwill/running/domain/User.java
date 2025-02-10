package com.itwill.running.domain;

import java.io.Serializable;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User implements Serializable {
	private static final long serialVersionUID = 1L; // 직렬화 버전 추가
	
	private String userId;
	private String password;
	private String nickname;
	private String username;
	private Integer gender;
	private Integer age;
	private String phonenumber;
	private String residence;
	private String email;
	private Integer authCheck;
	private Integer imgId;
	private LocalDateTime userCreatedTime;
	private LocalDateTime userAccessTime;
	private String token;

}
