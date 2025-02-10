package com.itwill.running.dto;

import com.itwill.running.domain.User;

import lombok.Data;

@Data
public class UserUpdateDto {
	private String userId;
	private String password;
	private String nickname;
	private String username;
	private Integer gender;
	private Integer age;
	private String phonenumber;
	private String residence;
	private String email;
	private Integer imgId;

	
	public User toEntity() {
		return User.builder().userId(userId).password(password).nickname(nickname).username(username)
				.gender(gender).age(age).phonenumber(phonenumber).residence(residence).email(email)
				.imgId(imgId).build();
	}
}
