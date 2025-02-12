<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>글쓰기 : Running</title>

<!-- Bootstrap CSS 링크 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">

</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<div class="container-fluid">
		<c:set var="pageTitle" value="새 글 작성" />
	</div>

	<div class="container">
		<div class="row d-flex justify-content-center">
			<div class="col-md-12 col-lg-10 col-xl-8">
				<div class="card p-4 shadow-sm">
					<div class="card-body">
							<c:url value="/gpost/create" var="gPostCreatePage" />
							<form method="post" action="${gPostCreatePage}"
								enctype="multipart/form-data">
								<!-- 카테고리 선택 -->
								<div class="mb-3">
									<label class="form-label" for="category">카테고리</label> <select
										name="category" class="form-select" id="category" required>
										<option value="0">자유게시판</option>
										<option value="1">질문게시판</option>
									</select>
								</div>

								<!-- 제목 입력 -->
								<div class="mb-3">
									<label class="form-label" for="title">제목</label> <input
										class="form-control" id="title" name="title" type="text"
										placeholder="제목을 입력하세요" required autofocus />
								</div>

								<!-- 내용 입력 -->
								<div class="mb-3">
									<label class="form-label" for="content">내용</label>
									<textarea rows="5" class="form-control" id="content"
										name="content" placeholder="내용을 입력하세요" required></textarea>
								</div>

								<!-- 작성자 정보 (숨김 필드) -->
								<div class="d-none">
									<label class="form-label" for="nickname">작성자</label> <input
										type="text" readonly class="form-control" id="nickname"
										name="nickname" value="${signedInUserNickname}">
								</div>

								<div class="d-none">
									<input class="d-none" id="userId" type="text" name="userId"
										value="${signedInUserId}" readonly />
								</div>

								<hr />

								<!-- 파일 업로드 -->
								<div class="mb-3">
									<label class="form-label" for="file">파일 업로드</label> <input
										class="form-control" type="file" id="file" name="file"
										accept="image/*" multiple />
								</div>

								<!-- 파일 미리보기 -->
								<ul id="fileList" class="list-group list-group-flush mt-2"></ul>

								<!-- 제출 버튼 -->
								<div class="mt-4 d-flex justify-content-center">
									<button id="submitPost" type="submit"
										class="btn btn-outline-success">작성완료</button>
								</div>
							</form>
						</div>
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
	
	<!-- Axios Http Js-->
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

	<c:url value="/js/gpost_create.js" var="gPostCreateJS" />
	<script src="${gPostCreateJS}"></script>

</body>
</html>