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
		
		<c:url var="teamPage" value="/teampage/${teamId}" />
		<a href="${teamPage}">내 팀으로</a>
	
		<h1>TPost 상세보기</h1>
		<span>post.id = ${post.id}</span> <br>
		<span>post.teamId = ${post.teamId}</span> <br>
		<span>post.userId = ${post.userId}</span> <br>
		<span>post.nickname = ${post.nickname}</span> <br>
		<span>post.title = ${post.title}</span> <br>
		<span>post.content = ${post.content}</span> <br>
		<span>post.viewCount = ${post.viewCount}</span> <br>
		<span>post.createTime = ${post.createdTime}</span> <br>
		<span>post.modifiedTime = ${post.modifiedTime}</span> <hr>
		
		<span>첨부파일</span> <br>
		<c:choose>
			<c:when test="${empty images}">
				<span>파일이 없습니다.</span>
			</c:when>
			<c:otherwise>
				<c:forEach var="image" items="${images}">
					<div>
						<c:url var="imageViewPath" value="/image/view/${image.uniqName}"/>
						<img src="${imageViewPath}" style="width:50px; height:50px;">
						<c:url var="imageDownloadPath" value="/image/download/${image.uniqName}" />
						<a href="${imageDownloadPath}">${image.originName}</a>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		
		<hr>
		
		<c:if test="${signedInUserId eq post.userId}">
			<c:url var="postUpdatePage" value="/teampage/${post.teamId}/post/${post.id}/update" />
			<a class="btn btn-success" href="${postUpdatePage}">수정</a>
			
			<button class="btn btn-danger" id="btnDelete">삭제</button>
		</c:if>
		
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
        <script>
        const teamId = '${post.teamId}';
        const id = '${post.id}';
        </script>
        <c:url var="detailsJS" value="/js/tpost-details.js" />
        <script src="${detailsJS}"></script>
	</body>
</html>