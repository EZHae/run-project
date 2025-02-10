package com.itwill.running.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class FileController {
	@GetMapping("/api/uploadTeamImg/{filename}")
	public void getImageFile(@PathVariable String filename, HttpSession session ,HttpServletRequest request, HttpServletResponse response) throws FileNotFoundException, IOException {
		final long serialVersionUID = 1L;
		final String BASE_IMAGE_DIR = "C:\\uploadTeamImg";

		String imagePath = BASE_IMAGE_DIR +File.separator+ filename;
		log.debug("Requested Image Path: " + imagePath); // 추가된 로그
		File imageFile = new File(imagePath);

		if (imageFile.exists()) {
			response.setContentType(session.getServletContext().getMimeType(imagePath));
			response.setContentLengthLong(imageFile.length());

			try (FileInputStream in = new FileInputStream(imageFile); OutputStream out = response.getOutputStream()) {

				byte[] buffer = new byte[1024];
				int bytesRead;
				while ((bytesRead = in.read(buffer)) != -1) {
					out.write(buffer, 0, bytesRead);
				}
			}
		} else {
			log.error("File not found: " + imagePath); // 추가된 로그
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
	}
	
	public static void deleteFileFromDirectory(String filePath) {
		// 삭제할 파일 경로
        //String filePath = "C:\\Users\\Public\\testfile.txt"; // 원하는 파일 경로로 변경

        File file = new File(filePath);

        if (file.exists()) {  // 파일이 존재하는지 확인
            if (file.delete()) {  // 파일 삭제 시도
                System.out.println("파일 삭제 성공: " + filePath);
            } else {
                System.out.println("파일 삭제 실패: " + filePath);
            }
        } else {
            System.out.println("파일이 존재하지 않습니다: " + filePath);
        }
	}
	
	public static String getNewFileNameAndSaveFile(MultipartFile file) throws IllegalStateException, IOException {
		final String UPLOAD_DIR = "C:/uploadTeamImg/";
		// 원본 파일 이름
		String originalFilename = file.getOriginalFilename();
		String extension = "";
		// 파일 확장자 추출
		if (originalFilename != null && originalFilename.contains(".")) {
			extension = originalFilename.substring(originalFilename.lastIndexOf("."));
		}

		String uuidFilename = UUID.randomUUID().toString() + extension;

//		// UUID 적용한 파일 이름: 파일이름이 너무 길어져서 사용하지 않음
//		String uuidFilename = UUID.randomUUID().toString() + "_" + originalFilename;

		// 파일 저장 경로
		File saveFile = new File(UPLOAD_DIR, uuidFilename);

		// 디렉토리가 존재하지 않으면 생성
		if (!saveFile.getParentFile().exists()) {
			saveFile.getParentFile().mkdirs();
		}

		// 지정한 디렉토리에 파일 저장
		file.transferTo(saveFile);

		return uuidFilename;

	}
}
