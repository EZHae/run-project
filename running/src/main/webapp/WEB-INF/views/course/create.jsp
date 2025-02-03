<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		
		<h1>새글작성</h1>
		<c:url value="/course/create" var="coureCreatePage"/>
		<form action="${coureCreatePage}" method="post">
			<input id="categoryRec" name="category" type="radio" value="0" checked>
			<label for="categoryRec">코스 추천</label>
			<input id="categoryRev" name="category" type="radio" value="1">
			<label for="categoryRev">코스 리뷰</label>
			
			<br>
			<input id="title" name="title" type="text" value="${course.title}" placeholder="제목" required> <br>
			<input id="courseName" name="courseName" type="text" value="${course.courseName}" placeholder="코스명" required> <br>
			<input id="durationTime" name="durationTime" type="text" value="${course.durationTime}" placeholder="소요시간" required> <br>
			<input id="content" name="content" type="text" value="${course.content}" placeholder="내용" required> <br>
			<input class="d-none" id ="userId" type="text" name="userId" value="${ signedInUserId }" readonly/>
			<input id ="nickname" type="text" name="nickname" value="${ signedInUserNickname }" readonly/><br>
			<button type="submit">작성완료</button>
		</form>
		
	
		
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
	</body>
</html>