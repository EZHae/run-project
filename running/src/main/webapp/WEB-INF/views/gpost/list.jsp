<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>자유게시판 : Running</title>

<!-- Bootstrap CSS 링크 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<style>
/* 클릭된 링크에 대해 색상 변경 */
/* 클릭된 페이지 번호 버튼에 대해 색상과 배경 색상 변경 */
.page-item.active .page-link {
	color: #28a745; /* 텍스트 색상 */
	background-color: transparent; /* 배경색을 투명하게 유지 */
	border-color: #28a745; /* 테두리 색상 */
}

/* 페이지 링크가 클릭되었을 때 */
.page-link:active {
	color: #28a745; /* 클릭했을 때 텍스트 색상 */
	background-color: transparent; /* 클릭했을 때 배경색 */
	border-color: #28a745; /* 클릭했을 때 테두리 색상 */
}
</style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet">
</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<div class="container-fluid">
		<c:set var="pageTitle" value="글 목록" />
	</div>

	<div class="container-fluid">
		<main class="mt-3">
			<c:url value="/gpost/list" var="gPostGategoryPage" />
			<form action="${gPostGategoryPage}" method="get" id="searchForm">
				<input type="hidden" name="category" id="categoryInput"
					value="${param.category != null ? param.category : 0}">

				<div class="d-flex align-items-center mb-3">
					<!-- 검색 타입 선택 (폭을 좁게 설정) -->
					<select id="searchType" class="form-select me-3" name="search"
						style="width: 120px;">
						<option value="t" ${param.search eq 't' ? 'selected' : ''}>제목</option>
						<option value="c" ${param.search eq 'c' ? 'selected' : ''}>내용</option>
						<option value="tc" ${param.search eq 'tc' ? 'selected' : ''}>제목+내용</option>
						<option value="n" ${param.search eq 'n' ? 'selected' : ''}>작성자</option>
					</select>

					<!-- 검색어 입력 -->
					<input type="text" name="keyword" class="form-control me-3"
						placeholder="검색, 공백 가능" aria-label="검색어">

					<!-- 검색 버튼 (돋보기 아이콘 추가) -->
					<button id="searchButton" class="btn btn-success text-white">
						<i class="bi bi-search"></i>
						<!-- 돋보기 아이콘 -->
					</button>
				</div>
			</form>

			<!-- 버튼: 자유, 질문 -->
			<div class="mb-3">
				<button type="button" onclick="setCategory(0)"
					class="btn btn-outline-success me-2">자유</button>
				<button type="button" onclick="setCategory(1)"
					class="btn btn-outline-success">질문</button>
			</div>

			<!-- 카드 -->
			<div class="card mt-3">
				<div class="card-body">
					<table class="table table-striped table-hover">
						<thead class="table-success">
							<tr>
								<th>제목</th>
								<th>작성자</th>
								<th>조회수</th>
								<th>작성시간</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${gPosts}" var="p">
								<tr>
									<td><c:url var="gPostDetailsPage" value="/gpost/details">
											<c:param name="id" value="${p.id}" />
										</c:url> <a href="${gPostDetailsPage}" class="text-success">${p.title}</a></td>
									<td>${p.nickname}</td>
									<td>${p.viewCount}</td>
									<td>${p.formattedModifiedTime}</td>
								</tr>
							</c:forEach>
							<c:if test="${empty gPosts}">
								<tr>
									<td colspan="4">검색 결과가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<div class="card-footer d-flex justify-content-end">
					<c:url var="gPostCreatePage" value="/gpost/create" />
					<a href="${gPostCreatePage}" class="me-2 btn btn-outline-success">글쓰기</a>
				</div>
			</div>
		</main>
	</div>

	<!-- 페이징 처리 -->
	<div class="mt-3">
		<nav aria-label="Page navigation">
			<ul class="pagination d-flex justify-content-center">
				<!-- 맨 처음 페이지 버튼 -->
				<li class="page-item"><c:choose>
						<c:when test="${type == '/running/gpost/search'}">
							<c:url var="firstPage" value="/gpost/search">
								<c:param name="offset" value="0" />
								<c:param name="limit" value="${limit}" />
								<c:if test="${not empty category}">
									<c:param name="category" value="${category}" />
								</c:if>
								<c:if test="${not empty search}">
									<c:param name="search" value="${search}" />
								</c:if>
								<c:if test="${not empty keyword}">
									<c:param name="keyword" value="${keyword}" />
								</c:if>
							</c:url>
						</c:when>
						<c:otherwise>
							<c:url var="firstPage" value="/gpost/list">
								<c:param name="offset" value="0" />
								<c:param name="limit" value="${limit}" />
								<c:param name="category" value="${category}" />
								<c:param name="search" value="${search}" />
								<c:param name="keyword" value="${keyword}" />
							</c:url>
						</c:otherwise>
					</c:choose> <a class="page-link text-success" href="${firstPage}"
					aria-label="First"> <span aria-hidden="true">&laquo;&laquo;
							First</span>
				</a></li>

				<!-- 이전 페이지 버튼 -->
				<c:if test="${offset > 0}">
					<li class="page-item"><c:choose>
							<c:when test="${type == '/running/gpost/search'}">
								<c:url var="prevPage" value="/gpost/search">
									<c:param name="offset" value="${offset - limit}" />
									<c:param name="limit" value="${limit}" />
									<c:if test="${not empty category}">
										<c:param name="category" value="${category}" />
									</c:if>
									<c:if test="${not empty search}">
										<c:param name="search" value="${search}" />
									</c:if>
									<c:if test="${not empty keyword}">
										<c:param name="keyword" value="${keyword}" />
									</c:if>
								</c:url>
							</c:when>
							<c:otherwise>
								<c:url var="prevPage" value="/gpost/list">
									<c:param name="offset" value="${offset - limit}" />
									<c:param name="limit" value="${limit}" />
								</c:url>
							</c:otherwise>
						</c:choose> <a class="page-link text-success" href="${prevPage}"
						aria-label="Previous"> <span aria-hidden="true">&laquo;
								Previous</span>
					</a></li>
				</c:if>

				<!-- 페이지 번호 버튼 -->
				<c:if test="${totalPages > 0}">
					<c:forEach begin="0" end="${totalPages-1}" var="page">
						<li class="page-item ${page * limit == offset ? 'active' : ''}">
							<c:choose>
								<c:when test="${type == '/running/gpost/search'}">
									<c:url var="pageUrl" value="/gpost/search">
										<c:param name="offset" value="${page * limit}" />
										<c:param name="limit" value="${limit}" />
										<c:if test="${not empty category}">
											<c:param name="category" value="${category}" />
										</c:if>
										<c:if test="${not empty search}">
											<c:param name="search" value="${search}" />
										</c:if>
										<c:if test="${not empty keyword}">
											<c:param name="keyword" value="${keyword}" />
										</c:if>
									</c:url>
								</c:when>
								<c:otherwise>
									<c:url var="pageUrl" value="/gpost/list">
										<c:param name="offset" value="${page * limit}" />
										<c:param name="limit" value="${limit}" />
										<c:param name="category" value="${category}" />
										<c:param name="search" value="${search}" />
										<c:param name="keyword" value="${keyword}" />
									</c:url>
								</c:otherwise>
							</c:choose> <a class="page-link text-success" href="${pageUrl}">${page + 1}</a>
						</li>
					</c:forEach>
				</c:if>

				<!-- 다음 페이지 버튼 -->
				<c:if test="${offset + limit < totalPosts}">
					<li class="page-item"><c:choose>
							<c:when test="${type == '/running/gpost/search'}">
								<c:url var="nextPage" value="/gpost/search">
									<c:param name="offset" value="${offset + limit}" />
									<c:param name="limit" value="${limit}" />
									<c:if test="${not empty category}">
										<c:param name="category" value="${category}" />
									</c:if>
									<c:if test="${not empty search}">
										<c:param name="search" value="${search}" />
									</c:if>
									<c:if test="${not empty keyword}">
										<c:param name="keyword" value="${keyword}" />
									</c:if>
								</c:url>
							</c:when>
							<c:otherwise>
								<c:url var="nextPage" value="/gpost/list">
									<c:param name="offset" value="${offset + limit}" />
									<c:param name="limit" value="${limit}" />
									<c:param name="category" value="${category}" />
									<c:param name="search" value="${search}" />
									<c:param name="keyword" value="${keyword}" />
								</c:url>
							</c:otherwise>
						</c:choose> <a class="page-link text-success" href="${nextPage}"
						aria-label="Next"> <span aria-hidden="true">Next
								&raquo;</span>
					</a></li>
				</c:if>

				<!-- 맨 마지막 페이지 버튼 -->
				<li class="page-item"><c:choose>
						<c:when test="${type == '/running/gpost/search'}">
							<c:url var="lastPage" value="/gpost/search">
								<c:param name="offset" value="${(totalPages - 1) * limit}" />
								<c:param name="limit" value="${limit}" />
								<c:if test="${not empty category}">
									<c:param name="category" value="${category}" />
								</c:if>
								<c:if test="${not empty search}">
									<c:param name="search" value="${search}" />
								</c:if>
								<c:if test="${not empty keyword}">
									<c:param name="keyword" value="${keyword}" />
								</c:if>
							</c:url>
						</c:when>
						<c:otherwise>
							<c:url var="lastPage" value="/gpost/list">
								<c:param name="offset" value="${(totalPages - 1) * limit}" />
								<c:param name="limit" value="${limit}" />
								<c:param name="category" value="${category}" />
								<c:param name="search" value="${search}" />
								<c:param name="keyword" value="${keyword}" />
							</c:url>
						</c:otherwise>
					</c:choose> <a class="page-link text-success" href="${lastPage}"
					aria-label="Last"> <span aria-hidden="true">Last
							&raquo;&raquo;</span>
				</a></li>
			</ul>
		</nav>

	</div>

	<!-- Bootstrap JS 링크 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous">
		
	</script>
	<!-- Axios Http JS -->
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

	<c:url var="gPostListJS" value="/js/gpost_list.js" />
	<script src="${gPostListJS}"></script>
</body>
</html>