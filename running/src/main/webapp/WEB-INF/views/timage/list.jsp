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
        <%@ include file="../fragments/header.jspf"%>
		<div class="container-fluid">
            <c:set var="pageTitle" value="앨범 목록" />
        </div>
		
		<c:url var="teamPage" value="/team/details">
			<c:param name="teamid" value="${teamId}" />
		</c:url>
		<a href="${teamPage}">내 팀으로</a>
		
		<c:url var="postListPage" value="/teampage/${teamId}/post/list" />
		<a href="${postListPage}">팀 게시판</a>
		
		<c:url var="imageListPage" value="/teampage/${teamId}/image/list" />
		<a href="${imageListPage}">팀 앨범</a>
		
		<h1>팀 앨범</h1>
		
		<c:url var="imageCreatePage" value="/teampage/${teamId}/image/create" />
		<a href="${imageCreatePage}">앨범 등록</a>
		
		<div>
			<input id="all" name="category" type="radio" value="0" checked>
			<label for="all">전체 보기</label>
			<input id="postIamge" name="category" type="radio" value="1">
			<label for="postIamge">게시판 사진만</label>
			<input id="onlyImage" name="category" type="radio" value="2">
			<label for="onlyImage">앨범 사진만</label>
		</div>
		
		<div id="imageList"></div>

		<!-- 이미지 확대 모달 -->
		<div class="modal fade" id="imageModal" tabindex="-1" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" style="max-width: 90vw; max-height: 90vh;">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">확대</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body text-center" >
						<img id="modalImage" src="" alt="확대된 이미지" class="img-fluid">
					</div>
				</div>
			</div>
		</div>

		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
        
		<!-- Axios Http Js-->
		<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
		
		<script>
			const teamId = '${teamId}'
		</script>
		<c:url var="listJS" value="/js/timage-list.js" />
		<script src="${listJS}"></script>
	</body>
</html>