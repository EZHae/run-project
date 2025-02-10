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
		<div class="container-fluid">
            <c:set var="pageTitle" value="팀 목록" />
        </div>

	<c:forEach items="${teamItemDtoList}" var="team">
		<c:url var="teamDetailPage" value="/team/details">
			<c:param name="teamid" value="${team.teamId}" />
		</c:url>
		<a href="${teamDetailPage}">${team.teamName}</a>
	</c:forEach>

	<div>
		<c:url var="teamCreatePage" value="/team/create" />
		<a href="${teamCreatePage}">새 팀 생성</a>
	</div>

	<div>
		<c:url value="/team/list" var="teamListUrl">
			<c:param name="status" value="open" />
		</c:url>
		<c:url value="/team/list" var="closedListUrl">
			<c:param name="status" value="closed" />
		</c:url>
		<div>
			<a href="${teamListUrl}">
				<button style="${status eq 'open' }">모집중</button>
			</a> <a href="${closedListUrl}">
				<button style="${status eq 'closed'}">모집완료</button>
			</a>
		</div>

		<div class="container mt-5">
			<c:url value="/team/search" var="teamSearchPage" />
			<form action="${teamSearchPage}" method="get" id="searchForm">
				<select class="form-select mb-2" id="status"
					name="status">
					<option value="open" selected>모집중</option>
					<option value="closed">모집완료</option>
				</select> <select class="form-select mb-2" id="seoul-districts"
					name="district">
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
				</select> <input type="text" id="keyword" name="keyword"
					class="form-control mb-2" placeholder="팀 이름으로 검색이 가능합니다">
				<button id="searchButton" class="btn btn-secondary">검색</button>
			</form>
		</div>

		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>팀이름</th>
					<th>작성자</th>
					<th>인원수</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${teams}" var="team">
					<tr>
						<td>${team.teamId}</td>
						<td><c:url var="teamDetailPage" value="/team/details">
								<c:param name="teamid" value="${team.teamId}" />
							</c:url> <a href="${teamDetailPage}">${team.teamName}</a></td>
						<td>${team.userId}</td>
						<td>${team.currentNum}/${team.maxNum}</td>
						<td>${team.createdTime}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	


	<!-- Bootstrap Javascript  -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>