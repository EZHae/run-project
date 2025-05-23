package com.itwill.running.web;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwill.running.domain.Team;
import com.itwill.running.domain.UImages;
import com.itwill.running.domain.User;
import com.itwill.running.dto.NotificationItemDto;
import com.itwill.running.dto.UImagesDto;
import com.itwill.running.dto.UserItemDto;
import com.itwill.running.dto.UserSignInDto;
import com.itwill.running.dto.UserSignUpDto;
import com.itwill.running.dto.UserUpdateDto;
import com.itwill.running.service.GCommentService;
import com.itwill.running.service.NotificationService;
import com.itwill.running.service.TCommentService;
import com.itwill.running.service.TeamService;
import com.itwill.running.service.UImagesService;
import com.itwill.running.service.UserService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {
	
	private final UserService userService;
	private final UImagesService uimagesService;
	private final TeamService teamService;
	private final NotificationService notiService;
	private final GCommentService gcommentService;
	private final TCommentService tcommentService;
	
	//알림목록보기
	@GetMapping("/notifications")
	public void getNotificationsByUserId(@RequestParam("userid") String userId, Model model) {
		List<NotificationItemDto> dto=notiService.readNotisByUserId(userId);
		log.debug("notiList={}",dto);
		model.addAttribute("notiList",dto);
	}
	
	// 로그아웃 처리
	@GetMapping("/signout")
	public String signOut(HttpSession session) {  // 디스패쳐 서블릿이 리퀘스트를 통해서 세션을 찾고 세션 객체를 넘겨줌.
		log.debug("로그아웃: {}",session);
		
		// 로그아웃 
		session.removeAttribute("signedInUserId");
		session.invalidate();
		
		// 로그아웃후 페이지 이동
		return "redirect:/";
	}
	
	// 로그인 페이지 이동
	@GetMapping("/signin")
	public void signIn() {
	}
	// 로그인 처리
	@PostMapping("/signin")
	public String signIn(UserSignInDto dto, @RequestParam(name = "target", defaultValue = "") String target, HttpSession session) throws UnsupportedEncodingException {
		
		User user = userService.read(dto); 
		
		// 로그인 후 페이지로 이동
		String targetPage = null;
		if(user != null) {
			
			// 로그인 사용자 정보를 세션에 저장
			session.setAttribute("signedInUserId",user.getUserId());
			// 로그인할때 signedInUser와 동일한 userId를 검색하고 그 User 객체의 nickname도 세션에 저장
			session.getAttribute("signedInUserId").toString();
			String nickname = user.getNickname();
			session.setAttribute("signedInUserNickname", nickname);
			
			Integer authCheck = user.getAuthCheck();
			session.setAttribute("authCheck", authCheck);
			
			log.debug("signedInUserId={}", session.getAttribute("signedInUserId").toString());
			log.debug("signedInUserNickname={}", nickname);
			
			// 로그인 성공 시 최근 접속 시간 업데이트!
			int accessTime = userService.updateAccessTime(user.getUserId());
			log.debug("로그인 업데이트 : {}",accessTime);
			
			targetPage = target.equals("") ? "/" : target;
		} else { // 로그인 실패 시 다시 로그인 페이지로 이동
			
			targetPage = "/user/signin?result=f&target=" + URLEncoder.encode(target, "UTF-8");
		}
		
		return "redirect:" + targetPage;
	}
	
	// 회원가입 페이지 이동
	@GetMapping("/signup")
	public void signUp() {
	}
	// 회원가입 처리
	@PostMapping("/signup")
	public String signUp(UserSignUpDto dto) {
		userService.createUser(dto);
		
		return "redirect:/user/signin";
	}
	
	// 유저 상세 정보 페이지
	@GetMapping({"/details", "/modify"})
	public void profile(String userId, Model model, HttpSession session) {
		
		// 현재 세션의 유저아이디 조회
		String signedInUserId = (String) session.getAttribute("signedInUserId");
		UserItemDto user = userService.selectByUserId(signedInUserId);
		log.debug("유저 아이디: {}",user);
		
		int selectedImgId = user.getImgId();
		// 이미지 이름을 가져옴
		UImages userImage = uimagesService.selectUserImageByUserId(signedInUserId);
		String userImagePath = userImage.getImagePath();
		
		// 팀이름 조회
		List<Team> teams = teamService.getUserTeams(signedInUserId);
		log.debug("조회된 팀 목록: {}", teams); // 팀 리스트 출력
		// 팀 리더 조회
		
		Map<Integer, Integer> leaderCheck = new HashMap<>();
		for(Team team : teams) {
			int leaderCheckList = teamService.selectTeamLeaderCheck(team.getTeamId(), signedInUserId);
			leaderCheck.put(team.getTeamId(), leaderCheckList);
		}
		
		model.addAttribute("user", user);
		model.addAttribute("teams",teams);	
		model.addAttribute("leaderCheck",leaderCheck);	
		model.addAttribute("selectedImgId", selectedImgId);
		model.addAttribute("userImagePath", userImagePath);
	}
	
	// 유저 삭제 API
	@DeleteMapping("/{userId}")
	@ResponseBody
	public ResponseEntity<String> deleteUser(@PathVariable String userId, HttpSession session) {
		// 현재 세션의 유저아이디 조회
		String signedInUserId = (String) session.getAttribute("signedInUserId");
		if (signedInUserId == null) {
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인 필요");
	    }
	    if (!signedInUserId.equals(userId)) {
	        return ResponseEntity.status(HttpStatus.FORBIDDEN).body("본인 계정만 삭제 가능");
	    }

	    // 이지해 추가 - 계정 삭제되기 전 해당 유저가 작성한 댓글들 처리
	    gcommentService.toUnknownByUserId(userId);
	    tcommentService.deleteByUserId(userId);
		userService.deleteUser(userId);
		
		session.invalidate();
		
		return ResponseEntity.ok("계정 삭제 완료");
	}
	
	// 유저 정보 수정 API
	@PutMapping("/api/{userId}")
	@ResponseBody
	public ResponseEntity<String> updateUser(@PathVariable String userId,@RequestBody UserUpdateDto dto) {
		
		int result = userService.updateUser(dto);
		
		if (result > 0) {
	        return ResponseEntity.ok("계정 정보 수정 완료");
	    } else {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("계정 정보 수정 실패");
	    }
		
	}
	
	// 이미지 업데이트 변경 모달
	@GetMapping("/api/{userId}")
	@ResponseBody
	public ResponseEntity<UserItemDto> getUserImage(@PathVariable String userId){
		 // 유저 조회
		UserItemDto user = userService.selectByUserId(userId); 
		
		if (user != null) {
	        return ResponseEntity.ok(user);
	    } else {
	        return ResponseEntity.notFound().build();
	    }
	}
	
	// 이미지 업데이트 API
	@PutMapping("/api/{userId}/image")
	@ResponseBody
	public ResponseEntity<String> updateUserImage(
			@RequestBody UImagesDto dto){
		// 요청 데이터 로그 출력
        log.debug("요청된 데이터: {}", dto);
        // 서비스 계층에 DTO 전달
        uimagesService.updateUserProfileImage(dto);
        
        return ResponseEntity.ok("이미지 변경 완료");
	}
	
	
	// 비밀번호 확인 메서드
	@PutMapping("/api/{userId}/password")
	@ResponseBody
	public ResponseEntity<String> getPassword(@PathVariable String userId, @RequestBody Map<String, String> request){
		String currentPassword = request.get("currentPassword");
		String password = request.get("password");
		 
		if (currentPassword == null || currentPassword.isBlank()) {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("현재 비밀번호를 입력해주세요.");
	    }
		
		// 유저의 기존 비밀번호 가져오기
		String storedPassword = userService.getPasswordByUserId(userId);

		// 현재 비밀번호가 일치하는지 확인
	    if (!storedPassword.equals(currentPassword)) {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("현재 비밀번호가 올바르지 않습니다.");
	    }
		
	    // 현재 비밀번호와 새 비밀번호가 동일한 경우
	    if (storedPassword.equals(password)) {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("현재 비밀번호와 새 비밀번호가 동일합니다.");
	    }
		
	    if (password == null || password.isBlank()) {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("새 비밀번호를 입력해주세요.");
	    }
	    
		// 비밀번호 변경 수행
		userService.updateUserPassword(userId, password);
		
		// 변경 후, 다시 DB에서 최신 비밀번호 가져와서 업데이트가 정상적으로 되었는지 확인
	    String updatedPassword = userService.getPasswordByUserId(userId);
	    
	    if (!updatedPassword.equals(password)) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("비밀번호 변경이 실패했습니다.");
	    }
	    
		return ResponseEntity.ok("비밀번호 변경 완료");
		
	}
	
	// 마이페이지 팀원 조회 및 팀 탈퇴 API
	@DeleteMapping("/leave/{teamId}")
	@ResponseBody
	public ResponseEntity<String> leaveTeam(@PathVariable Integer teamId, HttpSession session) {
		String userId = (String) session.getAttribute("signedInUserId");
		log.debug("팀 ID: {}, 유저 ID: {}", teamId, userId);
		
		// 팀 떠나기
		teamService.deleteTeamMember(teamId, userId);
		return ResponseEntity.ok("팀을 탈퇴하였습니다.");
	}

	// 마이페이지 팀장 조회 및 팀 삭제 API
	@DeleteMapping("/delete/{teamId}")
	@ResponseBody
	public ResponseEntity<String> deleteTeam(@PathVariable Integer teamId, HttpSession session) {
		String userId = (String) session.getAttribute("signedInUserId");
		log.debug("팀 ID: {}, 유저 ID: {}", teamId, userId);

		// 팀장 체크
		Integer teamLeaderCheck = teamService.selectTeamLeaderCheck(teamId, userId);
		if (teamLeaderCheck == null || teamLeaderCheck != 1) {
		    return ResponseEntity.status(HttpStatus.FORBIDDEN)
		            .body("팀 삭제가 불가능합니다. 팀장만 삭제할 수 있습니다.");
		}
		
		// 팀장이 삭제하기
		teamService.deleteTeamLeader(teamId);
		return ResponseEntity.ok("팀을 삭제하였습니다.");
	}
	
	//  ---------------------------------- 중복체크 ---------------------------------------// 
	
	// 사용자 아이디 중복체크
	@GetMapping("/checkuserid")
	@ResponseBody
	public ResponseEntity<String> checkUserId(@RequestParam String userId) {
		log.debug("checkUsername(username={})", userId);
		boolean result = userService.checkUserId(userId);
		
		return result ? ResponseEntity.ok("Y") : ResponseEntity.ok("N");
	}
	// 사용자 닉네임 중복체크
	@GetMapping("/checknickname")
	@ResponseBody
	public ResponseEntity<String> checkNickname(@RequestParam String nickname) {
		log.debug("checkNickname(nickname={})", nickname);
		boolean result = userService.checkNickname(nickname);
		
		return result ? ResponseEntity.ok("Y") : ResponseEntity.ok("N");
	}
	// 이메일 중복체크
	@GetMapping("/checkemail")
	@ResponseBody
	public ResponseEntity<String> checkEmail(@RequestParam String email){
		log.debug("checkEmail(email={})",email);
		boolean result = userService.checkEmail(email);
		
		return result ? ResponseEntity.ok("Y") : ResponseEntity.ok("N");
	}
	// 휴대전화번호 중복체크
	@GetMapping("/checkphonenumber")
	@ResponseBody
	public ResponseEntity<String> checkPhoneNumber(@RequestParam String phonenumber){
		log.debug("checkPhoneNumber(phonenumber={})",phonenumber);
		boolean result = userService.checkPhoneNumber(phonenumber);
		
		return result ? ResponseEntity.ok("Y") : ResponseEntity.ok("N");
	}
}
