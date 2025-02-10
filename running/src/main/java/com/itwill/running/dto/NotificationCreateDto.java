package com.itwill.running.dto;

import com.itwill.running.domain.Notification;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class NotificationCreateDto {
	private String userId;
	private Integer type;
	private String link;
	private Integer checked;
	private String content;
	
	public Notification toEntity() {
		return Notification.builder().content(content).userId(userId).type(type).link(link).checked(checked).build();
	}
}
