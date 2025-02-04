package com.itwill.running.web;

import org.springframework.web.bind.annotation.RestController;

import com.itwill.running.service.TCommentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
public class TCommentController {

	private final TCommentService commentService;
}
