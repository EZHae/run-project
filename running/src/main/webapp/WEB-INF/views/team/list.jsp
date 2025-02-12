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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet">

</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<!-- 팀 검색 폼 -->
	<div class="container my-3">
		<div class="row d-flex justify-content-center">
			<div class="col-md-14 col-lg-12 col-xl-10">

				<main class="mt-3">
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
							<i class="bi bi-search"></i>
						</button>
					</form>

					<div class="d-flex justify-content-between">
						<!-- 모집중/모집완료 필터 버튼 (왼쪽) -->
						<div class="mb-3">
							<c:url value="/team/list" var="teamListUrl">
								<c:param name="status" value="open" />
							</c:url>
							<c:url value="/team/list" var="closedListUrl">
								<c:param name="status" value="closed" />
							</c:url>
							<a href="${teamListUrl}">
								<button class="btn btn-outline-success me-2 mt-3">모집중</button>
							</a> <a href="${closedListUrl}">
								<button class="btn btn-outline-success mt-3">모집완료</button>
							</a>
						</div>

						<!-- 새 팀 생성 버튼 (오른쪽) -->
						<div>
							<c:url var="teamCreatePage" value="/team/create" />
							<a href="${teamCreatePage}" class="btn btn-outline-success mt-3">새
								팀 생성</a>
						</div>
					</div>


					<!-- 팀 카드 목록 -->
					<div class="card mt-3">
						<div class="card-body">
							<div class="row">
								<c:forEach items="${teams}" var="team">
									<!-- 팀 카드 -->
									<div class="col-md-6 mb-6 mt-3">
										<article>
											<div class="card border-0">
												<img
													class="card-img-top img-fluid bsb-scale bsb-hover-scale-up"
													loading="lazy" src="${team.imagePath}"
													alt="${team.teamName}">
												<div class="card-body border bg-white p-4">
													<div class="entry-header mb-3">
														<ul class="entry-meta list-unstyled d-flex mb-2">
															<li><a class="link-primary text-decoration-none"
																href="#!">${team.teamName}</a></li>
														</ul>
														<h2 class="card-title entry-title h4 mb-0">
															<a class="link-dark text-decoration-none" href="#!">${team.title}</a>
														</h2>
													</div>
													<p class="card-text entry-summary text-secondary mb-3">
														${team.content}</p>
													<c:url var="teamDetailPage" value="/team/details">
														<c:param name="teamid" value="${team.teamId}" />
													</c:url>
													<a href="${teamDetailPage }"
														class="btn btn btn-success m-0 text-nowrap entry-more">상세보기</a>
												</div>
												<div class="card-footer border border-top-0 bg-light p-4">
													<ul
														class="entry-meta list-unstyled d-flex align-items-center m-0">
														<li><svg xmlns="http://www.w3.org/2000/svg"
																width="14" height="14" fill="currentColor"
																class="bi bi-calendar3" viewBox="0 0 16 16">
                        <path
																	d="M14 0H2a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zM1 3.857C1 3.384 1.448 3 2 3h12c.552 0 1 .384 1 .857v10.286c0 .473-.448.857-1 .857H2c-.552 0-1-.384-1-.857V3.857z" />
                        <path
																	d="M6.5 7a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm-9 3a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm-9 3a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2z" />
                      </svg> <span class="ms-2 fs-7">${team.createdTime}</span></li>
														<li><span class="px-3">&bull;</span></li>
														<li><svg xmlns="http://www.w3.org/2000/svg"
																width="16" height="16" fill="currentColor"
																class="bi bi-person" viewBox="0 0 16 16">
  <path
																	d="M8 0a3 3 0 1 1 0 6 3 3 0 0 1 0-6zm0 7a4 4 0 0 0-4 4v4a4 4 0 0 0 8 0V11a4 4 0 0 0-4-4z" />
</svg> <span class="ms-2 fs-7">${team.currentNum} / ${team.maxNum}</span></li>
													</ul>
												</div>
											</div>
										</article>
									</div>
								</c:forEach>

							</div>
						</div>
					</div>
				</main>
			</div>
		</div>
	</div>


	<!-- Bootstrap Javascript  -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>