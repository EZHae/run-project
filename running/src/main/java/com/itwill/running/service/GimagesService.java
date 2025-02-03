package com.itwill.running.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;
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
    public String saveImage(MultipartFile file, Integer postId) throws Exception {
    	
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
                .postId(postId)
                .originName(originalName)
                .uniqName(uniqueName)
                .imagePath(filePath)
                .build();
        gImageDao.insertImages(image);

        log.debug("이미지 저장 완료: {}", image);
        
        // 클라이언트에 반환할 URL
        return "/uploads/" + uniqueName;
    }
    
    // 다중 이미지 저장 
    public List<String> saveImages(MultipartFile[] files, Integer postId) throws Exception{
    	List<String> imageUrls = new ArrayList<>();
    	
    	if(files != null) {
    		for(MultipartFile file : files) {
    			if(!file.isEmpty()) {
    				String url = saveImage(file, postId);
    				imageUrls.add(url);
    			}
    		}
    	}
    	return imageUrls;
    }
    
    // 상세보기에서 이미지 가져오기
    public List<Gimages> getImgesByPostId(Integer postId){
    	List<Gimages> gImages = gImageDao.selectImagesByPostId(postId);
    	
    	return gImages;
    }
    
	// 다중 이미지 삭제 처리 메서드
	public void deleteImages(List<Integer> imageIds) {
		// DB에서 이미지 삭제
		gImageDao.deleteImagesById(imageIds);
		log.debug("이미지 삭제 완료, imageId = {}", imageIds);

		// 필요하다면 파일 시스템에서 실제 파일도 삭제 ?
	}
	
	// 파일 다운로드 메서드
	public Gimages getImageByUniqName(String uniqName) {
		return gImageDao.selectImageByUniqName(uniqName);
	}
}
