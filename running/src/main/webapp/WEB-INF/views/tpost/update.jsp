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
		
		<h1>팀 게시판 글 수정</h1>
		<form id="update" enctype="multipart/form-data">
			<input id="teamId" name="teamId" value="${teamId}" readonly>
			<input id="id" name="id" value="${post.id}" readonly>
			<input id="userId" name="userId" value="${signedInUserId}" readonly> <br>
			<input id="title" name="title" type="text" value="${post.title}" placeholder="제목" autofocus required> <br>
			<textarea id="content" name=content rows="10" placeholder="내용" required>${post.content}</textarea> <br>
			<input id ="nickname" name="nickname" type="text" value="${signedInUserNickname}" readonly/><br>
			
			<span>첨부파일</span> <br>
			<div>
				<c:choose>
					<c:when test="${empty images}">
						<span>파일이 없습니다.</span>
					</c:when>
					<c:otherwise>
						<c:forEach var="image" items="${images}">
							<li class="list-group-item" data-image-id="${image.id}">
								<c:url var="imageViewPath" value="/teampage/${teamId}/image/view/${image.uniqName}"/>
								<img src="${imageViewPath}" style="width:50px; height:50px;">
								<span>${image.originName}</span>
								<input type="button" name="btnDelete" class="rmbtn btn btn-outline-danger btn-sm" value="삭제">
							</li>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
			
			<!-- 기존 있던 이미지를 삭제하기 위해 필요한 id 보관 input 
			첨부 파일 삭제 시, 해당 이미지에 해당 하는 id가 이 value에 추가됨 -->
			<input type="hidden" id="deletedImages" name="deletedImages" value="" />

			<div>
				<label for="file">이미지 업로드</label>
				<input type="file" id="file" name="file" accept="image/*" multiple>
			</div>
			
			<ul id="newImageList" class="list-group list-group-flush mt-2"></ul>

			<button id="btnUpdate">수정 완료</button>
		</form>
		
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
        
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        
        <c:url var="updateJS" value="/js/tpost-update.js" />
        <script src="${updateJS}"></script>
	</body>
</html>