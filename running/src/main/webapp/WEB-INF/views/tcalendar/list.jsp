<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	
	<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<title>Running</title>
	
	<!-- Bootstrap CSS 링크 -->
	<link
	    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	    rel="stylesheet"
	    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	    crossorigin="anonymous">
	
	<!-- CSS 스타일 -->
	<style>
	.card-container {
	    display: flex;
	    flex-wrap: wrap;
	    gap: 20px;
	}
	
	.card {
	    width: calc(33.333% - 20px); /* 한 줄에 3개의 카드 표시 */
	    border: 1px solid #ccc; /* 카드 테두리 추가 */
	    border-radius: 8px;
	    overflow: hidden;
	    background-color: #fff;
	    box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.1); /* 카드 그림자 추가 */
	    margin-bottom: 20px; /* 카드 사이 간격 추가 */
	}
	
	.card-header {
	    background-color: #f5f5f5;
	    padding: 10px;
	    font-weight: bold;
	    border-bottom: 1px solid #ccc; /* 헤더와 바디 구분선 추가 */
	    display: flex;
	    justify-content: space-between; /* 일정과 상태를 양쪽으로 정렬 */
	    align-items: center; /* 수직 중앙 정렬 */
	}
	
	.card-body {
	    padding: 15px;
	}
	
	.card-title {
	    margin-top: 0;
	    margin-bottom: 10px;
	    font-size: 1.25em;
	}
	
	.card-text {
	    margin-bottom: 10px;
	}
	
	.btn {
	    display: inline-block;
	    padding: 8px 12px;
	    color: #fff;
	    background-color: #007bff;
	    text-decoration: none;
	    border-radius: 4px;
	}
	
	.btn:hover {
	    background-color: #0056b3;
	}
	
	@media ( max-width : 768px) {
	    .card {
	        width: calc(50% - 20px); /* 화면이 좁아지면 한 줄에 2개씩 표시 */
	    }
	}
	
	@media ( max-width : 480px) {
	    .card {
	        width: 100%; /* 모바일 화면에서는 한 줄에 하나씩 표시 */
	    }
	}
	</style>
	</head>
	<body>
        <%@ include file="../fragments/header.jspf"%>
		<div class="container-fluid">
            <c:set var="pageTitle" value="팀 일정 목록" />
        </div>
        
		<!-- 새글 생성 버튼 (팀장만 보이게)  -->
	    <div style="margin-top: 20px;">
	        <c:url var="calendarCreatePage" value="/teampage/${teamId}/tcalendar/create" />
	        <c:if test="${isTeamLeader}">
	            <a href="${calendarCreatePage}" class="btn">일정 새글 생성</a>
	        </c:if>
	    </div>
	
	    <div class="card-container">
	        <c:forEach var="calendar" items="${tCalendars}">
	            <div class="card">
	                <div class="card-header">
	                    <span>${calendar.formattedDateTime}</span>
	                    <!-- 일정의 날짜와 시간 -->
	                    <span>
	                        <c:choose>
	                        	<%-- 현재 인원수가 최대인원수보다 작은 경우 or 현재 시간이 dateTime(모이는 시간)에 도래하지 않은 경우에만 모집중으로 보이게  --%>
	                            <c:when test="${calendar.currentNum < calendar.maxNum and !calendar.expired}">
	                                <span style="color: red;">모집중</span>
	                            </c:when>
	                            <c:otherwise>
	                                <span style="color: gray;">모집종료</span>
	                            </c:otherwise>
	                        </c:choose>
	                    </span>
	                </div>
	                <div class="card-body">
	                    <h5 class="card-title">${calendar.title}</h5>
	                    <p class="card-text">
	                        <c:choose>
	                            <c:when test="${fn:length(calendar.content) > 15}">
	                                ${fn:substring(calendar.content, 0, 15)}...
	                            </c:when>
	                            <c:otherwise>
	                                ${calendar.content}
	                            </c:otherwise>
	                        </c:choose>
	                    </p>
	                    <p class="card-text">인원: ${calendar.currentNum}명 / ${calendar.maxNum}명</p>
	                    <c:url var="calendarDetailPage" value="/teampage/${teamId}/tcalendar/details">
	                        <c:param name="calendarId" value="${calendar.id}" />
	                    </c:url>
	                    <a href="${calendarDetailPage}" class="btn">자세히 보기</a>
	                </div>
	            </div>
	        </c:forEach>
	    </div>
	
	    <!-- Bootstrap JS 링크 -->
	    <script
	        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	        crossorigin="anonymous">
	    </script>
	</body>
</html>

