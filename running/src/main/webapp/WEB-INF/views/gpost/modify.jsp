<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>${gPost.title}:수정</title>

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
		<c:set var="pageTitle" value="글 수정" />
	</div>

	<div class="container">
		<div class="row d-flex justify-content-center">
			<div class="col-md-12 col-lg-10 col-xl-8">
				<div class="card p-4 shadow-sm">
					<div class="card-body">
						<form id="modifyForm" enctype="multipart/form-data">

							<!-- 글 번호 (숨김) -->
							<div class="d-none">
								<label class="form-label" for="id">글 번호</label> <input
									class="form-control" id="id" name="id" value="${gPost.id}"
									type="text" />
							</div>

							<!-- 제목 입력 -->
							<div class="mb-3">
								<label class="form-label" for="title">제목</label> <input
									class="form-control" id="title" name="title"
									value="${gPost.title}" type="text" required />
							</div>

							<!-- 작성자 (숨김 필드) -->
							<div class="d-none">
								<label class="form-label" for="nickname">작성자</label> <input
									type="text" readonly class="form-control" id="nickname"
									name="nickname" value="${gPost.nickname}" disabled />
							</div>

							<!-- 내용 입력 -->
							<div class="mb-3">
								<label class="form-label" for="content">내용</label>
								<textarea rows="5" class="form-control" id="content"
									name="content">${gPost.content}</textarea>
							</div>

							<!-- 작성 시간 (숨김 필드) -->
							<div class="d-none">
								<label class="form-label" for="createdTime">작성 시간</label> <input
									class="form-control" type="text" id="createdTime"
									name="createdTime" value="${gPost.formattedCreatedTime}"
									readonly />
							</div>

							<!-- 최종 수정 시간 (숨김 필드) -->
							<div class="d-none">
								<label class="form-label" for="modifiedTime">최종 수정 시간</label> <input
									class="form-control" type="text" id="modifiedTime"
									name="modifiedTime" value="${gPost.formattedModifiedTime}"
									readonly />
							</div>

							<!-- 첨부파일 -->
							<div class="mt-3">
								<label class="form-label">첨부파일</label>
								<c:choose>
									<c:when test="${empty gImages}">
										<p>파일이 없습니다.</p>
									</c:when>
									<c:otherwise>
										<ul class="list-group list-group-flush">
											<c:forEach var="images" items="${gImages}">
												<li
													class="list-group-item d-flex justify-content-between align-items-center">
													<img alt="${images.originName}" class="rounded"
													src="/running/gpost/uploads/${images.uniqName}"
													style="width: 50px; height: 50px;"> <span>${images.originName}</span>
													<input type="button" name="btnDelete"
													class="rmbtn btn btn-outline-danger btn-sm" value="삭제">
												</li>
											</c:forEach>
										</ul>
									</c:otherwise>
								</c:choose>
							</div>

							<!-- 삭제할 이미지 ID 목록 -->
							<input type="hidden" id="deletedImages" name="deletedImages"
								value="" />

							<!-- 새 이미지 업로드 -->
							<div class="mt-3">
								<label class="form-label" for="file">파일 업로드</label> <input
									class="form-control" type="file" id="file" name="file"
									accept="image/*" multiple />
							</div>

							<!-- 새 이미지 미리보기 -->
							<ul id="newImageList" class="list-group list-group-flush mt-3"></ul>

							<!-- 카테고리 (숨김 필드) -->
							<input type="hidden" id="category" name="category"
								value="${param.category}" />
						</form>
					</div>

					<!-- 업데이트 및 삭제 버튼 -->
					<div class="card-footer d-flex justify-content-center">
						<button id="btnUpdate" class="me-2 btn btn-outline-success">업데이트</button>
						<button id="btnDelete" class="btn btn-outline-danger">삭제</button>
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

	<c:url var="gPostModifyJS" value="/js/gpost_modify.js" />
	<script src="${gPostModifyJS}"></script>
</body>
</html>