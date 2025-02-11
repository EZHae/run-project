<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
				
		<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
	    <title>모임 일정 수정</title>
	    
	    <!-- Bootstrap CSS 링크 -->
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
	          rel="stylesheet" 
	          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
	          crossorigin="anonymous">                
	
	</head>
	<body>
        <%@ include file="../fragments/header.jspf"%>
		<div class="container-fluid">
            <c:set var="pageTitle" value="팀 일정 게시글 수정" />
        </div>
		
		<c:url var="teamPage" value="/team/details">
			<c:param name="teamid" value="${teamId}" />
		</c:url>
		<a href="${teamPage}">내 팀으로</a>
		
		<c:url var="postListPage" value="/teampage/${teamId}/post/list" />
		<a href="${postListPage}">팀 게시판</a>
		
		<c:url var="imageListPage" value="/teampage/${teamId}/image/list" />
		<a href="${imageListPage}">팀 앨범</a>
		
		<c:url var="calendarListPage" value="/teampage/${teamId}/tcalendar/list" />
		<a href="${calendarListPage}">팀 일정 게시판</a>

	    <h2>팀 일정 게시글 수정</h2>
	    
	    <c:url value="/teampage/${teamId}/tcalendar/update" var="tCalendarUpdatedPage"/>
	    <form action="${tCalendarUpdatedPage}" method="post">
	        <input type="hidden" name="calendarId" value="${tCalendar.id}" />
	        <table>
	            <tr>
	                <td><label for="title">제목:</label></td>
	                <td><input type="text" id="title" name="title" value="${tCalendar.title}" readonly></td>
	            </tr>
	            <tr>
	                <td><label for="date">날짜/시간:</label></td>
	                <td><input type="text" id="date" name="date" autocomplete="off" value="${dateTime}" disabled></td>
	            </tr>
	            <tr>
	                <td><label for="content">내용:</label></td>
	                <td><textarea id="content" name="content" rows="5" cols="30" readonly>${tCalendar.content}</textarea></td>
	            </tr>
	            <tr>
	            	<!-- 최대인원수 수정 가능 범위 : 게시글의 최대인원수 ~ 99 -->
	                <td><label for="max_num">최대 인원수:</label></td>
	                <td><input type="number" id="max_num" name="max_num" min="${tCalendar.maxNum}" max="99" placeholder="${tCalendar.maxNum}" required autofocus></td>
	            </tr>
	            <tr>
	                <td colspan="2" style="text-align: center;">
	                    <button type="submit">작성완료</button>
	                </td>
	            </tr>
	        </table>
	    </form>
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
	            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
	            crossorigin="anonymous"></script>
	            
	</body>
	
</html>