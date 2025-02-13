<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet">
<style>

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
</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<div class="container-fluid">
		<c:set var="pageTitle" value="코스 목록" />
	</div>

	<div class="container my-3">
		<div class="row d-flex justify-content-center">
			<div class="col-md-12 col-lg-10 col-xl-8">
				<main class="mt-3">
					<c:url var="courseSearchPage" value="/course/search" />
					<form action="${courseSearchPage}" method="get" class="mb-3">

						<div class="d-flex align-items-center mb-3">
							<select name="category" class="form-select me-3">
								<option value="0">추천만</option>
								<option value="1">리뷰만</option>
							</select> <select name="order" class="form-select me-3">
								<option value="v">조회수 순</option>
								<option value="l">좋아요 순</option>
							</select> <input type="text" name="keyword" class="form-control me-3"
								placeholder="코스 이름 검색">


							<button type="submit" class="btn btn-success text-white">
								<i class="bi bi-search"></i>
							</button>

						</div>

					</form>

					<!-- 새글 작성 버튼 -->
					<div class="text-end mb-3">
						<c:url var="courseCreatePage" value="/course/create" />
						<a class="btn btn-outline-success" href="${courseCreatePage}">새글
							작성</a>
					</div>

					<!-- 코스 목록 -->
					<div class="card p-4 shadow-sm">
						<div class="list-group">
							<c:forEach var="course" items="${courses}">
								<c:url var="courseDetailsPage" value="/course/details">
									<c:param name="id" value="${course.id}" />
								</c:url>
								<a href="${courseDetailsPage}"
									class="list-group-item list-group-item-action">
									<h5 class="mb-1 text-success">${course.title}</h5> <small
									class="text-muted">작성자: ${course.nickname} | 조회수:
										${course.viewCount} | 좋아요: ${course.likeCount}</small>
									<p class="mb-1 mt-2">코스 이름: ${course.courseName} | 소요 시간:
										${course.durationTime}</p> <small class="text-muted">작성
										시간: ${course.formattedCreatedTime}</small>
								</a>
							</c:forEach>
							<c:if test="${empty courses}">
								<p class="text-center text-muted my-3">검색 결과가 없습니다.</p>
							</c:if>
						</div>
					</div>
				</main>
			</div>
			<!-- card 끝 -->

		</div>
	</div>


	<!-- 페이징 처리 -->
	<div class="mt-3">
		<nav aria-label="Page navigation">
			<ul class="pagination d-flex justify-content-center">
				<!-- 맨 처음 페이지 버튼 -->
				<li class="page-item"><c:choose>
						<c:when test="${type == '/running/course/search'}">
							<c:url var="firstPage" value="/course/search">
								<c:param name="offset" value="0" />
								<c:param name="limit" value="${limit}" />
								<c:if test="${not empty category}">
									<c:param name="category" value="${category}" />
								</c:if>
								<c:if test="${not empty order}">
									<c:param name="order" value="${order}" />
								</c:if>
								<c:if test="${not empty keyword}">
									<c:param name="keyword" value="${keyword}" />
								</c:if>
							</c:url>
						</c:when>
						<c:otherwise>
							<c:url var="firstPage" value="/course/list">
								<c:param name="offset" value="0" />
								<c:param name="limit" value="${limit}" />
							</c:url>
						</c:otherwise>
					</c:choose> <a class="page-link text-success" href="${firstPage}"
					aria-label="First"> <span aria-hidden="true">&laquo;&laquo;
							First</span>
				</a></li>

				<!-- 이전 페이지 버튼 -->
				<c:if test="${offset > 0}">
					<li class="page-item"><c:choose>
							<c:when test="${type == '/running/course/search'}">
								<c:url var="prevPage" value="/course/search">
									<c:param name="offset" value="${offset - limit}" />
									<c:param name="limit" value="${limit}" />
									<c:if test="${not empty category}">
										<c:param name="category" value="${category}" />
									</c:if>
									<c:if test="${not empty order}">
										<c:param name="order" value="${order}" />
									</c:if>
									<c:if test="${not empty keyword}">
										<c:param name="keyword" value="${keyword}" />
									</c:if>
								</c:url>
							</c:when>
							<c:otherwise>
								<c:url var="prevPage" value="/course/list">
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
								<c:when test="${type == '/running/course/search'}">
									<c:url var="pageUrl" value="/course/search">
										<c:param name="offset" value="${page * limit}" />
										<c:param name="limit" value="${limit}" />
										<c:if test="${not empty category}">
											<c:param name="category" value="${category}" />
										</c:if>
										<c:if test="${not empty order}">
											<c:param name="order" value="${order}" />
										</c:if>
										<c:if test="${not empty keyword}">
											<c:param name="keyword" value="${keyword}" />
										</c:if>
									</c:url>
								</c:when>
								<c:otherwise>
									<c:url var="pageUrl" value="/course/list">
										<c:param name="offset" value="${page * limit}" />
										<c:param name="limit" value="${limit}" />
									</c:url>
								</c:otherwise>
							</c:choose> <a class="page-link text-success" href="${pageUrl}">${page + 1}</a>
						</li>
					</c:forEach>
				</c:if>
				<!-- 더미 -->

				<!-- 다음 페이지 버튼 -->
				<c:if test="${offset + limit < totalPosts}">
					<li class="page-item"><c:choose>
							<c:when test="${type == '/running/course/search'}">
								<c:url var="nextPage" value="/course/search">
									<c:param name="offset" value="${offset + limit}" />
									<c:param name="limit" value="${limit}" />
									<c:if test="${not empty category}">
										<c:param name="category" value="${category}" />
									</c:if>
									<c:if test="${not empty order}">
										<c:param name="order" value="${order}" />
									</c:if>
									<c:if test="${not empty keyword}">
										<c:param name="keyword" value="${keyword}" />
									</c:if>
								</c:url>
							</c:when>
							<c:otherwise>
								<c:url var="nextPage" value="/course/list">
									<c:param name="offset" value="${offset + limit}" />
									<c:param name="limit" value="${limit}" />
								</c:url>
							</c:otherwise>
						</c:choose> <a class="page-link text-success" href="${nextPage}"
						aria-label="Next"> <span aria-hidden="true">Next
								&raquo;</span>
					</a></li>
				</c:if>

				<!-- 맨 마지막 페이지 버튼 -->
				<li class="page-item"><c:choose>
						<c:when test="${type == '/running/course/search'}">
							<c:url var="lastPage" value="/course/search">
								<c:param name="offset" value="${(totalPages - 1) * limit}" />
								<c:param name="limit" value="${limit}" />
								<c:if test="${not empty category}">
									<c:param name="category" value="${category}" />
								</c:if>
								<c:if test="${not empty order}">
									<c:param name="order" value="${order}" />
								</c:if>
								<c:if test="${not empty keyword}">
									<c:param name="keyword" value="${keyword}" />
								</c:if>
							</c:url>
						</c:when>
						<c:otherwise>
							<c:url var="lastPage" value="/course/list">
								<c:param name="offset" value="${(totalPages - 1) * limit}" />
								<c:param name="limit" value="${limit}" />
							</c:url>
						</c:otherwise>
					</c:choose> <a class="page-link text-success" href="${lastPage}"
					aria-label="Last"> <span aria-hidden="true">Last
							&raquo;&raquo;</span>
				</a></li>
			</ul>
		</nav>
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