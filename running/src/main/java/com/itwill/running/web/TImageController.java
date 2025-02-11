package com.itwill.running.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwill.running.domain.TImage;
import com.itwill.running.dto.TImageCreateDto;
import com.itwill.running.service.TImageService;
import com.itwill.running.service.TMemberService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/teampage/{teamId}/image")
public class TImageController {

    // 이미지가 저장된 기본 폴더 경로
	private static final String UPLOAD_DIR = "C:/upload_data/temp/timages/";
	
	private final TImageService imageService;
	private final TMemberService memberService;
	
	@GetMapping("/list")
	public String list(@PathVariable Integer teamId, Model model, HttpSession session) {
		log.debug("TImageController::Get_list");
		
		// 로그인 아이디와 teamId로 로그인 계정이 해당 팀의 팀원인지 확인 필터링
		String signedInUserId = session.getAttribute("signedInUserId").toString();
		boolean isTeam = memberService.isTeamMember(teamId, signedInUserId);
		if (!isTeam) {
			model.addAttribute("errorcode", "팀 앨범 목록");
			model.addAttribute("errordetail", 2);
			return "nopermission";
		}
		
		model.addAttribute("teamId", teamId);
		
		return "/timage/list";
	}
	
	@GetMapping("/list/api")
	@ResponseBody
	public ResponseEntity<List<TImage>> getImageList(
	        @PathVariable Integer teamId,
	        @RequestParam(defaultValue = "0") int category) {

	    log.debug("TImageController::Get_getImageList: teamId={}, category={}", teamId, category);

	    List<TImage> images;

	    // 카테고리별로 이미지 조회
	    if (category == 1) {
	        images = imageService.readByTeamIdAndNotNull(teamId); // 포스트 이미지만 조회
	    } else if (category == 2) {
	        images = imageService.readByTeamIdAndNull(teamId); // 앨범 이미지만 조회
	    } else {
	        images = imageService.readByTeamId(teamId); // 전체 조회
	    }

	    return ResponseEntity.ok(images);
	}
	
	@GetMapping("/create")
	public String create(@PathVariable Integer teamId, Model model, HttpSession session) {
		log.debug("TImageController::Get_create");
		
		// 로그인 아이디와 teamId로 로그인 계정이 해당 팀의 팀원인지 확인 필터링
		String signedInUserId = session.getAttribute("signedInUserId").toString();
		boolean isTeam = memberService.isTeamMember(teamId, signedInUserId);
		if (!isTeam) {
			model.addAttribute("errorcode", "팀 앨범 작성");
			model.addAttribute("errordetail", 2);
			return "nopermission";
		}
		
		model.addAttribute("teamId", teamId);
		
		return "/timage/create";
	}
	
	@PostMapping("/create")
	public String createImage(@PathVariable Integer teamId, TImageCreateDto dto, HttpSession session, Model model,
							  @RequestParam(value = "file", required = false) List<MultipartFile> files) throws Exception {
		log.debug("TImageController::Post_create");
		
		// 로그인 아이디와 teamId로 로그인 계정이 해당 팀의 팀원인지 확인 필터링
		String signedInUserId = session.getAttribute("signedInUserId").toString();
		boolean isTeam = memberService.isTeamMember(teamId, signedInUserId);
		if (!isTeam) {
			model.addAttribute("errorcode", "팀 앨범 작성");
			model.addAttribute("errordetail", 2);
			return "nopermission";
		}
		
		// TODO 업로드할 이미지가 있을 경우 실행할 이미지 저장 컨트롤러
		// 서버에 저장될 저장 위치
		String UPLOAD_DIR = "C:/upload_data/temp/timages/";

		// 서버컴에 저장될 저장 위치(폴더) 생성
		File uploadDir = new File(UPLOAD_DIR);
		if (!uploadDir.exists()) {
			uploadDir.mkdir();
		}

		// 사용자가 file을 업로드 시도 하였을 경우
		if (files != null && !files.isEmpty()) {
			List<TImage> images = new ArrayList<TImage>();

			// for-each로 파일들 하나 하나 빼기
			for (MultipartFile file : files) {
				// 혹시 모르니까 파일 비어있는지 2차 확인
				if (!file.isEmpty()) {

					// 원래 이미지명, 저장될 이미지명, 저장될 위치명
					String originName = file.getOriginalFilename();
					String uniqName = UUID.randomUUID().toString() + "_" + originName;
					String uploadPath = UPLOAD_DIR + uniqName;

					// 서버 (우리한테는 자신의 컴퓨터)에 파일 저장
					File destFile = new File(uploadPath);
					file.transferTo(destFile);

					// 서버컴에 저장 했으니 이제 DB에 정보 저장하기 위해 객체 생성
					dto.setOriginName(originName);
					dto.setUniqName(uniqName);
					dto.setImagePath(uploadPath);
					TImage image = dto.toEntity();

					// 생성된 객체를 처음에 만든 비어있는 리스트에 추가
					images.add(image);
				}
			}
			// 다 만들어진 리스트를 imageService에게 전달
			imageService.saveImages(images);
		}
		
		return "redirect:list";
	}
	
    /**
     * 🔹 이미지 미리보기 기능
     * - 사용자가 업로드한 이미지를 웹 페이지에서 바로 볼 수 있도록 함.
     * - `inline` 처리를 통해 브라우저에서 직접 렌더링 가능.
     *
     * @param filename 이미지 파일명 (고유한 저장 이름)
     * @return ResponseEntity<Resource> (이미지 파일을 포함한 HTTP 응답)
     */
    @GetMapping("/view/{filename}")
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
    @GetMapping("/download/{filename}")
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
