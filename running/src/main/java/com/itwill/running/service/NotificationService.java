package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.Notification;
import com.itwill.running.dto.GCommentItemDto;
import com.itwill.running.dto.NotificationCreateDto;
import com.itwill.running.dto.NotificationItemDto;
import com.itwill.running.repository.NotificationDao;
import com.itwill.running.repository.TApplicationDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class NotificationService {
	private final NotificationDao notiDao;
	
	public List<NotificationItemDto> readNotisByUserId(String userId){
		List<Notification> notiLists=notiDao.readAllByUserId(userId);
		return notiLists.stream().map(NotificationItemDto::fromEntity).toList();
	}
	
	public List<NotificationItemDto> readUnreadNotisByUserId(String userId){
		List<Notification> notiLists=notiDao.readUnreadByUserId(userId);
		return notiLists.stream().map(NotificationItemDto::fromEntity).toList();
	}
	
	public Integer createNewNotification(NotificationCreateDto dto) {
		int result=notiDao.insertNewNotification(dto.toEntity());
		return result;
	}
	
	public Integer deleteNotification(Integer id) {
		return notiDao.deleteNotification(id);
	}

}
