package com.itwill.running.service;

import java.io.File;
import java.io.FileOutputStream;
import java.util.UUID;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.Gimages;
import com.itwill.running.repository.GimagesDao;

import jakarta.servlet.ServletContext;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class GimagesService {
	private final GimagesDao gImageDao;
	private final ServletContext servletContext; // ServletContext 주입
	
	// 파일 업로드
	public Gimages uploadFiles(String originFileName, byte[] fileData, Integer postId) throws Exception {
		

        // 상대 경로 설정 (프로젝트 내부의 /static/files/uploads 경로)
//        String uploadPath = servletContext.getRealPath("/static/files/uploads") ;
        String uploadPath = servletContext.getContextPath() + "/src/main/webapp/static/files/uploads" ;
        log.debug(uploadPath);

        // 업로드 경로가 없으면 디렉토리 생성
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // 디렉토리 생성
        }
        

      // 랜덤 id값 생성
      UUID uuid = UUID.randomUUID();
      
      // . 뒤를 자르기
      String extention = originFileName.substring(originFileName.lastIndexOf("."));
      
      String uniqName = uuid.toString() + extention;
      // 파일 업로드 경로 = 업로드 파일 경로 / 랜덤 id . 확장자
      String filePath = uploadPath + "/" + uniqName;
      
      try (// 파일 출력 스트림 생성
      FileOutputStream fos = new FileOutputStream(filePath)) {
         fos.write(fileData);
      }
      
      // 이미지 데이터 생성
      Gimages gImages = Gimages.builder()
            .postId(postId)
            .originName(originFileName)
            .uniqName(uniqName)
            .imagePath(filePath)
            .build();
       
      // DB에 데이터 전송
      gImageDao.insertImages(gImages);
      log.debug("Image upload and save = {}",gImages);
      
      return gImages;
   }
   
   // 파일 삭제
   public void deleteFile(String filePath) throws Exception {
      
      // 파일 저장 경로 객체 생성
      File deleteFile = new File(filePath);
      
      if(deleteFile.exists()) {
         deleteFile.delete();
         log.debug("파일이 삭제 됨");
      } else {
         log.debug("파일이 없음");
      }   
   }


}
