package com.itwill.running.web;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.itwill.running.domain.TImage;
import com.itwill.running.domain.TPost;
import com.itwill.running.dto.TPostCreateDto;
import com.itwill.running.dto.TPostSearchDto;
import com.itwill.running.dto.TPostUpdateDto;
import com.itwill.running.service.TImageService;
import com.itwill.running.service.TMemberService;
import com.itwill.running.service.TPostService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/teampage/{teamId}/post")
public class TPostController {

	private final TPostService postService;
	private final TImageService imageService;
	private final TMemberService memberService;
	
	@GetMapping("/create")
	public String create(@PathVariable Integer teamId, Model model, HttpSession session) {
		log.debug("TPostController::Get_create");
		
		// 로그인 아이디와 teamId로 로그인 계정이 해당 팀의 팀원인지 확인 필터링
		String signedInUserId = session.getAttribute("signedInUserId").toString();
		boolean isTeam = memberService.isTeamMember(teamId, signedInUserId);
		if (!isTeam) {
			model.addAttribute("errorcode", "팀 게시글 작성");
			model.addAttribute("errordetail", 2);
			return "nopermission";
		}

		model.addAttribute("teamId", teamId);
		
        return "tpost/create";
    }
	
	@PostMapping("/create")
	public String createTPost(@PathVariable Integer teamId, TPostCreateDto dto, HttpSession session, Model model,
							  @RequestParam(value = "file", required = false) List<MultipartFile> files) throws Exception {
		log.debug("TPostController::Post_createTPost");
		
		// 로그인 아이디와 teamId로 로그인 계정이 해당 팀의 팀원인지 확인 필터링
		String signedInUserId = session.getAttribute("signedInUserId").toString();
		boolean isTeam = memberService.isTeamMember(teamId, signedInUserId);
		if (!isTeam) {
			model.addAttribute("errorcode", "팀 게시글 작성");
			model.addAttribute("errordetail", 2);
			return "nopermission";
		}
		
		int postId = postService.create(dto);
		
		createTImageFromPostId(teamId, postId, dto.toEntity(), files);
		
		String url = postId + "/details";
			
		return "redirect:" + url;
	}
	
	@GetMapping("/list")
	public String list(@PathVariable Integer teamId, @RequestParam(defaultValue = "1") int page, TPostSearchDto dto, Model model) {
		log.debug("TPostController::Get_list");
		log.debug("dto={}", dto);
		
		List<TPost> posts;
        int totalPage;

        if (dto.getType() != null && dto.getKeyword() != null) {
            posts = postService.searchPosts(teamId, dto, page);
            totalPage = (int) Math.ceil((double) postService.countSearchedPosts(dto) / 10);
        } else {
            posts = postService.readByTeamId(teamId, dto, page);
            totalPage = (int) Math.ceil((double) postService.countPostsByTeamId(teamId) / 10);
        }

        model.addAttribute("posts", posts);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPage", totalPage);
        model.addAttribute("pageBlockSize", 5);
        model.addAttribute("type", dto.getType());
        model.addAttribute("keyword", dto.getKeyword());
        model.addAttribute("startPage", dto.getStartPage());
        model.addAttribute("endPage", dto.getEndPage());
		
		return "tpost/list";
	}
	
	@GetMapping({"/{id}/details", "/{id}/update" })
	public String details(@PathVariable Integer teamId, @PathVariable Integer id, Model model, 
						  HttpServletRequest request, HttpSession session) {
		log.debug("TPostController::Get_details");
		
		// /update만 필터링
		String requestURI = request.getRequestURI();
		String signedInUserId = session.getAttribute("signedInUserId").toString();
		log.debug("요청주소: {}", requestURI);
		if (request.getRequestURI().endsWith("/update")) {
			// 로그인아이디와 작성자아이디 체크
			String userId = postService.read(id).getUserId();
			if (signedInUserId == null || !signedInUserId.equals(userId)) {
				model.addAttribute("errorcode", "팀 게시글 수정");
				model.addAttribute("errordetail", 1);
				return "nopermission";
			}
		} else { // details 필터링
			// 로그인 아이디와 teamId로 로그인 계정이 해당 팀의 팀원인지 확인 필터링
			boolean isTeam = memberService.isTeamMember(teamId, signedInUserId);
			if (!isTeam) {
				model.addAttribute("errorcode", "팀 게시글 상세보기");
				model.addAttribute("errordetail", 2);
				return "nopermission";
			}
		}
		
		TPost post = postService.read(id);
		List<TImage> images = imageService.loadImage(id);
		
		model.addAttribute("post", post);
		model.addAttribute("images", images);
		
		if (signedInUserId != null) {
			if (!signedInUserId.equals(post.getUserId())) {
				postService.updateViewCount(id);
			}
		}
		
		if (request.getRequestURI().endsWith("/details")) {
			return "tpost/details";
		} else {
			return "tpost/update";
		}
    }
	
	@PostMapping("/{id}/update")
	public String update(@PathVariable Integer teamId, @PathVariable Integer id, TPostUpdateDto dto, String deletedImages, 
						 @RequestParam(value = "file", required = false) List<MultipartFile> files, HttpSession session, Model model) throws Exception {
		log.debug("TPostController::Post_update");
		
		// 로그인아이디와 작성자아이디 체크
		String signedInUserId = session.getAttribute("signedInUserId").toString();
		String userId = postService.read(id).getUserId();
		if (!signedInUserId.equals(userId)) {
			model.addAttribute("errorcode", "팀 게시글 수정");
			model.addAttribute("errordetail", 1);
			return "nopermission";
		}
		
		int postId = postService.update(dto);
		
		createTImageFromPostId(teamId, postId, dto.toEntity(), files);
		
		if (deletedImages != null && !deletedImages.trim().isEmpty()) {
	        List<Integer> deleteImagesId = Arrays.stream(deletedImages.split(","))
	        		.map(Integer::parseInt)
	        		.sorted()
	        		.collect(Collectors.toList());
	        for (Integer imageId : deleteImagesId) {
	        	imageService.deleteById(imageId);
	        }
		}
		return "redirect:details";
	}
	
	@GetMapping("/{id}/delete")
	public String delete(@PathVariable Integer teamId, @PathVariable Integer id, HttpSession session, Model model) {
		log.debug("TPostController::Get_delete");
		
		// 로그인아이디와 작성자아이디 체크
		String signedInUserId = session.getAttribute("signedInUserId").toString();
		String userId = postService.read(id).getUserId();
		if (!signedInUserId.equals(userId)) {
			model.addAttribute("errorcode", "팀 게시글 삭제");
			model.addAttribute("errordetail", 1);
			return "nopermission";
		}
		
		imageService.deleteByPostId(id);
		postService.delete(id);
		
		String url = "/teampage/" + teamId + "/post/list";
		return "redirect:" + url;
	}
	
	
/*************** 콜 백 함수 ****************/
	
	private void createTImageFromPostId(Integer teamId, Integer postId, TPost post, List<MultipartFile> files) throws Exception {
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
					TImage image = TImage.builder()
							.teamId(teamId)
							.postId(postId)
							.userId(post.getUserId())
							.nickname(post.getNickname())
							.originName(originName)
							.uniqName(uniqName)
							.imagePath(uploadPath)
							.build();

					// 생성된 객체를 처음에 만든 비어있는 리스트에 추가
					images.add(image);
				}
			}
			// 다 만들어진 리스트를 imageService에게 전달
			imageService.saveImages(images);
		}
	}
}
