package com.itwill.running.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.dto.CommentItemDto;
import com.itwill.running.service.CommentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/gposts")
public class G_PostController {
	
	@GetMapping("/details")
	public void details(@RequestParam("id") Integer id, Model model) {
		//id로 post를 불러와서 model에 addattribute한다.
	}
}
