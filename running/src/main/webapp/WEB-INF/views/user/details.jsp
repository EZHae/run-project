<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
		<title>마이페이지</title>
		
		<!-- Bootstrap CSS 링크 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" 
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">
              
      
	</head>
	<body>
        <%@ include file="../fragments/header.jspf"%>
		<div class="container-fluid">
            <c:set var="pageTitle" value="유저 상세보기" />
        </div>
        
        <div>
            <div>
                <form method="post">
                   <div>
                    <img src="<c:url value='/image/view/user/${signedInUserId}' />" alt="프로필 이미지" style="width:70px; height:70px; border-radius:50%;"/>
                    </div> 
                    <div>
                        <input class="d-none" type="text" id="userId" name="userId" />
                    </div>
                    <div>
                        <input class="d-none" type="password" id="password" name="password" placeholder="비밀번호" />
                    </div>
                    <div>
                        <label> 닉네임 </label>
                        <input type="text" id="nickname" name="nickname" value="${user.nickname}" readonly/>
                    </div>
                    <div>
                        <label> 이름 </label>
                        <input  type="text" id="username" name="username" value="${user.username}" readonly />
                    </div>
                    <div>
                        <div>
                            <label> 성별 </label>
                            <input type="text" id="gender" name="gender" 
                            value="<c:choose>
                            <c:when test='${user.gender == 1}'>남자</c:when>
                            <c:when test='${user.gender == 2}'>여자</c:when>
                            </c:choose>
                            " readonly />
                        </div>
                    </div>
                    <div>
                        <label> 나이 </label>
                        <input type="text" id="age" name="age" value="${user.age}" readonly/>
                    </div>
                    <div>
                        <label> 휴대전화번호 </label>
                        <input type="text" id="phonenumber" name="phonenumber" value="${user.phonenumber}" readonly/>
                    </div>
                    <div>
                        <label> 주소구 </label>
                        <input type="text" id="residence" name="residence" value="${user.residence}" readonly/>
                    </div>
                    <div>
                        <label> 이메일 </label>
                        <input type="text" id="email" name="email" value="${user.email}" readonly/>
                    </div>
                    
                    <div>
                        <input type="hidden" name="authCheck" placeholder="승인" value="1" />
                    </div>
                    
                </form>
                    
                    <!-- 로그인 아이디가 작성자 아이디와 같을 때 수정하기 버튼이 활성화 -->
<%--                     <c:if test="${signedInUserNickname}"> --%>
                    <div class="card-footer">
                        <div class="d-flex justify-content-center">
                            <c:url var="userModifyPage" value="/user/modify">
                                <c:param name="userId" value="${user.userId}"/>
                            </c:url>
                            <a class="btn btn-outline-success"
                                href="${userModifyPage}">수정</a>
                        </div>
                    </div>
<%--                     </c:if> --%>
            </div>
        </div>
    

      	
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
        
        <!-- Axios JS -->
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        
<%--         <c:url var="userDetailsJS" value="/js/user_details.js"/> --%>
<%--         <script src="${userDetailsJS}"></script> --%>
	</body>
</html>