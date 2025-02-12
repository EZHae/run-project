<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>TeamLists</title>

<!-- Bootstrap CSS 링크. -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<!-- 팀 검색 폼 -->
	<div class="container mt-5">
		<c:url value="/team/search" var="teamSearchPage" />
		<form action="${teamSearchPage}" method="get" id="searchForm"
			class="d-flex justify-content-between align-items-center">

			<!-- select 박스 (작게 배치) -->
			<div class="d-flex">
				<select class="form-select form-select-sm me-2" id="status"
					name="status">
					<option value="open" selected>모집중</option>
					<option value="closed">모집완료</option>
				</select> <select class="form-select form-select-sm me-2"
					id="seoul-districts" name="district">
					<option value="all" selected>전체</option>
					<option value="강남구">강남구</option>
					<option value="강동구">강동구</option>
					<option value="강북구">강북구</option>
					<option value="강서구">강서구</option>
					<option value="관악구">관악구</option>
					<option value="광진구">광진구</option>
					<option value="구로구">구로구</option>
					<option value="금천구">금천구</option>
					<option value="노원구">노원구</option>
					<option value="도봉구">도봉구</option>
					<option value="동대문구">동대문구</option>
					<option value="동작구">동작구</option>
					<option value="마포구">마포구</option>
					<option value="서대문구">서대문구</option>
					<option value="서초구">서초구</option>
					<option value="성동구">성동구</option>
					<option value="성북구">성북구</option>
					<option value="송파구">송파구</option>
					<option value="양천구">양천구</option>
					<option value="영등포구">영등포구</option>
					<option value="용산구">용산구</option>
					<option value="은평구">은평구</option>
					<option value="종로구">종로구</option>
					<option value="중구">중구</option>
					<option value="중랑구">중랑구</option>
				</select>
			</div>

			<!-- 검색 입력 필드 -->
			<input type="text" id="keyword" name="keyword"
				class="form-control form-control-sm me-2" placeholder="팀 이름으로 검색">

			<!-- 검색 버튼 (돋보기 아이콘 추가) -->
			<button id="searchButton" class="btn btn-success btn-sm">
				<i class="bi bi-search"></i> 검색
			</button>
		</form>
	</div>



	<!-- 모집중/모집완료 필터 버튼과 새 팀 생성 버튼을 같은 행에 배치 -->
	<div class="mt-3 d-flex justify-content-between">
		<!-- 모집중/모집완료 필터 버튼 (왼쪽) -->
		<div class="ms-3">
			<c:url value="/team/list" var="teamListUrl">
				<c:param name="status" value="open" />
			</c:url>
			<c:url value="/team/list" var="closedListUrl">
				<c:param name="status" value="closed" />
			</c:url>
			<a href="${teamListUrl}">
				<button class="btn btn-outline-success me-2">모집중</button>
			</a> <a href="${closedListUrl}">
				<button class="btn btn-outline-success">모집완료</button>
			</a>
		</div>

		<!-- 새 팀 생성 버튼 (오른쪽) -->
		<div class="me-3">
			<c:url var="teamCreatePage" value="/team/create" />
			<a href="${teamCreatePage}" class="btn btn-outline-success">새 팀
				생성</a>
		</div>
	</div>


	<div class="container mt-5">
		<!-- 팀 목록 카드 형식 -->
		<div class="row">
			<c:forEach items="${teams}" var="team">
				<div class="col-md-4 mb-4">
					<!-- 팀 카드 -->
					<div class="card">
						<!-- 팀 이미지 추가 (옵션) -->
						<img src="${team.imagePath}" class="card-img-top"
							alt="${team.teamName}" style="height: 200px; object-fit: cover;">
						<div class="card-body">
							<h5 class="card-title text-success">${team.teamName}</h5>
							<p class="card-text">작성자: ${team.userId}</p>
							<p class="card-text">인원수: ${team.currentNum} / ${team.maxNum}</p>
							<p class="card-text">작성일: ${team.createdTime}</p>
							<c:url var="teamDetailPage" value="/team/details">
								<c:param name="teamid" value="${team.teamId}" />
							</c:url>
							<a href="${teamDetailPage}" class="btn btn-success">상세보기</a>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<!-- Bootstrap Javascript  -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>