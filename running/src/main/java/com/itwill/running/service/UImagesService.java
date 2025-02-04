package com.itwill.running.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.UImages;
import com.itwill.running.repository.UImagesDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class UImagesService {
	private final UImagesDao uimagesDao;
	
	// 실제 파일이 저장되는 경로 (서버 내 물리적 위치)
    private static final String UPLOAD_DIR = "C:/upload_data/profile/";
    
    // 웹에서 접근 가능한 URL 경로 (정적 리소스 매핑)
    private static final String PROFILE_URL = "/image/view/";
    
    private static final Map<Integer, String> DEFAULT_IMAGE_MAP = Map.of(
            1, "profile01.jpeg",
            2, "profile02.jpeg",
            3, "profile03.jpeg",
            4, "profile04.jpeg",
            5, "profile05.jpeg"
        );
    
	// 원본 이미지를 저장 
	public int insertDefaultUserImages(String userId, int defaultImageId) {
		
		String fileName = DEFAULT_IMAGE_MAP.get(defaultImageId);
		
		// 유효한 기본 이미지 ID인지 확인
        if (fileName == null) {
            throw new IllegalArgumentException("유효하지 않은 기본 이미지 ID: " + defaultImageId);
        }
		
		String imageName = "기본 이미지 " + defaultImageId;
		String imagePath = UPLOAD_DIR + fileName;
		
		// UImages 객체 생성
		UImages image = UImages.builder()
	            .userId(userId)
	            .imageName(imageName)
	            .imagePath(imagePath) // DB에는 실제 파일 경로 저장
	            .build();
		
		// 데이터베이스에 저장
		uimagesDao.insertUserImage(image);
		log.debug("UImages 객체의 id: {}", image.getId());
		
		// MyBatis에서 자동 생성된 ID 가져오기
		return image.getId();
	}
	
	
	// userId로 해당 사용자의 프로필 이미지 정보 조회
	public UImages selectUserImageByUserId(String userId) {
		return uimagesDao.selectUserImageByUserId(userId);
	}
	
	// 이미지 ID로 이미지 정보 조회
	public UImages selectUserImageById(Integer id) {
		
		UImages image = uimagesDao.selectUserImageById(id);
		return image;
	}
	
}
