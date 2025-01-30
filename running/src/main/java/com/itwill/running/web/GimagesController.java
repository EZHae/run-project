package com.itwill.running.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.itwill.running.domain.Gimages;
import com.itwill.running.service.GimagesService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@RequestMapping("/api/images")
@RequiredArgsConstructor
public class GimagesController {
	private final GimagesService gImageService;
	
	// 이미지 업로드!!!
	@PostMapping("/gpost/create")
	public Gimages uploadImages(@RequestParam("uploadFile") MultipartFile file, @RequestParam("postId") Integer postId) throws Exception {
        
		return gImageService.uploadFiles(file.getOriginalFilename(), file.getBytes(), postId);
	}
	

}
