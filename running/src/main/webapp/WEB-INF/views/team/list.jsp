<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
/* 내팀으로, 팀게시판, 팀앨범, 팀일정게시판 버튼 */
.custom-btn {
	background-color: transparent;
	border: 2px solid #008C2C;
	color: #008C2C;
	transition: background-color 0.3s, color 0.3s;
}

.custom-btn:hover, .custom-btn:focus, .custom-btn.active {
	background-color: #008C2C;
	color: white;
	border-color: #008C2C;
}
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

button:focus, button:focus-visible {
	outline: none !important;
	box-shadow: none !important;
}

</style>

</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<!-- 팀 검색 폼 -->
	<div class="container my-3">
		<div class="row d-flex justify-content-center">
			<div class="col-md-12 col-lg-10 col-xl-8">

				<main class="mt-3">
					<c:url value="/team/search" var="teamSearchPage" />
					<form action="${teamSearchPage}" method="get" id="searchForm">
						<div class="d-flex align-items-center mb-3">
							<select class="form-select me-3" id="status" name="status">
								<option value="open" selected>모집중</option>
								<option value="closed">모집완료</option>
							</select> <select class="form-select me-3" id="seoul-districts"
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
								class="form-control me-3" placeholder="팀 이름으로 검색">

							<button id="searchButton" class="btn btn-success text-white">
								<i class="bi bi-search"></i>
							</button>
						</div>
					</form>

					<div class="d-flex justify-content-between">
						<div class="mb-3">
							<c:url value="/team/list" var="teamListUrl">
								<c:param name="status" value="open" />
							</c:url>
							<c:url value="/team/list" var="closedListUrl">
								<c:param name="status" value="closed" />
							</c:url>

							<div class="mb-3">
								<a href="/running/team/list?status=open"><button
										class="btn btn-outline-success me-2 mt-3 rounded-pill shadow-sm  ${status == 'open' ? 'active' : ''}">모집중</button></a>
								<a href="/running/team/list?status=closed"><button
										class="btn btn-outline-success mt-3 rounded-pill shadow-sm  ${status == 'closed' ? 'active' : ''}">모집완료</button></a>
							</div>

						</div>
						<div>
							<c:url var="teamCreatePage" value="/team/create" />
							<a href="${teamCreatePage}"
								class="btn btn-success mt-3 shadow-sm rounded-pill">새 팀 생성</a>
						</div>
					</div>

					<div class="card mt-3 rounded">
						<div class="card-body">
							<div class="row">
								<c:forEach items="${teams}" var="team">
									<div class="col-md-6 mb-4">
										<div class="card border-1 rounded-2 overflow-hidden">
											<img class="card-img-top img-fluid" src="${team.imagePath}"
												alt="${team.teamName}"
												style="height: 200px; object-fit: cover;">
											<div class="card-body bg-light p-4">
												<h5 class="card-title">
													<c:url var="teamDetailPage" value="/team/details">
														<c:param name="teamid" value="${team.teamId}" />
													</c:url>

													<a href="${teamDetailPage}"
														class="link-dark text-decoration-none fw-bold"> <c:choose>
															<c:when test="${fn:length(team.title) > 17}">${fn:substring(team.title, 0, 17)}...</c:when>
															<c:otherwise>${team.title}</c:otherwise>
														</c:choose>
													</a>
												</h5>
												<p class="card-text text-secondary mb-3">
													<c:choose>
														<c:when test="${fn:length(team.content) > 22}">${fn:substring(team.content, 0, 22)}...</c:when>
														<c:otherwise>${team.content}</c:otherwise>
													</c:choose>
												</p>
												<c:url var="teamDetailPage" value="/team/details">
													<c:param name="teamid" value="${team.teamId}" />
												</c:url>
												<a href="${teamDetailPage}"
													class="btn btn-outline-success shadow-sm rounded-pill">상세보기</a>
											</div>
											<div class="card-footer bg-white p-4">
												<ul
													class="entry-meta list-unstyled d-flex justify-content-between m-0">
													<li><i class="fas fa-calendar-alt text-warning"></i> <span
														class="ms-2 fs-7"><fmt:parseDate
																value="${team.createdTime}" pattern="yyyy-MM-dd'T'HH:mm"
																var="parsedDateTime" type="both" /> <fmt:formatDate
																pattern="yyyy-MM-dd HH:mm" value="${parsedDateTime}" />
													</span></li>
													<li><i class="fas fa-user text-primary"></i> <span
														class="ms-2 fs-7">${team.currentNum} /
															${team.maxNum}</span></li>
												</ul>
												<ul
													class="entry-meta list-unstyled d-flex justify-content-between m-0">
													<li><c:choose>
															<c:when test="${team.genderLimit == 1}">
																<i class="fas fa-mars text-primary"></i> 남자만
											</c:when>
															<c:when test="${team.genderLimit == 2}">
																<i class="fas fa-venus text-danger"></i> 여자만
											</c:when>
															<c:otherwise>
																<i class="fas fa-genderless text-success"></i> 남녀모두
											</c:otherwise>
														</c:choose></li>
												</ul>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</main>

			</div>
		</div>
	</div>


	<!-- 페이징 처리 -->
	<fmt:parseNumber value="${TeamSearchDto.page/5}" var="quotient"
		integerOnly="true" />
	<div class="mt-3">
		<nav aria-label="Page navigation">
			<ul class="pagination d-flex justify-content-center">
				<!-- 페이지블록 돌아갈 버튼 -->
				<li class="page-item"><c:choose>
						<c:when test="${TeamSearchDto.page <= 5}">
							<a class="page-link text-success" href="#" aria-label="First">
								<span aria-hidden="true">&laquo;&laquo; </span>
							</a>
						</c:when>
						<c:otherwise>
							<c:url var="firstPage" value="/team/search">
								<c:if test="${TeamSearchDto.page%5 == 0 }">
									<c:param value="${quotient-1}" name="page"></c:param>
								</c:if>
								<c:if test="${TeamSearchDto.page%5 != 0 }">
									<c:param value="${quotient}" name="page"></c:param>
								</c:if>
								<c:if test="${not empty dto.district}">
									<c:param name="district" value="${TeamSearchDto.district}" />
								</c:if>
								<c:if test="${not empty status}">
									<c:param name="status" value="${TeamSearchDto.status}" />
								</c:if>
								<c:if test="${not empty dto.keyword}">
									<c:param name="keyword" value="${TeamSearchDto.keyword}" />
								</c:if>
							</c:url>
							<a class="page-link text-success" href="${firstPage}"
								aria-label="First"> <span aria-hidden="true">&laquo;&laquo;
							</span>
							</a>
						</c:otherwise>
					</c:choose></li>

				<!-- 페이지 번호 버튼 -->
				<c:if test="${totalPages > 0}">
					<c:if test="${TeamSearchDto.page%5 == 0 }">
						<c:set value="${(quotient-1)*5+1}" var="begin" />
					</c:if>
					<c:if test="${TeamSearchDto.page%5 != 0 }">
						<c:set value="${quotient*5+1}" var="begin" />
					</c:if>
					<c:forEach begin="${begin}"
						end="${begin + 4 > totalPages ? totalPages : begin + 4}"
						var="showPage">
						<c:url var="pageUrl" value="/team/search">
							<c:if test="${not empty district}">
								<c:param name="district" value="${district}" />
							</c:if>
							<c:if test="${not empty status}">
								<c:param name="status" value="${status}" />
							</c:if>
							<c:if test="${not empty keyword}">
								<c:param name="keyword" value="${keyword}" />
							</c:if>
							<c:param name="page" value="${showPage }" />
						</c:url>
						<li
							class="page-item ${TeamSearchDto.page == showPage ? 'active' : ''}"><a
							class="page-link text-success" href="${pageUrl}">${showPage}</a>
						</li>
					</c:forEach>
				</c:if>

				<!-- 페이지 블록 건너뛸 버튼 -->
				<li class="page-item"><c:if
						test="${TeamSearchDto.page%5 == 0 }">
						<c:set value="${(quotient-1)*5+6}" var="next" />
					</c:if> <c:if test="${TeamSearchDto.page%5 != 0 }">
						<c:set value="${quotient*5+6}" var="next" />
					</c:if> <c:if test="${next < totalPages}">
						<c:url value="/team/search" var="lastPage">
							<c:param value="${next}" name="page"></c:param>
							<c:if test="${not empty dto.district}">
								<c:param name="district" value="${TeamSearchDto.district}" />
							</c:if>
							<c:if test="${not empty status}">
								<c:param name="status" value="${TeamSearchDto.status}" />
							</c:if>
							<c:if test="${not empty dto.keyword}">
								<c:param name="keyword" value="${TeamSearchDto.keyword}" />
							</c:if>
						</c:url>
						<a class="page-link text-success" href="${lastPage}"
							aria-label="Last"> <span aria-hidden="true">
								&raquo;&raquo;</span></a>
					</c:if> <c:if test="${next>=totalPages}">
						<a class="page-link text-success" href="#" aria-label="Last">
							<span aria-hidden="true">&raquo;&raquo; </span>
						</a>
					</c:if></li>
			</ul>
		</nav>
	</div>

	<%@ include file="../fragments/footer.jspf"%>
	<!-- Bootstrap Javascript  -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>