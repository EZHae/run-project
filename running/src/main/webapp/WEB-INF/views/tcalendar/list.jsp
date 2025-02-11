<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Running</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous">
<style>
.card-container {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}
.card {
    width: calc(50% - 20px); /* 한 줄에 2개의 카드 표시 */
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
.pagination {
    display: flex;
    justify-content: center;
    margin-top: 20px;
}
.pagination a {
    color: #007bff;
    padding: 8px 12px;
    text-decoration: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    margin: 0 4px;
}
.pagination a:hover {
    background-color: #007bff;
    color: #fff;
}
.pagination a.active {
    background-color: #007bff;
    color: #fff;
}
</style>
</head>
<body>
    <!-- 새글 생성 버튼 (팀장만 보이게) -->
    <div style="margin-top: 20px;">
        <c:url var="calendarCreatePage" value="/teampage/${teamId}/tcalendar/create" />
        <c:if test="${isTeamLeader}">
            <a href="${calendarCreatePage}" class="btn">일정 새글 생성</a>
        </c:if>
    </div>

    <!-- 필터링 콤보박스 -->
    <c:url value="/teampage/${teamId}/tcalendar/list" var="ListPage"/>
    <form action="${ListPage}" method="get">
        <label for="filter">검색:</label>
        <select name="filter" id="filter" onchange="this.form.submit()">
            <option value="1" ${filter == '1' ? 'selected' : ''}>전체</option>
            <option value="2" ${filter == '2' ? 'selected' : ''}>모집중인 게시글</option>
            <option value="3" ${filter == '3' ? 'selected' : ''}>모집종료된 게시글</option>
        </select>
    </form>

    <div class="card-container">
        <c:forEach var="calendar" items="${tCalendars}">
            <div class="card">
                <div class="card-header">
                	<!-- 일정의 날짜와 시간 -->
                    <span>${calendar.formattedDateTime}</span>
                    <span>
                        <c:choose>
                            <%-- 현재 인원수가 최대인원수보다 작은 경우 or 현재 시간이 dateTime(모이는 시간)에 도래하지 않은 경우에만 '모집중'으로 보이게 --%>
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

    <!-- 페이징 처리 : 페이지 숫자버튼 5개까지 보임-->
    <c:set var="beginPage" value="${1}" />
	<c:set var="endPage" value="${1}" />
	<c:choose>
	    <c:when test="${currentPage <= 3}">
	        <c:set var="beginPage" value="${1}" />
	        <c:set var="endPage" value="${totalPages < 5 ? totalPages : 5}" />
	    </c:when>
	    <c:otherwise>
	        <c:set var="beginPage" value="${currentPage - 2}" />
	        <c:set var="endPage" value="${(currentPage + 2) > totalPages ? totalPages : (currentPage + 2)}" />
	    </c:otherwise>
	</c:choose>
	
	<div class="pagination">
	    <c:if test="${currentPage > 1}">
	        <c:url var="firstPageUrl" value="/teampage/${teamId}/tcalendar/list">
	            <c:param name="page" value="1" />
	            <c:param name="filter" value="${filter}" />
	        </c:url>
	        <a href="${firstPageUrl}" class="first">첫 페이지</a>
	    </c:if>
	
	    <c:if test="${currentPage > 1}">
	        <c:url var="prevPageUrl" value="/teampage/${teamId}/tcalendar/list">
	            <c:param name="page" value="${currentPage - 1}" />
	            <c:param name="filter" value="${filter}" />
	        </c:url>
	        <a href="${prevPageUrl}" class="prev">이전</a>
	    </c:if>
	
	    <c:forEach begin="${beginPage}" end="${endPage}" var="i">
	        <c:url var="pageUrl" value="/teampage/${teamId}/tcalendar/list">
	            <c:param name="page" value="${i}" />
	            <c:param name="filter" value="${filter}" />
	        </c:url>
	        <a href="${pageUrl}" class="${i == currentPage ? 'active' : ''}">${i}</a>
	    </c:forEach>
	
	    <c:if test="${currentPage < totalPages}">
	        <c:url var="nextPageUrl" value="/teampage/${teamId}/tcalendar/list">
	            <c:param name="page" value="${currentPage + 1}" />
	            <c:param name="filter" value="${filter}" />
	        </c:url>
	        <a href="${nextPageUrl}" class="next">다음</a>
	    </c:if>
	
	    <c:if test="${currentPage < totalPages}">
	        <c:url var="lastPageUrl" value="/teampage/${teamId}/tcalendar/list">
	            <c:param name="page" value="${totalPages}" />
	            <c:param name="filter" value="${filter}" />
	        </c:url>
	        <a href="${lastPageUrl}" class="last">마지막 페이지</a>
	    </c:if>
	</div>
    
    <!-- Bootstrap JS 링크 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
</body>

</html>