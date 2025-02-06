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
		
		<!-- 지해가 작성 -->
		<!-- Bootstrap CSS 링크 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
                rel="stylesheet" 
                integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
                crossorigin="anonymous">
	</head>
	<body>
		<h1>Running Home</h1>


		<c:url var="courseListPage" value="/course/list" />
        <a href="${courseListPage}">courseListPage</a>


        <c:url var="gPostListPage" value="/gpost/list" /> 
        <a href="${gPostListPage}">목록</a>

        
        <c:url var="fileTestPage" value="/gpost/uploadForm" />
        <a href="${fileTestPage}"> 파일</a>
        
        <c:url var="tCalendarListPage" value="/teampage/1/tcalendar/list" /> <%-- /teampage/${testId}/tcalendar/list으로 하니까 팀페이지랑 팀컨트롤등을 안만들고 시작해서 testId을 못가져오니 오류나서 일단 /teampage/1/tcalendar/list로 해서 작업 --%>
        <a href="${tCalendarListPage}">아이디 1인 팀일정페이지</a>
    
        

		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
	</body>
</html>