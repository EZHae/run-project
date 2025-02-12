<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>${gPost.title}:Running</title>

<!-- Bootstrap CSS 링크 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<div class="container-fluid">
		<c:set var="pageTitle" value="글 상세보기" />
	</div>
	<div class="container my-3">
		<div class="row d-flex justify-content-center">
			<div class="col-md-12 col-lg-10 col-xl-8">
				<div class="card p-4">

					<!-- 제목 -->
					<h3 class="mb-2 fw-bold">${gPost.title}</h3>

					<!-- 작성자 정보 (이미지 + 닉네임 + 작성 시간) -->
					<div class="d-flex align-items-center text-muted small mb-3">
						<img class="rounded-circle me-2"
							src="/running/image/view/user/${gPost.userId}" alt="avatar"
							width="35" height="35"> <span>${gPost.nickname} •
							${gPost.formattedCreatedTime}에 작성</span>
					</div>

					<!-- 내용 -->
					<p class="mb-4">${gPost.content}</p>

					<!-- 첨부파일 -->
					<div class="mt-4">
						<label class="form-label fw-bold">첨부파일</label>
						<c:choose>
							<c:when test="${empty gImages}">
								<p class="text-muted">파일이 없습니다.</p>
							</c:when>
							<c:otherwise>
								<ul class="list-group list-group-flush">
									<c:forEach var="images" items="${gImages}">
										<li class="list-group-item d-flex align-items-center"><img
											alt="${images.originName}" class="rounded me-2"
											src="/running/gpost/uploads/${images.uniqName}"
											style="width: 50px; height: 50px;"> <span
											class="me-auto">${images.originName}</span> <a
											class="downloadLink btn btn-sm btn-outline-primary"
											href="${pageContext.request.contextPath}/gpost/download/${images.uniqName}">다운로드</a>
										</li>
									</c:forEach>
								</ul>
							</c:otherwise>
						</c:choose>
					</div>

					<!-- 수정하기 버튼 (작성자 본인만 보이게) -->
					<c:if test="${signedInUserId eq gPost.userId}">
						<div class="d-flex justify-content-center mt-4">
							<c:url var="gPostModifyPage" value="/gpost/modify">
								<c:param name="id" value="${gPost.id}" />
							</c:url>
							<a class="btn btn-outline-success" href="${gPostModifyPage}">수정하기</a>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>






	<!-- comment 작성 -->
	<c:if test="${not empty signedInUserNickname}">
		<div class="container my-1 py-1">
			<div class="row d-flex justify-content-center">
				<div class="col-md-12 col-lg-10 col-xl-8">
					<div class="card p-4">
						<div class="comment-container mt-3">
							<div class="d-flex flex-start">
								<!-- 유저 프로필 이미지 -->
								<img class="rounded-circle shadow-1-strong me-3"
									src="/running/image/view/user/${signedInUserId}" alt="avatar"
									width="65" height="65" />

								<div class="flex-grow-1 flex-shrink-1">
									<div>
										<div class="d-flex justify-content-between align-items-center">
											<p class="mb-1 fw-bold">${signedInUserNickname}</p>
										</div>

										<!-- 댓글 작성 폼 -->
										<div class="mb-3">
											<textarea class="form-control" id="ctext" rows="3"
												placeholder="댓글을 입력하세요..."></textarea>
										</div>

										<!-- 비밀댓글 체크박스 -->
										<div class="form-check mb-2">
											<input class="form-check-input" type="checkbox" id="secret"
												name="secret" /> <label
												class="form-check-label text-muted small" for="secret">
												비밀댓글 </label>
										</div>

										<!-- 댓글 작성 버튼 -->
										<button type="submit" class="btn btn-primary btn-sm"
											id="btnRegisterComment">댓글 작성</button>
									</div>
								</div>
							</div>
							<!-- d-flex 종료 -->
						</div>
						<!-- comment-container 종료 -->
					</div>
					<!-- card 종료 -->
				</div>
			</div>
		</div>

	</c:if>

	<!-- comment section js-->
	<section class="gradient-custom" id="commentSection"></section>

	<script>
		//세션에 저장된 로그인 사용자 아이디를 자바스크립트 변수에 저장.
		//->comment.js 파일의 코드들에서 그 변수를 사용할 수 있도록 하기 위해서
		const signedInUserId = '${signedInUserId}';//문자열 포맷으로 변수를 저장.
		const signedInUserNickname = '${signedInUserNickname}';
		const postId = '${gPost.id}';
		const postUserId = '${gPost.userId}';
	</script>

	<!-- Axios Http Js-->
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

	<c:url value="/js/comment.js" var="commentJs" />
	<script src="${commentJs}"></script>

	<c:url value="/js/gpost_details.js" var="gPostDetailsJS" />
	<script src="${gPostDetailsJS}"></script>

	
	<%@ include file="../fragments/footer.jspf"%>
	<!-- Bootstrap JS 링크 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous">
		
	</script>
</body>
</html>