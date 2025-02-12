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
        <style>
		/* 내팀으로, 팀게시판, 팀앨범, 팀일정게시판 버튼 */
		.custom-btn {
			background-color: transparent;
			border: 2px solid #008C2C;
			color: #008C2C;
			transition: background-color 0.3s, color 0.3s;
		}
		
		.custom-btn:hover, .custom-btn:focus, .custom-btn.active {
			background-color: #008C2C;
			color: white;
			border-color: #008C2C;
		}
		</style>
	</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<div class="container-fluid">
		<c:set var="pageTitle" value="팀 게시글 작성" />
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

					<h2 class="text-center text-success fw-bold mb-4">팀 게시판 글 생성</h2>

					<!-- 글 작성 폼 -->
					<c:url var="postCreatePage" value="/teampage/${teamId}/post/create" />
					<form action="${postCreatePage}" method="post"
						enctype="multipart/form-data">

						<!-- 팀 ID -->
						<div class="mb-3">
							<label for="teamId" class="form-label text-success fw-bold">팀
								ID</label> <input type="text" id="teamId" name="teamId"
								value="${teamId}" class="form-control" readonly>
						</div>

						<!-- 사용자 ID -->
						<div class="mb-3">
							<label for="userId" class="form-label text-success fw-bold">사용자
								ID</label> <input type="text" id="userId" name="userId"
								value="${signedInUserId}" class="form-control" readonly>
						</div>

						<!-- 닉네임 -->
						<div class="mb-3">
							<label for="nickname" class="form-label text-success fw-bold">닉네임</label>
							<input type="text" id="nickname" name="nickname"
								value="${signedInUserNickname}" class="form-control" readonly>
						</div>

						<!-- 제목 -->
						<div class="mb-3">
							<label for="title" class="form-label text-success fw-bold">제목</label>
							<input type="text" id="title" name="title" class="form-control"
								placeholder="제목을 입력하세요" required autofocus>
						</div>

						<!-- 내용 -->
						<div class="mb-3">
							<label for="content" class="form-label text-success fw-bold">내용</label>
							<textarea id="content" name="content" class="form-control"
								rows="5" placeholder="내용을 입력하세요" required></textarea>
						</div>

						<!-- 파일 업로드 -->
						<div class="mb-3">
							<label for="file" class="form-label text-success fw-bold">이미지
								업로드</label> <input type="file" id="file" name="file"
								class="form-control" accept="image/*" multiple> <small
								class="text-muted">여러 이미지를 선택할 수 있습니다.</small>
						</div>

						<!-- 파일 목록 표시 -->
						<ul id="fileList" class="list-group list-group-flush mt-2"></ul>

						<!-- 제출 버튼 -->
						<div class="text-center mt-4">
							<button type="submit" class="btn btn-success btn-lg px-5">작성
								완료</button>
						</div>

					</form>
				</div>
			</div>
		</div>
	</div>


	<%@ include file="../fragments/footer.jspf"%>

	<!-- Bootstrap JS 링크 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous">
		
	</script>


	<script>
		//세션에 저장된 로그인 사용자 아이디를 자바스크립트 변수에 저장.
		const signedInUserId = '${signedInUserId}';//문자열 포맷으로 변수를 저장.
		const signedInUserNickname = '${signedInUserNickname}';
		const teams = '${teams}';

		// 이미지 미리보기 기능
		document.getElementById("imageUpload").addEventListener("change",
				function(event) {
					const file = event.target.files[0]; //사용자가 선택한 첫번째 사진
					const preview = document.getElementById("imagePreview");

					if (file) {
						const reader = new FileReader(); //파일을 읽어서 Base64 인코딩된 Data URL로 변환하는 객체인 FileReader생성
						reader.onload = function(e) {
							preview.src = e.target.result; //이미지태그의 src에 파일의 Base64 Data URL할당
							preview.style.display = "block"; //화면에 보여준다
						};
						reader.readAsDataURL(file); //파일읽기가 끝나면 onload함수 실행됨
					} else {
						preview.style.display = "none"; //화면에 아무것도 보여주지 않는다
					}
				});
	</script>




	<!-- Axios Http Js-->
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

	<c:url var="createJS" value="/js/tpost-create.js" />
	<script src="${createJS}"></script>
</body>
</html>