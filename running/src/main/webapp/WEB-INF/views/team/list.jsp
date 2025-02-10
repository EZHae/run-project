<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>TeamLists</title>

<!-- Bootstrap CSS 링크. -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
</head>
<body>
    <c:url value="/" var="homePage" />
    <a href=${homePage }>home</a>
	<div>
		<c:url var="teamCreatePage" value="/team/create" />
		<a href="${teamCreatePage}">새 팀 생성</a>
	</div>

    <div>
        <c:url value="/team/list" var="teamListUrl">
            <c:param name="status" value="open" />
        </c:url>
        <c:url value="/team/list" var="closedListUrl">
            <c:param name="status" value="closed" />
        </c:url>
            <div>
                <a href="${teamListUrl}">
                    <button style="${status eq 'open' }">모집중</button>
                </a>
                <a href="${closedListUrl}">
                    <button style="${status eq 'closed'}">모집완료</button>
                </a>
            </div>
        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>팀이름</th>
                    <th>작성자</th>
                    <th>인원수</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${teams}" var="team">
                    <tr>
                        <td>${team.teamId}</td>
                        <td>
                        <c:url var="teamDetailPage" value="/team/details">
                            <c:param name="teamid" value="${team.teamId}" />
                        </c:url>
                        <a href="${teamDetailPage}">${team.teamName}</a>
                        </td>
                        <td>${team.userId}</td>
                        <td>${team.currentNum}/${team.maxNum}</td>
                        <td>${team.createdTime}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <!-- Bootstrap Javascript  -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
</body>
</html>