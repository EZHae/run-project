package com.itwill.running.repository;

import java.util.List;

import com.itwill.running.domain.Notification;

public interface NotificationDao {
	List<Notification> readAllByUserId(String userId);
	List<Notification> readUnreadByUserId(String userId);
	Integer insertNewNotification(Notification noti);
	Integer deleteNotification(Integer id);
	Integer updateToChecked(Integer id);
}
