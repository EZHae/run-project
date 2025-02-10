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

public class NotificationItemDto {
	private Integer id;
	private String userId;
	private Integer type;
	private String link;
	private Integer checked;
	private String content;
	
	public static NotificationItemDto fromEntity(Notification noti) {
		return NotificationItemDto.builder().id(noti.getId()).userId(noti.getUserId()).type(noti.getType())
				.link(noti.getLink()).checked(noti.getChecked()).content(noti.getContent()).build();
	}
}
