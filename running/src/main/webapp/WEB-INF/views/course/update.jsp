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
</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<div class="container-fluid">
		<c:set var="pageTitle" value="코스 수정" />
	</div>

	<div class="container">
		<div class="row d-flex justify-content-center">
			<div class="col-md-12 col-lg-10 col-xl-8">
				<div class="card p-4 shadow-sm">
					<div class="card-body">
						<h1 class="text-center text-success mb-4">코스 업데이트</h1>

						<form id="updateForm">
							<!-- ID (숨김 필드) -->
							<input class="d-none" id="id" name="id" type="text"
								value="${course.id}">

							<!-- 제목 입력 -->
							<div class="mb-3">
								<label for="title" class="form-label">제목</label> <input
									id="title" name="title" type="text" class="form-control"
									value="${course.title}" required>
							</div>

							<!-- 코스명 입력 -->
							<div class="mb-3">
								<label for="courseName" class="form-label">코스명</label> <input
									id="courseName" name="courseName" type="text"
									class="form-control" value="${course.courseName}" required>
							</div>

							<!-- 소요시간 입력 -->
							<div class="mb-3">
								<label for="durationTime" class="form-label">소요시간</label> <input
									id="durationTime" name="durationTime" type="text"
									class="form-control" value="${course.durationTime}" required>
							</div>

							<!-- 내용 입력 -->
							<div class="mb-3">
								<label for="content" class="form-label">내용</label> <input
									id="content" name="content" type="text" class="form-control"
									value="${course.content}" required>
							</div>

							<!-- 카테고리 선택 -->
							<div class="mb-3">
								<input class="d-none" id="category" value="${course.category}">
								<input id="categoryRec" name="category" type="radio" value="0">
								<label for="categoryRec">코스 추천</label> <input id="categoryRev"
									name="category" type="radio" value="1"> <label
									for="categoryRev">코스 리뷰</label> <br>
							</div>
						</form>
						<c:if test="${signedInUserId eq course.userId}">
							<button class="btn btn-secondary" id="btnUpdate">수정</button>
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

	<c:url var="updateJS" value="/js/course-update.js" />
	<script src="${updateJS}"></script>
</body>
</html>