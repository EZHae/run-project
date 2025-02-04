package com.itwill.running.web;

import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class TImageController {

    // 이미지가 저장된 기본 폴더 경로
	private static final String UPLOAD_DIR = "C:/upload_data/temp/timages/";
	
    /**
     * 🔹 이미지 미리보기 기능
     * - 사용자가 업로드한 이미지를 웹 페이지에서 바로 볼 수 있도록 함.
     * - `inline` 처리를 통해 브라우저에서 직접 렌더링 가능.
     *
     * @param filename 이미지 파일명 (고유한 저장 이름)
     * @return ResponseEntity<Resource> (이미지 파일을 포함한 HTTP 응답)
     */
    @GetMapping("/image/view/{filename}")
    public ResponseEntity<Resource> getImage(@PathVariable String filename) throws IOException {
        // 요청된 파일의 전체 경로 생성
        Path imagePath = Paths.get(UPLOAD_DIR + filename);
        // 해당 경로의 파일을 Resource 객체로 변환
        Resource resource = new UrlResource(imagePath.toUri());

        // 파일이 존재하지 않거나 읽을 수 없는 경우 예외 발생
        if (!resource.exists() || !resource.isReadable()) {
            throw new RuntimeException("이미지를 불러올 수 없습니다: " + filename);
        }

        // HTTP 응답 반환: inline(브라우저에서 바로 표시)
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + filename + "\"")
                .body(resource);
    }
    
    /**
     * 🔹 이미지 다운로드 기능
     * - 사용자가 업로드한 이미지를 다운로드할 수 있도록 함.
     * - `attachment` 처리를 통해 파일이 다운로드됨.
     *
     * @param filename 이미지 파일명 (고유한 저장 이름)
     * @return ResponseEntity<Resource> (이미지 파일을 포함한 HTTP 응답)
     */
    @GetMapping("/image/download/{filename}")
    public ResponseEntity<Resource> downloadImage(@PathVariable String filename) throws IOException {
        // 요청된 파일의 전체 경로 생성
        Path imagePath = Paths.get(UPLOAD_DIR + filename);
        // 해당 경로의 파일을 Resource 객체로 변환
        Resource resource = new UrlResource(imagePath.toUri());

        // 파일이 존재하지 않거나 읽을 수 없는 경우 예외 발생
        if (!resource.exists() || !resource.isReadable()) {
            throw new RuntimeException("파일을 다운로드할 수 없습니다: " + filename);
        }

        // HTTP 응답 반환: attachment(파일 다운로드)
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filename + "\"")
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .body(resource);
    }
}
