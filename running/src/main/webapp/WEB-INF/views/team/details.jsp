<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<!-- Bootstrap CSS 링크. -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>
<body class="container mt-5">

	<%@ include file="../fragments/header.jspf"%>

	<main class="container my-3">
		<div class="row d-flex justify-content-center">
			<div class="col-md-12 col-lg-10 col-xl-8">
				<!-- 팀 제목 -->
				<div class="card shadow-lg p-4 border-0 rounded-4">
					<!-- 팀 제목 -->
					<div class="text-center mb-4">
						<h2 class="fw-bold text-success">${teamItemDto.title}</h2>
					</div>

					<!-- 팀 배너 이미지 -->
					<div class="text-center">
						<img src="${teamItemDto.imagePath}"
							class="img-fluid rounded-4 shadow-sm" alt="팀 배너" />
					</div>

					<!-- 팀 정보 -->
					<div class="bg-light p-4 rounded-4 mt-4 shadow-sm">
						<h4 class="text-success fw-bold">Team:
							${teamItemDto.teamName}</h4>
						<p class="text-muted">
							팀장: <span class="fw-bold">${teamItemDto.nickname}</span>
						</p>
					</div>

					<!-- 팀 설명 -->
					<div class="bg-white p-4 rounded-4 mt-3 shadow-sm">
						<h5 class="fw-bold text-secondary">팀 소개</h5>
						<p class="text-muted">${teamItemDto.content}</p>
					</div>

					<!-- 공원 이름 -->
					<div class="text-center mt-3">
						<span class="badge bg-primary fs-6">📍 ${park.parkName}</span>
					</div>

					<!-- 성별 제한 -->
					<div class="bg-white p-4 rounded-4 mt-3 shadow-sm">
						<h5 class="fw-bold text-secondary">성별 제한</h5>
						<c:choose>
							<c:when test="${teamItemDto.genderLimit==0}">
								<p class="text-muted">🚻 제한 없음</p>
							</c:when>
							<c:when test="${teamItemDto.genderLimit==1}">
								<p class="text-muted">👨 남성만</p>
							</c:when>
							<c:when test="${teamItemDto.genderLimit==2}">
								<p class="text-muted">👩 여성만</p>
							</c:when>
						</c:choose>
					</div>

					<!-- 연령 제한 -->
					<div class="bg-white p-4 rounded-4 mt-3 shadow-sm">
						<h5 class="fw-bold text-secondary">연령 제한</h5>
						<p class="text-muted">🎂 ${teamItemDto.ageLimit}살 이상</p>
					</div>
				</div>



				<div class="mt-3 d-flex justify-content-center">
					<div class="btn-group" role="group">
						<c:url var="postListPage"
							value="/teampage/${teamItemDto.teamId}/post/list" />
						<a href="${postListPage}" class="btn btn-success mx-2">팀 게시판</a>

						<c:url var="imageListPage"
							value="/teampage/${teamItemDto.teamId}/image/list" />
						<a href="${imageListPage}" class="btn btn-success mx-2">팀 앨범</a>

						<c:url var="calendarListPage"
							value="/teampage/${teamItemDto.teamId}/tcalendar/list" />
						<a href="${calendarListPage}" class="btn btn-success mx-2">팀
							일정게시판</a>

					</div>
				</div>


				<!-- 신청/수락/취소과 관련된 구간 -->
				<section id="teamApplication"
					class="mt-4 p-4 border border-dark rounded">
					<h5>회원 신청/수락/취소 구간</h5>
					<c:choose>
						<c:when test="${not empty signedInUserId}">
							<c:set var="canApply" value="true" />
							<c:forEach items="${tmembers}" var="tmem">
								<c:if test="${tmem.userId == signedInUserId}">
									<c:set var="canApply" value="false" />
								</c:if>
							</c:forEach>
							<c:forEach items="${tappList}" var="tapp">
								<c:if test="${tapp.userId==signedInUserId}">
									<!-- 신청한이력이있는경우 -->
									<c:set var="alreadyApplied" value="true" />
								</c:if>
							</c:forEach>
							<c:choose>
								<c:when test="${signedInUserId==teamItemDto.userId}" />
								<c:when
									test="${!alreadyApplied && canApply 
                        && user.age >= teamItemDto.ageLimit
                        && (user.gender == teamItemDto.genderLimit || teamItemDto.genderLimit == 0)}">
									<button data-bs-toggle="modal"
										data-bs-target="#applicationModal" class="btn"
										style="background-color: #28a745; color: white;">가입신청</button>
								</c:when>
								<c:when test="${alreadyApplied}">
									<button id="applyCancelButton" class="btn btn-danger">가입신청취소</button>
								</c:when>
								<c:otherwise>
									<p class="text-danger">가입 신청 대상이 아닙니다</p>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<p class="text-danger">로그인 후 이용 가능합니다</p>
						</c:otherwise>
					</c:choose>

					<!-- 회원신청모달 -->
					<div class="modal fade" id="applicationModal" tabindex="-1"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLabel">회원신청하기</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<form>
										<div class="mb-3">
											<label for="recipient-name" class="col-form-label">러닝팀:</label>
											<input readonly type="text" value="${teamItemDto.teamName}"
												class="form-control" id="recipient-name">
										</div>
										<div class="mb-3">
											<label for="message-text" class="col-form-label">간단한
												인사:</label>
											<textarea class="form-control" id="message-text"
												placeholder="100자 이내로 작성하세요."></textarea>
											<p class="text-danger">개인정보를 적지마세요!</p>
										</div>
									</form>
								</div>
								<div class="modal-footer">
									<button type="button" id="applyButton" class="btn btn-primary">신청</button>
								</div>
							</div>
						</div>
					</div>
				</section>

				<!-- 현재까지 팀 멤버수와 신청가능한 인원수-->
				<section id="currentMembers"
					class="mt-4 p-4 border border-dark rounded">
					<h5>현재까지 회원수</h5>
					<h6>${tmembers.size()}/${teamItemDto.maxNum}</h6>
				</section>

				<!-- 회원관리 모달창 -->
				<div class="modal fade" id="memberManageModal"
					data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
					aria-labelledby="staticBackdropLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-scrollable">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="staticBackdropLabel">회원 관리</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<c:forEach items="${tmembers}" var="tmember">
									<c:if test="${tmember.leaderCheck==0}">
										<div class="mt-2">${tmember.nickname}
											<button id="forceToResignButton"
												data-name="${tmember.nickname}" data-id="${tmember.userId}"
												class="btn btn-danger m-2">강제탈퇴</button>
										</div>
									</c:if>
								</c:forEach>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">닫기</button>
							</div>
						</div>
					</div>
				</div>

				<!-- 팀장만 보이는 구간 -->
				<c:if test="${signedInUserId==teamItemDto.userId}">
					<section class="mt-4 p-4 border border-dark rounded">
						<h5>팀장 구간</h5>
						<section id="applicationControl" class="mt-4 p-2">
							<h6>현재 신청 회원 목록</h6>
							<c:forEach items="${tappList}" var="app">
								<div class="mt-2">
									<span>닉네임-${app.nickname}</span> <span>소개-${app.introMsg}</span>
									<button id="applyConfirmButton" data-id="${app.userId}"
										data-name="${app.nickname}" class="btn-outline-success">수락</button>
									<button id="applyDeclineButton" data-id="${app.userId}"
										data-name="${app.nickname}" class="btn btn-outline-danger">거절</button>
								</div>
							</c:forEach>
						</section>
						<section id="memberControl" class="mt-4 p-2">
							<button type="button" class="btn btn btn-outline-success"
								data-bs-toggle="modal" data-bs-target="#memberManageModal">회원관리</button>
						</section>
						<section id="teamControl" class="mt-4 p-2">
							<button id="btnTeamUpdate" class="btn btn-outline-warning">팀
								수정</button>
							<button id="btnTeamDelete" class="btn btn btn-outline-danger">팀
								삭제</button>
						</section>
					</section>
				</c:if>
			</div>
		</div>
	</main>


	<script>
		//세션에 저장된 로그인 사용자 아이디를 자바스크립트 변수에 저장.
		const signedInUserId = '${signedInUserId}';//문자열 포맷으로 변수를 저장.
		const signedInUserNickname = '${signedInUserNickname}';
		const teamId = '${teamItemDto.teamId}';
		const teamName = '${teamItemDto.teamName}';
		const tmemNum = '${tmembers.size()}';
		const teamLeaderId = '${teamItemDto.userId}'
	</script>

	<%@ include file="../fragments/footer.jspf"%>
	<!-- Axios Http Js-->
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

	<c:url value="/js/team-details.js" var="teamJs" />
	<script src="${teamJs}"></script>

	<!-- Bootstrap Javascript  -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

</body>
</html>