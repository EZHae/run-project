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
	<c:forEach var="calendar" items="${tCalendars}">
	    <c:url var="calendarDetailPage" value="/teampage/${teamId}/tcalendar/details">
	        <c:param name="calendarId" value="${calendar.id}" />
	    </c:url>
	    <a href="${calendarDetailPage}">${calendar.title}</a>
	</c:forEach>
	
	<div>
	<c:url var="calendarCreatePage" value="/teampage/${teamId}/tcalendar/create" />
	<a href="${calendarCreatePage}">일정 새글 생성</a>
	</div>
	
</body>
</html>