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
              
              
        <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            background-color: transparent;
        }
        /* 로그인 컨테이너를 화면 중앙 정렬 */
        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 60vh; /* 전체 화면 높이 사용 */
            overflow: hidden; /* 내부 스크롤 방지 */
        }

        .login-card {
            max-width: 400px;
            width: 100%;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.2) !important; /* 부드러운 그림자 효과 */
        }


        .form-control {
            border: 1px solid #28a745;
            box-shadow: 0 0 5px rgba(40, 167, 69, 0.3);
        }

        .btn-login {
            background-color: #28a745;
            border-color: #008C2C;
            color: white;
            font-weight: bold;
            width: 100%;
        }

        .btn-login:hover {
            background-color: #218838;
        }
        </style>
        
	</head>
	<body>
        <%@ include file="../fragments/header.jspf"%>
		<div class="container-fluid">
            <c:set var="pageTitle" value="유저 로그인" />
        </div>
		
    <div class="login-container">
        <div class="card login-card">
            <h3 class="text-center fw-bold text-success">로그인</h3>
            <p class="mt-1"></p>
            <form method="post">
    
                <div class="mb-3">
                    <input type="text" name="userId" class="form-control" placeholder="사용자 아이디" required>
                </div>
                <div class="mb-3">
                    <input type="password" name="password" class="form-control" placeholder="비밀번호" required>
                </div>
                <c:if test="${not empty param.result and param.result eq 'f' }">
                    <div class="text-danger text-center mb-3">아이디와 비밀번호를 확인하세요.</div>
                </c:if>

                <div class="mt-2">
                    <button type="submit" class="btn btn-login btn-lg" style="background-color: #28a745; border-color: #008C2C ; color: white;">로그인</button>
                </div>
            </form>
        </div>
    </div>
    
    	<%@ include file="../fragments/footer.jspf"%>
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
	</body>
</html>