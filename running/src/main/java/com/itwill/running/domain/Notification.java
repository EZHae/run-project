package com.itwill.running.domain;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Notification {
	private Integer id;
	private String userId;
	private Integer type;
	private String link;
	private Integer checked;
	private String content;
	private LocalDateTime createdTime;
}
