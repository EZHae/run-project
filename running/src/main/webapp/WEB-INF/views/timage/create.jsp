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
		
		<c:url var="postListPage" value="/teampage/${teamId}/post/list" />
		<a href="${postListPage}">팀 게시판</a>
		
		<c:url var="imageListPage" value="/teampage/${teamId}/image/list" />
		<a href="${imageListPage}">팀 앨범</a>
		
		<h1>팀 앨범 사진 등록</h1>
		
		<c:url var="imageCreatePage" value="" />
		<form action="${imageCreatePage}" method="post" enctype="multipart/form-data">
			<input id="teamId" name="teamId" value="${teamId}" readonly>
			<input id="userId" name="userId" value="${signedInUserId}" readonly>
			<input id ="nickname" name="nickname" type="text" value="${signedInUserNickname}" readonly/><br>

			<div>
				<label for="file">이미지 업로드</label>
				<input type="file" id="file" name="file" accept="image/*" multiple>
			</div>
			
			<ul id="fileList" class="list-group list-group-flush mt-2"></ul>

			<button type="submit">작성 완료</button>
		</form>
		
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
        
        <!-- Axios Http Js-->
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

        <c:url var="createJS" value="/js/timage-create.js" />       
        <script src="${createJS}"></script> 
	</body>
</html>