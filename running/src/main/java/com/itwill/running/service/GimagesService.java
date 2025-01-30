package com.itwill.running.service;

import java.io.File;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.itwill.running.domain.Gimages;
import com.itwill.running.repository.GimagesDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class GimagesService {
	
	private final GimagesDao gImageDao;
	private static final String UPLOAD_DIR = "C:/upload_data/temp/";
    
	// 이미지 데이터 삽입
    public String saveImage(MultipartFile file) throws Exception {
    	
    	// 디렉토리 생성
        File dir = new File(UPLOAD_DIR);
        if (!dir.exists()) {
            dir.mkdirs(); 
        }

        // 원본 파일 이름 및 확장자
        String originalName = file.getOriginalFilename();
        String extension = originalName.substring(originalName.lastIndexOf("."));

        // 고유 이름 생성
        String uniqueName = UUID.randomUUID().toString() + extension;

        // 저장 경로
        String filePath = UPLOAD_DIR + uniqueName;

        // 파일 저장
        file.transferTo(new File(filePath));

        // DB에 이미지 정보 저장
        Gimages image = Gimages.builder()
                .postId(null)
                .originName(originalName)
                .uniqName(uniqueName)
                .imagePath(filePath)
                .build();
        gImageDao.insertImages(image);

        log.debug("이미지 저장 완료: {}", image);
        
     // 클라이언트에 반환할 URL
        return "/uploads/summernote/" + uniqueName;
    }
    
 // 업로드된 이미지의 post_id 업데이트
    public void updatePostIdForImages(Integer postId) {
        gImageDao.updateImagesPostId(postId);
        log.debug("이미지 post_id 업데이트 완료: {}", postId);
    }
	
}
