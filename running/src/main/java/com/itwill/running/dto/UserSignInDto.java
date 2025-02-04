package com.itwill.running.dto;

import com.itwill.running.domain.User;

import lombok.Data;

@Data
public class UserSignInDto {
	private String userId;
	private String password;
	
	
	public User toEntity() {
		
		return User.builder().userId(userId).password(password).build();
	}

}
