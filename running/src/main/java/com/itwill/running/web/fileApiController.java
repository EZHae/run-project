package com.itwill.running.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwill.running.service.CourseService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/api")
public class fileApiController {
	@GetMapping("/uploadTeamImg/{filename}")
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
}
