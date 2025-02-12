<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		<c:set var="pageTitle" value="새 코스 작성" />
	</div>

	<div class="container">
		<div class="row d-flex justify-content-center">
			<div class="col-md-12 col-lg-10 col-xl-8">
				<div class="card p-4 shadow-sm">
					<div class="card-body">
						<h1 class="text-center text-success mb-4">새 코스 작성</h1>

						<c:url value="/course/create" var="courseCreatePage" />
						<form action="${courseCreatePage}" method="post">
							<!-- 카테고리 선택 -->
							<div class="mb-3">
								<label for="categoryRec" class="form-label">카테고리</label><br>
								<input id="categoryRec" name="category" type="radio" value="0"
									checked> <label for="categoryRec">코스 추천</label> <input
									id="categoryRev" name="category" type="radio" value="1">
								<label for="categoryRev">코스 리뷰</label>
							</div>

							<!-- 제목 입력 -->
							<div class="mb-3">
								<label for="title" class="form-label">제목</label> <input
									id="title" name="title" type="text" class="form-control"
									value="${course.title}" placeholder="제목" required>
							</div>

							<!-- 코스명 입력 -->
							<div class="mb-3">
								<label for="courseName" class="form-label">코스명</label> <input
									id="courseName" name="courseName" type="text"
									class="form-control" value="${course.courseName}"
									placeholder="코스명" required>
							</div>

							<!-- 소요시간 입력 -->
							<div class="mb-3">
								<label for="durationTime" class="form-label">소요시간</label> <input
									id="durationTime" name="durationTime" type="text"
									class="form-control" value="${course.durationTime}"
									placeholder="소요시간" required>
							</div>

							<!-- 내용 입력 -->
							<div class="mb-3">
								<label for="content" class="form-label">내용</label> <input
									id="content" name="content" type="text" class="form-control"
									value="${course.content}" placeholder="내용" required>
							</div>

							<!-- userId (숨김 필드) -->
							<input class="d-none" id="userId" type="text" name="userId"
								value="${signedInUserId}" readonly>

							<!-- 닉네임 (읽기 전용 필드) -->
							<div class="mb-3">
								<label for="nickname" class="form-label">작성자 닉네임</label> <input
									id="nickname" type="text" name="nickname" class="form-control"
									value="${signedInUserNickname}" readonly>
							</div>

							<!-- 제출 버튼 -->
							<div class="text-center">
								<button type="submit" class="btn btn-success">작성완료</button>
							</div>
						</form>
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
</body>
</html>