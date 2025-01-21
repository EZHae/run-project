package com.itwill.running.repository;

import com.itwill.running.domain.User;

public interface UserDao {
	User selectById(Integer id);
}
