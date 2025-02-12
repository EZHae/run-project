<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Running</title>

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
		<c:set var="pageTitle" value="코스 상세보기" />
	</div>

	<div class="container">
		<!-- 코스 상세보기 -->
		<div class="row d-flex justify-content-center">
			<div class="col-md-12 col-lg-10 col-xl-8 mt-4">
				<div class="card p-4 shadow-sm mt-6">
					<div class="card-body">
						<!-- 제목 -->
						<h1 class="text-center text-success mb-4">${course.title}</h1>

						<!-- 코스 아이디 -->
						<div class="mb-3">
							<span class="fw-bold">코스 아이디 <span id="id">${course.id}</span></span> <br>
						</div>

						<!-- 코스 작성자 아이디 -->
						<div class="mb-3">
							<span class="fw-bold">코스 작성자 아이디 <span id="userId">${course.userId}</span></span> <br>
						</div>

						<!-- 코스 작성자 닉네임 -->
						<div class="mb-3">
							<span class="fw-bold">코스 작성자 닉네임 </span> <span>${course.nickname}</span>
						</div>

						<!-- 코스 이름 -->
						<div class="mb-3">
							<span class="fw-bold">코스이름 </span> <span>${course.courseName}</span>
						</div>

						<!-- 소요 시간 -->
						<div class="mb-3">
							<span class="fw-bold">소요 시간 </span> <span>${course.durationTime}</span>
						</div>

						<!-- 코스 내용 -->
						<div class="mb-3">
							<span class="fw-bold">코스 내용 </span> <span>${course.content}</span>
						</div>

						<!-- 코스 분류 -->
						<div class="mb-3">
							<span class="fw-bold">코스 분류 0: 추천, 1: 리뷰 </span>
							<span>${course.category}</span>
						</div>

						<!-- 조회수 -->
						<div class="mb-3">
							<span class="fw-bold">조회수 </span> <span>${course.viewCount}</span>
						</div>

						<!-- 좋아요 수 -->
						<div class="mb-3">
							<span class="fw-bold">좋아요 수 </span> <span>${course.likeCount}</span>
						</div>

						<!-- 작성 시간 -->
						<div class="mb-3">
							<span class="fw-bold">작성 시간 </span> <span>${course.createdTime}</span>
						</div>

						<!-- 최종 수정 시간 -->
						<div class="mb-3">
							<span class="fw-bold">최종 수정 시간 </span> <span>${course.modifiedTime}</span>
						</div>



						<!-- 좋아요 버튼을 js로 처리 -->
						<button class="btn btn-outline-success ms-2" id="btnLike">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
								fill="currentColor" class="bi bi-hand-thumbs-up"
								viewBox="0 0 16 16">
                <path
									d="M6.956 3.745c-.405 0-.747-.342-.747-.747 0-.405.342-.747.747-.747h5.246c.405 0 .747.342.747.747 0 .405-.342.747-.747.747h-2.295c-.243 0-.433.199-.433.433 0 .434.254.725.537.867.056.016.115.032.172.051.354.102.664.385.831.735.073.156.117.321.13.497.04.397.032.808-.02 1.203-.271 1.043-.777 2.204-1.455 3.13-.68.928-1.45 1.61-2.204 1.773-.516.105-.932.5-1.06.996-.16.481-.263 1.197-.151 1.655.145.705.531 1.032.915 1.358.579.46 1.206.742 1.772.97.729.276 1.465.577 2.164.951.593.347.936.926.936 1.594 0 1.028-.79 1.941-1.805 1.987a1.618 1.618 0 0 1-1.302-.641c-.083-.091-.17-.185-.257-.28-.195-.184-.404-.378-.604-.574-.035-.037-.071-.075-.107-.112-.173-.196-.34-.398-.515-.6-.24-.274-.484-.544-.725-.818-.231-.267-.464-.538-.695-.812-.2-.225-.394-.46-.586-.693-.056-.075-.113-.15-.172-.225-.175-.24-.356-.493-.515-.752-.075-.104-.152-.211-.229-.318-.12-.179-.242-.363-.362-.547-.314-.462-.627-.934-.927-1.409-.265-.424-.545-.856-.833-1.269-.45-.615-.93-1.204-1.476-1.65-.581-.477-1.177-.898-1.784-1.369-.081-.073-.158-.146-.234-.219.506-.344.926-.79 1.276-1.28.367-.437.679-.914.95-1.416.255-.48.467-.978.635-1.507.347-.991.578-2.017.681-3.019.168-.946.284-1.896.395-2.85.1-.877-.105-1.697-.567-2.347-.464-.653-1.167-.991-1.963-1.04-.609-.04-1.221.055-1.784.288-.345.15-.618.374-.828.651-.308.404-.528.897-.641 1.413-.119.504-.226 1.005-.301 1.516-.303 1.636-.057 3.367.527 4.933.551 1.853 1.39 3.374 2.388 4.773.254.45.54.872.857 1.277.389.477.845.911 1.344 1.355.708.72 1.52 1.324 2.395 1.812.79.507 1.647.859 2.525 1.144.372.065.773.144 1.175.218 1.064.241 2.12.487 3.212.742.625.088 1.238.176 1.853.264.414.551.626.859 1.063.821 1.459-.022 2.943-.04 4.429-.058 3.591-.037 6.878-.04 9.142-.038.474-.001.741.438.75.883-.011.449-.211.878-.625.86z" />
              </svg>
							좋아요
						</button>
						
						<c:if test="${signedInUserId eq course.userId}">
							<c:url var="courseUpdatePage" value="/course/update">
								<c:param name="id" value="${course.id}" />
							</c:url>
							<a class="btn btn-success" href="${courseUpdatePage}">수정</a>

							<button class="btn btn-danger" id="btnDelete">삭제</button>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS 링크 -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous">
		
	</script>

	<script>
		const signedInUserId = '${signedInUserId}';
		const likeUserIds = '${likeUserIds}'.split(',');
	</script>
	<c:url var="detailsJS" value="/js/course-details.js" />
	<script src="${detailsJS}"></script>
</body>
</html>