<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>팀수정</title>

<!-- Bootstrap CSS 링크. -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>


<body class="container mt-5">
	<%@ include file="../fragments/header.jspf"%>
	<div class="container-fluid">
		<c:set var="pageTitle" value="팀 수정" />
	</div>

	<div class="container my-3">
		<div class="row d-flex justify-content-center">
			<div class="col-md-12 col-lg-10 col-xl-8">
				<div class="card p-4 shadow">
					<h2 class="mb-4 text-center">팀 수정</h2>
					<c:url value="/team/update" var="teamUpdate" />
					<form action="${teamUpdate}" method="post" id="teamForm"
						enctype="multipart/form-data">
						<!-- 팀 아이디 -->
						<div class="mb-3">
							<input type="hidden" id="teamId" name="teamId"
								value="${teamItemDto.teamId}" class="form-control">
						</div>


						<!-- 팀 이름 -->
						<div class="mb-3">
							<label for="teamName" class="form-label">팀 이름</label> <input
								type="text" id="teamName" name="teamName"
								value="${teamItemDto.teamName}" class="form-control" required>
						</div>

						<!-- 배너 업로드(이미지만 1개 업로드 가능) -->
						<div class="mb-3">
							<label for="imageUpload" class="form-label">팀 대표 이미지 변경</label> <input
								type="file" class="form-control" id="imageUpload" name="file"
								accept="image/*">
						</div>

						<!-- 배너 미리보기 -->
						<div class="mb-3" id="newImg">
							<img id="imageNewPreview" src="#" alt="미리보기"
								style="max-width: 200px; display: none;"> <label
								for="imageOGPreview" class="form-label">기존 배너</label> <img
								id="imageOGPreview" src="${teamItemDto.imagePath}" alt="미리보기"
								style="max-width: 200px; display: block;">
						</div>

						<!-- 제목 -->
						<div class="mb-3">
							<label for="title" class="form-label">제목</label> <input
								type="text" id="title" name="title" class="form-control"
								value="${teamItemDto.title}" required>
						</div>

						<!-- 내용 -->
						<div class="mb-3">
							<label for="content" class="form-label">내용</label>
							<textarea id="content" name="content" class="form-control"
								rows="4" required placeholder="공백포함 최대 300자">${teamItemDto.content}</textarea>
						</div>

						<!-- 구 선택 -->
						<div class="mb-3">
							<label for="districtSelect" class="form-label">구 선택</label> <select
								id="districtSelect" class="form-select">
								<option value="" selected disabled>${park.parkLoc}</option>
							</select>
						</div>

						<!-- 공원 선택 -->
						<div class="mb-3">
							<label for="parkId" class="form-label">공원 선택</label> <select
								id="selectPark" class="form-select">
								<option value="" selected disabled>${park.parkName}</option>
							</select>
						</div>
						<!-- 최대 인원 -->
						<div class="mb-3">
							<label for="maxNum" class="form-label">본인을 포함한 최대 인원</label> <input
								type="number" id="maxNum" name="maxNum" class="form-control"
								min="${teamItemDto.currentNum}" max="30" required
								value="${teamItemDto.maxNum}"
								placeholder="현재 ${teamItemDto.currentNum+1}명 이상으로만 변경가능합니다">
						</div>

						<!-- 연령 제한 (현재 회원수 이상으로만 수정 가능) -->
						<div class="mb-3">
							<label for="ageLimit" class="form-label">연령 제한</label> <input
								type="number" id="ageLimit" name="ageLimit" class="form-control"
								max="${teamItemDto.ageLimit}" value="${teamItemDto.ageLimit}"
								required>
						</div>

						<!-- 성별 제한 -->
						<div class="mb-3">
							<label for="genderLimit" class="form-label">성별 제한</label> <select
								id="genderLimit" name="genderLimit" class="form-select" required>
							</select>
						</div>

						<!-- 제출 버튼 -->
						<c:if test="${signedInUserId==teamItemDto.userId}">
						<button type="submit" class="btn btn-success w-100">수정</button></c:if>
					</form>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../fragments/footer.jspf"%>
	<!-- Bootstrap Javascript  -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

	<script>
		//세션에 저장된 로그인 사용자 아이디를 자바스크립트 변수에 저장.
		const signedInUserId = '${signedInUserId}';//문자열 포맷으로 변수를 저장.
		const teamId = '${teamItemDto.teamId}';
		const teamName = '${teamItemDto.teamName}';
		const tmemNum = '${tmembers.size()}';
		const tgenderLimit = '${teamItemDto.genderLimit}';

		// 이미지 미리보기 기능
		document.getElementById("imageUpload").addEventListener("change",
				function(event) {
					const file = event.target.files[0]; //사용자가 선택한 첫번째 사진
					const preview = document.getElementById("imageNewPreview");

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

	<c:url value="/js/team-update.js" var="teamUpdateJs" />
	<script src="${teamUpdateJs}"></script>
</body>
</html>