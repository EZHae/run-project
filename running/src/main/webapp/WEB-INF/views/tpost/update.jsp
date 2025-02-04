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
		
		<h1>TPost 수정</h1>
		<c:url value="" var="postUpdatePage"/>
		<form action="${postUpdatePage}" method="post" enctype="multipart/form-data">
			<input id="teamId" name="teamId" value="${teamId}" readonly>
			<input id="userId" name="userId" value="${signedInUserId}" readonly> <br>
			<input id="title" name="title" type="text" value="${post.title}" placeholder="제목" autofocus required> <br>
			<input id="content" name="content" type="text" value="${post.content}" placeholder="내용" required> <br>
			<input id ="nickname" name="nickname" type="text" value="${signedInUserNickname}" readonly/><br>
			
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
							<span>${image.originName}</span>
							<input type="button" name="btnDelete"
									class="rmbtn btn btn-outline-danger btn-sm" value="삭제">
						</div>
					</c:forEach>
				</c:otherwise>
			</c:choose>

			<div>
				<label for="file">이미지 업로드</label>
				<input type="file" id="file" name="file" accept="image/*" multiple>
			</div>
			
			<ul id="newImageList" class="list-group list-group-flush mt-2"></ul>

			<button type="submit">수정 완료</button>
		</form>
		
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
	</body>
</html>