package com.itwill.running.web;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwill.running.service.GimagesService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/gpost")
public class GimagesController { 

	private static final String UPLOAD_DIR  = "C:/upload_data/temp/";
	
	private final GimagesService gImageService;

    // 업로드된 이미지 제공 (웹에서 접근 가능하도록)
    @GetMapping("/uploads/{filename}")
    public ResponseEntity<Resource> getImage(@PathVariable String filename) throws IOException {
        Path imagePath = Paths.get(UPLOAD_DIR + filename);
        Resource resource = new UrlResource(imagePath.toUri());

        // 파일이 존재하고 읽을 수 있는지?
        if (!resource.exists() || !resource.isReadable()) {
            throw new RuntimeException("이미지를 불러올 수 없습니다: " + filename);
        }

        // 응답 생성
        return ResponseEntity.ok()
        		.header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + filename + "\"")
                .body(resource); // 해당 응답을 바디에 담아서 브라우저에 보냄
        
    }
}
