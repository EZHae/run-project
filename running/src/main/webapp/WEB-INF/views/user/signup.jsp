<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
		<title>회원가입 : Running</title>
		
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
                    <div>
                        <input type="text" id="userId" name="userId" placeholder="사용자 아이디" required autofocus/>
                    </div>
                    <!-- 사용자 아이디 중복체크 -->
                    <div id="checkUserIdResult">
                    
                    </div>
                    
                    <div>
                        <input type="password" id="password" name="password" placeholder="비밀번호" />
                    </div>
                    <%-- password 중복체크 결과를 출력할 영역 --%>
                    <div id="checkPasswordResult">
                    
                    </div>
                    
                    <div>
                        <input type="text" id="nickname" name="nickname" placeholder="닉네임" />
                    </div>
                    <!-- 사용자 닉네임 중복체크 -->
                    <div id="checkNicknameResult">
                    
                    </div>
                    
                    <div>
                        <input type="text" id="username" name="username" placeholder="사용자 이름" />
                    </div>
                    <div>
                        <select name="gender" id="gender">
                            <option value="1">남성</option>
                            <option value="2">여성</option>
                        </select>
                    </div>
                    <div>
                        <input type="text" id="age" name="age" placeholder="나이" />
                    </div>
                    <!-- 나이 중복체크 -->
                    <div id="checkAgeResult">
                    
                    </div>
                    
                    
                    <div>
                        <input type="text" id="phonenumber" name="phonenumber" placeholder="휴대전화번호" />
                    </div>
                    <!-- 사용자 닉네임 중복체크 -->
                    <div id="checkPhoneNumberResult">
                    
                    </div>
                    <div>
                        <%
                            String[] seoulDistricts = {
                                "강남구", "강동구", "강북구", "강서구", "관악구", "광진구",
                                "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구",
                                "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구",
                                "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"
                            };
                        %>
                        <select name="residence" id="residence" >
                        <option value="">구 선택</option>
                            <% for (String district : seoulDistricts) { %>
                                <option value="<%= district %>"><%= district %></option>
                            <% } %>
                        </select>
                    </div>
                    <div>
                        <input type="text" id="email" name="email" placeholder="이메일" required/>
                    </div>
                     <%-- email 중복체크 결과를 출력할 영역 --%>
                    <div id="checkEmailResult">
                    
                    </div>
                    
                    <div>
                        <input type="hidden" name="authCheck" placeholder="승인" value="1" />
                    </div>
                    
                    <!-- 이미지 라디오 버튼 -->
                    <div>
                        <label>
                            <input type="radio" name="imgId" value="1" checked>
                            <img src="../images/profile01.jpeg" alt="기본 이미지 1" style="width:100px; height:auto; border: 2px solid black; border-radius: 50%;">
                        </label>
                        <label>
                            <input type="radio" name="imgId" value="2">
                            <img src="../images/profile02.jpeg" alt="기본 이미지 2" style="width:100px; height:auto; border: 2px solid black; border-radius: 50%;">
                        </label>
                        <label>
                            <input type="radio" name="imgId" value="3">
                            <img src="../images/profile03.jpeg" alt="기본 이미지 3" style="width:100px; height:auto; border: 2px solid black; border-radius: 50%;">
                        </label>
                        <label>
                            <input type="radio" name="imgId" value="4">
                            <img src="../images/profile04.jpeg" alt="기본 이미지 4" style="width:100px; height:auto; border: 2px solid black; border-radius: 50%;">
                        </label>
                        <label>
                            <input type="radio" name="imgId" value="5">
                            <img src="../images/profile05.jpeg" alt="기본 이미지 5" style="width:100px; height:auto; border: 2px solid black; border-radius: 50%;">
                        </label>
                    </div>
                    <div class="mt-2">
                        <button class="btn disabled" id="btnSignUp">작성 완료</button>
                    </div>
                </form>
            </div>
        </div>
		
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
        
        <!-- Axios JS -->
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        
        <!-- members.js -->
        <c:url var="usersJS" value="/js/users.js"/>
        <script src="${usersJS}"></script>
	</body>
</html>