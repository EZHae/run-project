package com.itwill.running.dto;

import lombok.Data;

@Data
public class UserVerificationUpdateDto {
	private String userId;
	private Integer authCheck;
	private String token;
}
