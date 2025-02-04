package com.itwill.running.web;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwill.running.domain.UImages;
import com.itwill.running.service.UImagesService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/image")
public class UImagesController {
	
	private final UImagesService uimagesService;

	
	@GetMapping("/view/{id}")
	public ResponseEntity<Resource> viewImageById(@PathVariable Integer id) throws IOException {
	    log.debug(" 요청된 이미지 ID: {}", id);
	    log.info("컨트롤러 호출됨 - 이미지 ID: {}", id);
	    
	    // 데이터베이스에서 이미지 정보 조회
	    UImages uImage = uimagesService.selectUserImageById(id);
	    log.debug("🔍 조회된 이미지 정보: {}", uImage); // 추가된 로그

	    if (uImage == null) {
	        log.warn("이미지 ID {}를 찾을 수 없음", id);
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
	    }

	    // 이미지 경로 확인
	    Path imagePath = Paths.get(uImage.getImagePath());
	    log.info("이미지 경로: {}", imagePath);

	    Resource resource = new UrlResource(imagePath.toUri());
	    if (!resource.exists() || !resource.isReadable()) {
	        log.warn("이미지 파일을 읽을 수 없음: {}", imagePath);
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
	    }

	    String contentType = Files.probeContentType(imagePath);
	    if (contentType == null) {
	        contentType = "application/octet-stream";
	    }

	    // 원본명으로 URL을 인코딩(한글 및 특수문자 처리)2
        String encodedOriginName = URLEncoder.encode(uImage.getImageName(),"UTF-8");
	    
	    return ResponseEntity.ok()
	            .contentType(MediaType.parseMediaType(contentType))
	            .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + encodedOriginName + "\"")
	            .body(resource);
	}
}
