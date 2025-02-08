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
		<input type="hidden" id="teamId" name="teamId" value="${team.teamId}">
		<input type="text" id="teamName" name="teamName" value="${team.teamName}" readonly> <br>
		<input type="text" id="userId" name="userId" value="${team.userId}" readonly> <br>
		<input type="text" id="title" name="title" value="${team.title}" readonly> <br>
		<input type="text" id="content" name="content" value="${team.content}" readonly> <br>
		
		<c:url var="postListPage" value="/teampage/${team.teamId}/post/list" />
		<a href="${postListPage}">팀 게시판</a>
		
		<c:url var="imageListPage" value="/teampage/${team.teamId}/image/list" />
		<a href="${imageListPage}">팀 앨범</a>
		
		<c:url var="calendarListPage" value="/teampage/${team.teamId}/tcalendar/list"/>
		<a href="${calendarListPage}">팀 일정게시판</a>
		
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
	</body>
</html>