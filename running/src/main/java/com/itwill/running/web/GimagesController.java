package com.itwill.running.web;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.itwill.running.service.GimagesService;

import jakarta.servlet.ServletContext;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/gpost")
public class GimagesController {  // -------------------------- 이미지 업로드 테스트용 ------------------------

	private final GimagesService gImageService;
	private static final String FILE_PATH = "C:\\upload_data\\uploads\\";
	
	@Autowired
	private ServletContext servletContext; // 서버가 구동되고 있는 위치

	@GetMapping("/uploadForm")
	public void file() {
		
	}

	@PostMapping("/file")
	public String file(MultipartFile file, Model model) throws IllegalStateException, IOException {
		
//		String realPath = servletContext.getRealPath("/uploads"); // 실제 저장이 될 폴더 = 톰캣의 경로
		String realPath = FILE_PATH;
		
		System.err.println("실제 경로 : " + realPath);
		
		System.out.println(file);
		System.out.println(file.isEmpty());
		System.out.println(file.getSize()); // 파일크기
		System.out.println(file.getOriginalFilename());	// 업로드 된 파일명
		
		if(!file.isEmpty()) { // 파일업로드를 누르고 업로드 파일이 있을때
			// UUID
			String uniqueFileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
			
			// 경로 + 파일명
			File path = new File(realPath + "/" + uniqueFileName);
			System.out.println("경로와 파일명 : " + path.toString());
			
			File pathCheck = new File(realPath);
			if(!pathCheck.exists()) {
//				pathCheck.mkdir(); // 경로 하나만
				pathCheck.mkdirs(); // 그 하위 경로 전부 폴더를 만들기
			}
			// 파일 업로드
			file.transferTo(path); // 저장할 경로 파일명
			
//			model.addAttribute("img", "/uploads/" + uniqueFileName);
		}
		return "gpost/uploadForm";
	}	

}
