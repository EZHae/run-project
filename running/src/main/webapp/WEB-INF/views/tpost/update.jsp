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
            <c:set var="pageTitle" value="팀 게시글 수정" />
        </div>
		<div class="container my-5">
			<div class="row d-flex justify-content-center">
				<div class="col-md-12 col-lg-8">
					<div class="card shadow p-4">
						<!-- 버튼 그룹
		                <div class="btn-group mb-4 d-flex justify-content-center" role="group" aria-label="Navigation">
		                    <c:url var="teamPage" value="/team/details">
		                        <c:param name="teamid" value="${teamId}" />
		                    </c:url>
		                    <a href="${teamPage}" class="btn btn-outline-success">내 팀으로</a>
		
		                    <c:url var="postListPage" value="/teampage/${teamId}/post/list" />
		                    <a href="${postListPage}" class="btn btn-outline-success">팀 게시판</a>
		
		                    <c:url var="imageListPage" value="/teampage/${teamId}/image/list" />
		                    <a href="${imageListPage}" class="btn btn-outline-success">팀 앨범</a>
		
		                    <c:url var="calendarListPage" value="/teampage/${teamId}/tcalendar/list" />
		                    <a href="${calendarListPage}" class="btn btn-outline-success">팀 일정</a>
		                </div>
		                -->
		
						<h2 class="text-center text-success fw-bold mb-4">팀 게시판 글 수정</h2>
						
						<!-- 글 수정 폼 -->
						<form id="update" enctype="multipart/form-data">
	
					    <!-- 팀 ID -->
					    <div class="mb-3">
					        <label for="teamId" class="form-label text-success fw-bold">팀 ID</label>
					        <input type="text" id="teamId" name="teamId" value="${teamId}" class="form-control" readonly>
					    </div>
					
					    <!-- 게시글 ID -->
					    <div class="mb-3">
					        <input type="hidden" id="id" name="id" value="${post.id}">
					    </div>
					
					    <!-- 사용자 ID -->
					    <div class="mb-3">
					        <label for="userId" class="form-label text-success fw-bold">사용자 ID</label>
					        <input type="text" id="userId" name="userId" value="${signedInUserId}" class="form-control" readonly>
					    </div>
					
					    <!-- 제목 -->
					    <div class="mb-3">
					        <label for="title" class="form-label text-success fw-bold">제목</label>
					        <input type="text" id="title" name="title" class="form-control" value="${post.title}" placeholder="제목을 입력하세요" required autofocus>
					    </div>
					
					    <!-- 내용 -->
					    <div class="mb-3">
					        <label for="content" class="form-label text-success fw-bold">내용</label>
					        <textarea id="content" name="content" class="form-control" rows="10" placeholder="내용을 입력하세요" required>${post.content}</textarea>
					    </div>
					
					    <!-- 닉네임 -->
					    <div class="mb-3">
					        <label for="nickname" class="form-label text-success fw-bold">닉네임</label>
					        <input type="text" id="nickname" name="nickname" class="form-control" value="${signedInUserNickname}" readonly>
					    </div>
					
					    <!-- 첨부파일 -->
					    <div class="mb-3">
					        <span class="form-label text-success fw-bold">첨부파일</span><br>
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
					    </div>
					
					    <!-- 기존 이미지 삭제를 위해 필요한 ID 보관 input -->
					    <input type="hidden" id="deletedImages" name="deletedImages" value="" />
					
					    <!-- 파일 업로드 -->
					    <div class="mb-3">
					        <label for="file" class="form-label text-success fw-bold">이미지 업로드</label>
					        <input type="file" id="file" name="file" class="form-control" accept="image/*" multiple>
					    </div>
					
					    <!-- 새 이미지 목록 표시 -->
					    <ul id="newImageList" class="list-group list-group-flush mt-2"></ul>
					
					    <!-- 제출 버튼 -->
					    <div class="text-center mt-4">
					        <button id="btnUpdate" type="submit" class="btn btn-success btn-lg px-5">수정 완료</button>
					    </div>
					
					</form>
						
					</div>
				</div>
			</div>
		</div>
	
		<%@ include file="../fragments/footer.jspf"%>
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
        
        <!-- Axios Http Js-->
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        
        <c:url var="updateJS" value="/js/tpost-update.js" />
        <script src="${updateJS}"></script>
	</body>
</html>