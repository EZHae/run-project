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
	
		<h1>팀 게시판 글 상세보기</h1>
		<div>
			<input id="id" name="id" type="text" value="${post.id}" />
		</div>
		<div>
			<input id="teamId" name="teamId" type="text" value="${post.teamId}" />
		</div>
		<div>
			<input id="userId" name="postId" type="text" value="${post.userId}" />
		</div>
		<div>
			<input id="nickname" name="nickname" type="text" value="${post.nickname}">
		</div>
		<div>
			<input id="title" name="title" type="text" value="${post.title}">
		</div>
		<div>
			<textarea rows="10" id="content" name="content">${post.content}</textarea>
		</div>
		<div>
			<input id="viewCount" name="viewCount" type="text" value="${post.viewCount}">
		</div>
		<div>
			<input id="createdTime" name="createdTime" type="text" value="${post.createdTime}">
		</div>
		<div>
			<input id="modifiedTime" name="modifiedTime" type="text" value="${post.modifiedTime}">
		</div>
		
		<span>첨부파일</span> <br>
		<c:choose>
			<c:when test="${empty images}">
				<span>파일이 없습니다.</span>
			</c:when>
			<c:otherwise>
				<c:forEach var="image" items="${images}">
					<div>
						<c:url var="imageViewPath" value="/teampage/${teamId}/image/view/${image.uniqName}"/>
						<img src="${imageViewPath}" style="width:50px; height:50px;">
						<c:url var="imageDownloadPath" value="/teampage/${teamId}/image/download/${image.uniqName}" />
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
		
		<hr>

		<!-- comment 작성 -->
		<c:if test="${not empty signedInUserId}">
			<!-- 로그인한 사람만 댓글작성 가능 -->
	      ` <div class="container my-1 py-1">
				<div class="row d-flex justify-content-center">
					<div class="col-md-12 col-lg-10 col-xl-8">
						<div class="card">
							<div class="card-body">
								<!-- 댓글 작성 폼 -->
								<h5>${signedInUserNickname}</h5>
								<div class="mb-3">
									<textarea class="form-control" id="ctext" rows="3" placeholder="댓글을 입력하세요..."></textarea>
								</div>
	
								<button type="submit" class="btn btn-primary btn-sm" id="btnRegisterComment">
									댓글 작성
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:if>
	
		<!-- comment section-->
		<section class="gradient-custom" id="commentSection"></section>

		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
									
		</script>
        <script>
			const teamId = '${post.teamId}';
			const postId = '${post.id}';
			const signedInUserId = '${signedInUserId}';
	        const signedInUserNickname = '${signedInUserNickname}';
	        const userId = '${post.userId}';
		</script>
		
		<!-- Axios Http Js-->
		<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
		
        <c:url var="detailsJS" value="/js/tpost-details.js" />
        <script src="${detailsJS}"></script>
	</body>
</html>