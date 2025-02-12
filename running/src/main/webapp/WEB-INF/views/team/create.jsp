<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>새 팀 생성</title>

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
		<c:set var="pageTitle" value="팀 생성" />
	</div>

	<c:url var="courseRecruitPage" value="/team/list" />
	<a href="${courseRecruitPage}"> </a>

	<div class="container my-3">
		<div class="row d-flex justify-content-center">
			<div class="col-md-12 col-lg-10 col-xl-8">
				<div class="card p-4 shadow">
					<h2 class="mb-4 text-center">팀 생성</h2>
					<c:url value="/team/create" var="teamCreatePage" />
					<form action="${teamCreatePage}" method="post" id="teamForm"
						enctype="multipart/form-data">

						<!-- 팀 이름 -->
						<div class="mb-3">
							<label for="teamName" class="form-label">팀 이름</label> <input
								type="text" id="teamName" name="teamName" class="form-control"
								required>
						</div>

						<!-- 배너 업로드 -->
						<div class="mb-3">
							<label for="imageUpload" class="form-label">팀 대표 이미지 업로드</label>
							<input type="file" class="form-control" id="imageUpload"
								name="file" accept="image/*" required>
						</div>

						<!-- 배너 미리보기 -->
						<div class="mb-3 text-center">
							<img id="imagePreview" src="#" alt="미리보기"
								style="max-width: 200px; display: none;">
						</div>

						<!-- 제목 -->
						<div class="mb-3">
							<label for="title" class="form-label">제목</label> <input
								type="text" id="title" name="title" class="form-control"
								required>
						</div>

						<!-- 내용 -->
						<div class="mb-3">
							<label for="content" class="form-label">내용</label>
							<textarea id="content" name="content" class="form-control"
								rows="4" required placeholder="공백 포함 최대 300자"></textarea>
						</div>

						<!-- 구 선택 -->
						<div class="mb-3">
							<label for="districtSelect" class="form-label">구 선택</label> <select
								id="districtSelect" class="form-select" required>
								<option value="" selected disabled>구 선택</option>
								<option value="강남구">강남구</option>
								<option value="강동구">강동구</option>
								<option value="강북구">강북구</option>
								<option value="강서구">강서구</option>
								<option value="관악구">관악구</option>
								<option value="광진구">광진구</option>
								<option value="구로구">구로구</option>
								<option value="금천구">금천구</option>
								<option value="노원구">노원구</option>
								<option value="도봉구">도봉구</option>
								<option value="동대문구">동대문구</option>
								<option value="동작구">동작구</option>
								<option value="마포구">마포구</option>
								<option value="서대문구">서대문구</option>
								<option value="서초구">서초구</option>
								<option value="성동구">성동구</option>
								<option value="성북구">성북구</option>
								<option value="송파구">송파구</option>
								<option value="양천구">양천구</option>
								<option value="영등포구">영등포구</option>
								<option value="용산구">용산구</option>
								<option value="은평구">은평구</option>
								<option value="종로구">종로구</option>
								<option value="중구">중구</option>
								<option value="중랑구">중랑구</option>
							</select>
						</div>

						<!-- 공원 선택 -->
						<div class="mb-3">
							<label for="selectPark" class="form-label">공원 선택</label> <select
								id="selectPark" name="parkId" class="form-select" required>
								<option id="selectPark" value="" selected disabled>먼저 구를 선택하세요</option>
							</select>
						</div>
						<div>
							<div id="map"></div>
						</div>

						<!-- 최대 인원 -->
						<div class="mb-3">
							<label for="maxNum" class="form-label">본인을 포함한 최대 인원</label> <input
								type="number" id="maxNum" name="maxNum" class="form-control"
								min="2" max="30" required>
						</div>

						<!-- 연령 제한 -->
						<div class="mb-3">
							<label for="ageLimit" class="form-label">연령 제한</label> <input
								type="number" id="ageLimit" name="ageLimit" class="form-control"
								min="0" placeholder="예: 20 (20세 이상)" required>
						</div>

						<!-- 성별 제한 -->
						<div class="mb-3">
							<label for="genderLimit" class="form-label">성별 제한</label> <select
								id="genderLimit" name="genderLimit" class="form-select" required>
								<option value="0">성별 무관</option>
								<option value="1">남성만</option>
								<option value="2">여성만</option>
							</select>
						</div>

						<!-- 제출 버튼 -->
						<button type="submit" class="btn w-100"
							style="background-color: #28a745; color: white;">팀 생성</button>
					</form>
				</div>
			</div>
		</div>
	</div>


	<!-- Bootstrap Javascript  -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>

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
<<<<<<< HEAD

	<!-- 카카오 맵 API -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d1d3b87ab7851c5ad6b2ab818eba8506"></script>
	
=======
	<%@ include file="../fragments/footer.jspf"%>
>>>>>>> 44f960e0c94b5154f07628fbfc287e7bf20fd54c
	<!-- Axios Http Js-->
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

	<c:url value="/js/team-create.js" var="teamCreateJs" />
	<script src="${teamCreateJs}"></script>

</body>
</html>