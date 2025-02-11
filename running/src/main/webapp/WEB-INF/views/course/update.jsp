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
            <c:set var="pageTitle" value="코스 수정" />
        </div>
		
		<h1>Running CourseUpdate</h1>
		
		
		<form id="updateForm">
		<input class="d-none" id="id" name="id" type="text" value="${course.id}">
		<input id="title" name="title" type="text" value="${course.title}"> <br>
		<input id="courseName" name="courseName" type="text" value="${course.courseName}"> <br>
		<input id="durationTime" name="durationTime" type="text" value="${course.durationTime}"> <br>
		<input id="content" name="content" type="text" value="${course.content}"> <br>
		<input class="d-none" id="category" value="${course.category}">
		<input id="categoryRec" name="category" type="radio" value="0">
		<label for="categoryRec">코스 추천</label>
		<input id="categoryRev" name="category" type="radio" value="1">
		<label for="categoryRev">코스 리뷰</label> <br>
		</form>
		
		<c:if test="${signedInUserId eq course.userId}">
			<button class="btn btn-secondary" id="btnUpdate">수정</button>
		</c:if>
		
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
        
        <c:url var="updateJS" value="/js/course-update.js" />
        <script src="${updateJS}"></script>
	</body>
</html>