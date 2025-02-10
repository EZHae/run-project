<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
		
		<title>Running</title>
		
		<!-- Bootstrap CSS 링크 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
                rel="stylesheet" 
                integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
                crossorigin="anonymous">
	</head>
	<body>
	 	<c:url var="homePage" value="/" />
		<a href="${homePage}">홈으로</a>
		
		<c:url var="teamPage" value="/team/details">
			<c:param name="teamid" value="${teamId}" />
		</c:url>
		<a href="${teamPage}">내 팀으로</a>
		
		<c:url var="postListPage" value="/teampage/${teamId}/post/list" />
		<a href="${postListPage}">팀 게시판</a>
		
		<c:url var="imageListPage" value="/teampage/${teamId}/image/list" />
		<a href="${imageListPage}">팀 앨범</a>
		
		<h1>팀 게시판</h1>
		
		<c:url var="postSearchPage" value="/teampage/${teamId}/post/list" />
		<form action="${postSearchPage}" method="get">
			<div>
				<div>
					<select id="type" name="type">
						<option value="t">제목</option>
						<option value="c">내용</option>
						<option value="tc">제목+내용</option>
						<option value="n">작성자</option>
					</select>
				</div>
				<div>
					<input type="text" name="keyword" placeholder="검색어, 공백 불가" required>
				</div>
				<div>
					<input class="btn btn-secondary" type="submit" value="검색">
				</div>
			</div>
		</form>
		
		<c:url var="postListPage" value="/teampage/${teamId}/post/list" />
		<a href="${postListPage}" class="btn btn-primary">전체 보기</a>
		
		<div>
			<c:url var="postCreatePage" value="/teampage/${teamId}/post/create" />
			<a class="btn btn-outline-primary" href="${postCreatePage}">새글작성</a>
		</div>
		
		<hr>
		
		<c:forEach var="post" items="${posts}" >
			<c:url var="postDetailsPage" value="/teampage/${post.teamId}/post/${post.id}/details" />
			<a href="${postDetailsPage}">${post.title}</a>
			<hr>
		</c:forEach>

		<div class="d-flex justify-content-center mt-3">
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<c:if test="${currentPage > pageBlockSize}">
						<li class="page-item">
							<a class="page-link" href="
								<c:choose>
	                        		<c:when test="${empty type and empty keyword}">
	                            		?page=${startPage - 1}
	                        		</c:when>
	                        		<c:otherwise>
	                            		?page=${startPage - 1}&type=${type}&keyword=${keyword}
	                        		</c:otherwise>
	                    		</c:choose>">
	                    		이전
	                    	</a>
						</li>
					</c:if>
					<c:forEach begin="${startPage}" end="${endPage}" var="page">
						<li class="page-item ${page == currentPage ? 'active' : ''}">
							<a class="page-link" href="
								<c:choose>
	                        		<c:when test="${empty type and empty keyword}">
	                            		?page=${page}
	                        		</c:when>
	                        		<c:otherwise>
	                            		?page=${page}&type=${type}&keyword=${keyword}
	                        		</c:otherwise>
	                    		</c:choose>">
	                    		${page}
	                    	</a>
						</li>
					</c:forEach>
					<c:if test="${endPage < totalPage}">
						<li class="page-item">
							<a class="page-link" href="
								<c:choose>
			                        <c:when test="${empty type and empty keyword}">
			                            ?page=${endPage + 1}
			                        </c:when>
			                        <c:otherwise>
			                            ?page=${endPage + 1}&type=${type}&keyword=${keyword}
			                        </c:otherwise>
		                    	</c:choose>">
	                    		다음
	                    	</a>
						</li>
					</c:if>
				</ul>
			</nav>
		</div>

		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
	</body>
</html>