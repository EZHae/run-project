<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Running</title>

<!-- Bootstrap CSS 링크 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<div class="container-fluid">
		<c:set var="pageTitle" value="코스 상세보기" />
	</div>

	<div class="container">
		<!-- 코스 상세보기 -->
		<div class="row d-flex justify-content-center">
			<div class="col-md-12 col-lg-10 col-xl-8 mt-4">
				<div class="card p-4 shadow-sm mt-6">
					<div class="card-body">
						<!-- 제목 -->
						<h1 class="text-center text-success mb-4">${course.title}</h1>

						<!-- 코스 아이디 -->
						<div class="mb-3">
							<span class="fw-bold">코스 아이디 <span id="id">${course.id}</span></span>
							<br>
						</div>

						<!-- 코스 작성자 아이디 -->
						<div class="mb-3">
							<span class="fw-bold">코스 작성자 아이디 <span id="userId">${course.userId}</span></span>
							<br>
						</div>

						<!-- 코스 작성자 닉네임 -->
						<div class="mb-3">
							<span class="fw-bold">코스 작성자 닉네임 </span> <span>${course.nickname}</span>
						</div>

						<!-- 코스 이름 -->
						<div class="mb-3">
							<span class="fw-bold">코스이름 </span> <span>${course.courseName}</span>
						</div>

						<!-- 소요 시간 -->
						<div class="mb-3">
							<span class="fw-bold">소요 시간 </span> <span>${course.durationTime}</span>
						</div>

						<!-- 코스 내용 -->
						<div class="mb-3">
							<span class="fw-bold">코스 내용 </span> <span>${course.content}</span>
						</div>

						<!-- 코스 분류 -->
						<div class="mb-3">
							<span class="fw-bold">코스 분류 0: 추천, 1: 리뷰 </span> <span>${course.category}</span>
						</div>

						<!-- 조회수 -->
						<div class="mb-3">
							<span class="fw-bold">조회수 </span> <span>${course.viewCount}</span>
						</div>

						<!-- 좋아요 수 -->
						<div class="mb-3">
							<span class="fw-bold">좋아요 수 </span> <span>${course.likeCount}</span>
						</div>

						<!-- 작성 시간 -->
						<div class="mb-3">
							<span class="fw-bold">작성 시간 </span> <span>${course.formattedCreatedTime}</span>
						</div>

						<!-- 최종 수정 시간 -->
						<div class="mb-3">
							<span class="fw-bold">최종 수정 시간 </span> <span>${course.formattedModifiedTime}</span>
						</div>



						<!-- 좋아요 버튼을 js로 처리 -->
						<button class="btn btn-outline-success ms-2" id="btnLike">
							<i class="fas fa-thumbs-up"
								style="color: #ffcc00; font-size: 18px;"></i> 좋아요
						</button>

						<c:if test="${signedInUserId eq course.userId}">
							<c:url var="courseUpdatePage" value="/course/update">
								<c:param name="id" value="${course.id}" />
							</c:url>
							<a class="btn btn-success" href="${courseUpdatePage}">수정</a>

							<button class="btn btn-danger" id="btnDelete">삭제</button>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../fragments/footer.jspf"%>
	<!-- Bootstrap JS 링크 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous">
		
	</script>

	<script>
		const signedInUserId = '${signedInUserId}';
		const likeUserIds = '${likeUserIds}'.split(',');
	</script>
	<c:url var="detailsJS" value="/js/course-details.js" />
	<script src="${detailsJS}"></script>
</body>
</html>