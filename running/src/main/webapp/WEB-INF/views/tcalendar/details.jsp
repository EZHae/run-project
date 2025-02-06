<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
	    
	    <!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정 -->
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    
	    <title>Running</title>
	    
	    <!-- Bootstrap CSS 링크 -->
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
	          rel="stylesheet"
	          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	          crossorigin="anonymous">
	</head>
	<body>
	    <div class="container mt-5">
	        <!-- 제목 -->
	        <h2 class="mb-4">${tCalendar.title}</h2>
	        
	        <!-- 일정 및 내용 -->
	        <div class="mb-3">
	            <p><strong>일정:</strong> ${dateTime}</p>
	            <p><strong>내용:</strong></p>
	            <p>${tCalendar.content}</p>
	        </div>
	
	        <!-- 신청 인원수 -->
	        <div class="mb-3">
	            <p><strong>신청 인원수:</strong> ${tCalendar.currentNum}명 / ${tCalendar.maxNum}명</p>
	        </div>
	
	        <!-- 메시지 표시 -->
	        <c:if test="${not empty message}">
	            <div class="alert alert-info" role="alert">
	                ${message}
	            </div>
	        </c:if>
	
	        <!-- 신청 상태에 따른 버튼 표시 -->
	        <div class="mb-3">
	
	            <form action="<c:url value='/teampage/${teamId}/tcalendar/apply' />" method="post">
	                <input type="hidden" name="calendarId" value="${tCalendar.id}" />
	                
	                <button type="submit" class="btn
	                    <c:choose>
	                        <c:when test="${isApplied}">
	                            btn-danger
	                        </c:when>
	                        <c:otherwise>
	                            btn-primary
	                        </c:otherwise>
	                    </c:choose>
	                "
	                <c:if test="${isFull || isExpired}">
	                    disabled
	                </c:if>
	                >
	                    <c:choose>
	                        <c:when test="${isFull || isExpired}">
	                            모집종료
	                        </c:when>
	                        <c:when test="${isApplied}">
	                            신청취소
	                        </c:when>
	                        <c:otherwise>
	                            신청
	                        </c:otherwise>
	                    </c:choose>
	                </button>
	            </form>
	
	            <!-- 신청한 멤버 보기 버튼 -->
	            <c:url var="viewMembersUrl" value="/teampage/${teamId}/tcalendar/members">
	                <c:param name="calendarId" value="${tCalendar.id}" />
	            </c:url>
	            <a href="${viewMembersUrl}" class="btn btn-info">신청한 멤버 보기</a>
	        </div>
	
	        <!-- 수정 및 삭제 버튼(팀장만 보이게) -->
	        <div class="mb-3">
	            <c:if test="${userId == tCalendar.userId}">
	                <!-- 수정 버튼 -->
	                <c:url var="editUrl" value="/teampage/${teamId}/tcalendar/edit">
	                    <c:param name="calendarId" value="${tCalendar.id}" />
	                </c:url>
	                <a href="${editUrl}" class="btn btn-warning">수정</a>
	                
	                <!-- 삭제 버튼 -->
	                <c:url var="deleteUrl" value="/teampage/${teamId}/tcalendar/delete">
	                    <c:param name="calendarId" value="${tCalendar.id}" />
	                </c:url>
	                <a href="${deleteUrl}" class="btn btn-danger" 
	                   onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
	            </c:if>
	        </div>
	        
	        <!-- 목록으로 돌아가는 버튼 -->
	        <div>
			    <c:url var="listPageUrl" value="/teampage/${teamId}/tcalendar/list" />
			    <a href="${listPageUrl}" class="btn btn-primary">목록으로 돌아가기</a>
			</div>
	    </div>
	
	    <!-- Bootstrap JS 링크 -->
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
	            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	            crossorigin="anonymous">
	    </script>
	</body>
</html>
