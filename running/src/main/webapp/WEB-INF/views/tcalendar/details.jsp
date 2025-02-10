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
              
        <!-- Axios CDN 추가 (head 태그 내) -->
		<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
              
    </head>
    <body>
        <!-- applyUrl 변수 정의 -->
        <c:url var="applyUrl" value="/teampage/${teamId}/tcalendar/apply" />
    
        <!-- 자바스크립트 변수로 전달 -->
        <script>
            const applyUrl = '${applyUrl}';
        </script>
        
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
                <p><strong>신청 인원수:</strong>
                    <span id="currentNum">${tCalendar.currentNum}</span>명 /
                    <span id="maxNum">${tCalendar.maxNum}</span>명
                </p>
            </div>
           
            <!-- 메시지 표시 -->
            <c:if test="${not empty message}">
                <div class="alert alert-info" role="alert">
                    ${message}
                </div>
            </c:if>
    
            <!-- 신청 버튼 : 팀장과 팀멤버 둘다 신청 가능 -->
            <div class="mb-3">
                <button id="applyButton" class="btn
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
                data-calendar-id="${tCalendar.id}"
                data-team-id="${teamId}"
                data-apply-url="${applyUrl}"
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
                
                <!-- 메시지 표시 영역 -->
                <div id="messageArea"></div>
    
                <!-- 신청한 멤버 보기 버튼 -->
				<div>
				    <c:url var="viewMembersUrl" value="/teampage/${teamId}/tcalendar/members">
				        <c:param name="calendarId" value="${tCalendar.id}" />
				    </c:url>
				    <a href="${viewMembersUrl}" class="btn btn-info" id="viewMembersButton">신청한 멤버 보기</a>
			    </div>
                <!---------------신청한 멤버 보기 버튼의 모달 창 구조 -------------------->
                <div class="modal fade" id="membersModal" tabindex="-1" aria-labelledby="membersModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="membersModalLabel">참여 멤버</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <!-- 신청한 멤버 리스트 -->
                                <ul id="membersList" class="list-group">
                                    <!-- AJAX로 데이터를 받아서 여기에 추가 -->
                                </ul>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 수정 및 삭제 버튼(팀장만 보이게) -->
				<div class="mb-3">
				    <c:if test="${isTeamLeader}">
				        <!-- 수정 버튼 : 현재 인원수와 최대인원 수가 같은 경우, 현재시간에 모집시간에 도래한 경우 수정버튼 안보이게 설정함-->
				        <c:if test="${tCalendar.currentNum != tCalendar.maxNum and isBefore}">
				            <div>
				                <c:url var="modifyUrl" value="/teampage/${teamId}/tcalendar/modify">
				                    <c:param name="calendarId" value="${tCalendar.id}"/>
				                </c:url>
				                <a href="${modifyUrl}" class="btn btn-primary">수정</a>
				            </div>
				        </c:if>
				
				        <!-- 삭제 버튼 -->
				        <div>
				            <c:url var="deleteUrl" value="/teampage/${teamId}/tcalendar/delete">
				                <c:param name="calendarId" value="${tCalendar.id}"/>
				            </c:url>
				            <form action="${deleteUrl}" method="post" style="display: inline;">
				                <button type="submit" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>
				            </form>
				        </div>
				    </c:if>
				
				    <!-- 목록으로 돌아가는 버튼 -->
				    <div>
				        <c:url var="listPageUrl" value="/teampage/${teamId}/tcalendar/list"/>
				        <a href="${listPageUrl}" class="btn btn-primary">목록으로 돌아가기</a>
				    </div>
				</div>
								
    
            <!-- Bootstrap JS 링크 -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
                    crossorigin="anonymous">
            </script>
    
            <!-- 신청버튼 JS -->
            <c:url var="detailsJS" value="/js/tcalendar_details.js" />
            <script src="${detailsJS}"></script>
            
            <!-- 신청한 멤버 보기 버튼 JS -->
            <c:url var="viewTCalendarMembersJS" value="/js/tcalendar_viewTCalendarMembers.js"/>
            <script src="${viewTCalendarMembersJS}"></script>
            
            
        </body>
</html>
