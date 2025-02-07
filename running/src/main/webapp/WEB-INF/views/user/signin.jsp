<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
		<title>로그인 : Running</title>
		
		<!-- Bootstrap CSS 링크 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" 
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">
	</head>
	<body>
		<c:url value="/" var="homePage" />
        <a href=${homePage }>home</a>
		
        <div>
            <div>
                <form method="post">
                    <c:if test="${not empty param.result and param.result eq 'f' }">
                        <div class="text-danger">아이디와 비밀번호를 확인하세요.</div>
                    </c:if>
                    <div>
                        <input type="text" name="userId" placeholder="사용자 아이디" />
                    </div>
                    <div>
                        <input type="password" name="password" placeholder="비밀번호" />
                    </div>
                    
                    <div class="mt-2">
                        <button type="submit">로그인</button>
                    </div>
                </form>
            </div>
        </div>
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
	</body>
</html>