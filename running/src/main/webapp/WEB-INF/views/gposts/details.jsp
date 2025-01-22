<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>코멘트테스트</title>

<!-- Bootstrap CSS 링크. -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>
<body>
	<!-- post section -->


	<!-- comment section js-->
	<section class="gradient-custom" id="commentSection">
	</section>
	
	<script>
       //세션에 저장된 로그인 사용자 아이디를 자바스크립트 변수에 저장.
       //->comment.js 파일의 코드들에서 그 변수를 사용할 수 있도록 하기 위해서
       const signedInUser='${signedInUser}';//문자열 포맷으로 변수를 저장.
    </script>
	
	<!-- Axios Http Js-->
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	
	<c:url value="/js/comment.js" var="commentJs" />
	<script src="${commentJs}"></script>
	
	<!-- Bootstrap Javascript  -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>