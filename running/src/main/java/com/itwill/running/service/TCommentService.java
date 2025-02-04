package com.itwill.running.service;

import org.springframework.stereotype.Service;

import com.itwill.running.repository.TCommentDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class TCommentService {

	private final TCommentDao commentDao;
}
