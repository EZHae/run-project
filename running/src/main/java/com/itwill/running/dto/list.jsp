<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Running</title>
</head>
<body>
	<div>
	    <c:url var="calendarCreatePage" value="/teampage/${teamId}/tcalendar/create" />
	    <a href="${calendarCreatePage}">
	        <button>일정 새글 생성</button>
	    </a>
	</div>
	
	<c:forEach var="calendar" items="${tCalendars}">
	    <c:url var="calendarDetailPage" value="/teampage/${teamId}/tcalendar/details">
	        <c:param name="calendarId" value="${calendar.id}" />
	    </c:url>
	    <a href="${calendarDetailPage}">${calendar.title}</a>
	</c:forEach>
	
	
</body>
</html>