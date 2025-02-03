package com.itwill.running.web;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwill.running.domain.Gimages;
import com.itwill.running.service.GimagesService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/gpost")
public class GimagesController { 

	private static final String UPLOAD_DIR  = "C:/upload_data/temp/";
	private final GimagesService gimagesService;
	
    // 업로드된 이미지 제공 (웹에서 접근 가능하도록) - 해당 경로로 웹이 접근하려면 필수적
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
    
    // 파일 다운로드 - 파일이 저장될 때 uniqname으로 저장되지만, 다운 받을 때 원본명으로 받아야함.
    @GetMapping("/download/{uniqName}")
    public ResponseEntity<Resource> downloadFile(@PathVariable String uniqName, HttpSession session) throws IOException {
    	
    	// 로그인 체크여부 (로그인 하지 않은 사용자는 다운로드 불가) - 경고창을 띄워야함.
    	String signedInUserId = (String) session.getAttribute("signedInUserId");
    	if (signedInUserId == null) {
            // 회원이 아닐 경우 401 Unauthorized 또는 403 Forbidden을 반환할	 수 있음
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }
    	
    	// uniqName으로 파일 원본명 포함해서 조회
    	Gimages image = gimagesService.getImageByUniqName(uniqName);
    	
    	
    	// 실제 파일 경로(실제로 내부적으로 저장될 때는 uniqName으로 저장됨)
    	Path imagePath = Paths.get(UPLOAD_DIR + uniqName);
    	Resource resource = new UrlResource(imagePath.toUri());
    	
    	// 파일이 존재하고 읽을 수 있는지?
        if (!resource.exists() || !resource.isReadable()) {
            throw new RuntimeException("이미지를 불러올 수 없습니다: " + uniqName);
        }
        
        // 원본명으로 URL을 인코딩(한글 및 특수문자 처리)
        String encodedOriginName = URLEncoder.encode(image.getOriginName(),"UTF-8");
        // 파일 다운로드 시 브라우저가 파일 다운로드를 처리
        String contentDisposition = "attachment; filename=\"" + encodedOriginName  + "\"";
        
        // 응답 생성
        return ResponseEntity.ok()
        		.header(HttpHeaders.CONTENT_DISPOSITION, contentDisposition)
                .body(resource); // 해당 응답을 바디에 담아서 브라우저에 보냄
    }
}
