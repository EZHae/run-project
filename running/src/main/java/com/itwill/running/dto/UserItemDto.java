package com.itwill.running.dto;

import java.time.LocalDateTime;

import com.itwill.running.domain.User;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserItemDto {
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
	
	public static UserItemDto fromEntity(User user) {
		return UserItemDto.builder().userId(user.getUserId()).password(user.getPassword()).nickname(user.getNickname())
				.username(user.getUsername()).gender(user.getGender()).age(user.getAge()).phonenumber(user.getPhonenumber()).residence(user.getResidence())
				.email(user.getEmail()).authCheck(user.getAuthCheck()).imgId(user.getImgId()).userCreatedTime(user.getUserCreatedTime())
				.userAccessTime(user.getUserAccessTime()).build();
	}
}
