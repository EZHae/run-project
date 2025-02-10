<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>팀 게시판</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet" crossorigin="anonymous">
</head>
<body>
	<h1>팀 게시판</h1>

	<form action="${postSearchPage}" method="get">
		<div>
			<select id="type" name="type">
				<option value="t">제목</option>
				<option value="c">내용</option>
				<option value="tc">제목+내용</option>
				<option value="n">작성자</option>
			</select> <input type="text" name="keyword" placeholder="검색어" required>
			<button class="btn btn-secondary" type="submit">검색</button>
		</div>
	</form>

	<a href="${postCreatePage}" class="btn btn-outline-primary">새글작성</a>
	<hr>

	<c:forEach var="post" items="${posts}">
		<c:url var="postDetailsPage"
			value="/teampage/${post.teamId}/post/${post.id}/details" />
		<a href="${postDetailsPage}">${post.title}</a>
		<hr>
	</c:forEach>

	<div class="d-flex justify-content-center mt-3">
		<nav aria-label="Page navigation">
			<ul class="pagination">
				<c:if test="${currentPage > pageBlockSize}">
					<li class="page-item">
						<a class="page-link" href="?page=${startPage - 1}">
							이전
						</a>
					</li>
				</c:if>
				<c:forEach begin="${startPage}" end="${endPage}" var="page">
					<li class="page-item ${page == currentPage ? 'active' : ''}">
						<a class="page-link" href="?page=${page}">
							${page}
						</a>
					</li>
				</c:forEach>
				<c:if test="${endPage < totalPage}">
					<li class="page-item"><a class="page-link"
						href="?page=${endPage + 1}">다음</a></li>
				</c:if>
			</ul>
		</nav>
	</div>
	
</body>
</html>