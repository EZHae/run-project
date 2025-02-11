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
        <%@ include file="./fragments/header.jspf"%>
		<div class="container-fluid">
            <c:set var="pageTitle" value="권한없음" />
        </div>
        
		<div>
			<span>에러코드: ${errorcode}</span>
		</div>
		<div>
			<c:choose>
				<c:when test="${errordetail == 1}">
					<span>권한없음: 로그인 계정과 글 작성자가 일치하지 않습니다.</span>
				</c:when>
				<c:when test="${errordetail == 2}">
					<span>권한없음: 로그인 계정이 해당 팀의 멤버가 아닙니다.</span>
				</c:when>
				<c:otherwise>
					<span>권한없음: 팀장만 접근할 수 있습니다.</span>
				</c:otherwise> 
			</c:choose>
		</div>
		
		
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
	</body>
</html>