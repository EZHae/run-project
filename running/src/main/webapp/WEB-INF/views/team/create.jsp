<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>새 팀 생성</title>

<!-- Bootstrap CSS 링크. -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>
<body class="container mt-5">
	<c:url var="courseRecruitPage" value="/team/list" />
	<a href="${courseRecruitPage}">팀 목록</a>

	<h2 class="mb-4">팀 생성</h2>
	<form action="/team/create" method="post">
		<!-- 팀 이름 -->
		<div class="mb-3">
			<label for="teamName" class="form-label">팀 이름</label> <input
				type="text" id="teamName" name="teamName" class="form-control"
				required>
		</div>

		<!-- 제목 -->
		<div class="mb-3">
			<label for="title" class="form-label">제목</label> <input type="text"
				id="title" name="title" class="form-control" required>
		</div>

		<!-- 내용 -->
		<div class="mb-3">
			<label for="content" class="form-label">내용</label>
			<textarea id="content" name="content" class="form-control" rows="4"
				required></textarea>
		</div>

		<!-- 구 선택 -->
		<div class="mb-3">
			<label for="districtSelect" class="form-label">구 선택</label> <select
				id="districtSelect" class="form-select" required>
				<option value="">구를 선택하세요</option>
				<option value="seoul">서울</option>
				<option value="busan">부산</option>
				<option value="incheon">인천</option>
			</select>
		</div>

		<!-- 공원 선택 -->
		<div class="mb-3">
			<label for="parkId" class="form-label">공원 선택</label> <select
				id="parkId" name="parkId" class="form-select" required>
				<option value="">먼저 구를 선택하세요</option>
			</select>
		</div>
		<!-- 최대 인원 -->
		<div class="mb-3">
			<label for="maxNum" class="form-label">본인을 포함한 최대 인원</label> <input
				type="number" id="maxNum" name="maxNum" class="form-control" min="1"
				required>
		</div>

		<!-- 연령 제한 -->
		<div class="mb-3">
			<label for="ageLimit" class="form-label">연령 제한</label> <input
				type="number" id="ageLimit" name="ageLimit" class="form-control"
				min="0" placeholder="예: 20 (20세 이상)" required>
		</div>

		<!-- 성별 제한 -->
		<div class="mb-3">
			<label for="genderLimit" class="form-label">성별 제한</label> <select
				id="genderLimit" name="genderLimit" class="form-select" required>
				<option value="0">성별 무관</option>
				<option value="1">남성만</option>
				<option value="2">여성만</option>
			</select>
		</div>

		<!-- 제출 버튼 -->
		<button type="submit" class="btn btn-primary w-100">팀 생성</button>
	</form>

	<!-- Bootstrap Javascript  -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>