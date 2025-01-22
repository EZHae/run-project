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
		
		<h1>Running CourseUpdate</h1>
		<input id="title" name="title" type="text" value="${course.title}"> <br>
		<input id="courseName" name="courseName" type="text" value="${course.courseName}"> <br>
		<input id="durationTime" name="durationTime" type="text" value="${course.durationTime}"> <br>
		<input id="content" name="content" type="text" value="${course.content}"> <br>
		<input id="categoryRec" name="category" type="radio" value="0">
		<label for="categoryRec">코스 추천</label>
		<input id="categoryRev" name="category" type="radio" value="1">
		<label for="categoryRev">코스 리뷰</label>
		
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
	</body>
</html>