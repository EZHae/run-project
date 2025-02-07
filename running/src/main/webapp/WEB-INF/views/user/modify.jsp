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
        <c:url value="/" var="homePage" />
        <a href=${homePage }>home</a>
        
        <div>
            <div>
                <form method="post">
                
                <c:if test="${empty sessionScope.signedInUserId}">
                        <p style="color: red;">사용자 ID 없음</p>
                    </c:if>
                   <div>
                    <img src="<c:url value='/image/view/user/${signedInUserId}' />" alt="프로필 이미지" style="width:70px; height:70px; border-radius:50%;"/>
                        <button type="button" id="changeImageBtn" data-user-id="${sessionScope.signedInUserId}">변경</button>
                    </div> 
                    
                    <div class="modal" tabindex="-1" id="imageModal">
                      <div class="modal-dialog">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title">프로필 이미지 변경</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <div class="modal-body text-center" >
                            <img id="previewImage" src="<c:url value='/image/view/user/${signedInUserId}' />" alt="프로필 이미지 미리보기" style="width:70px; height:70px; border-radius:50%;"/>
                            
                            <input type="file" id="imageUpload" accept="image/*" >
                          </div>
                          <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                            <button id="uploadBtn" type="button" class="btn btn-primary">업로드</button>
                          </div>
                        </div>
                      </div>
                    </div>
                    
                    <div>
                        <input class="d-none" type="text" id="userId" name="userId" placeholder="사용자 아이디" required autofocus/>
                    </div>
                    <div>
                        <input class="d-none" type="password" id="password" name="password" placeholder="비밀번호" />
                    </div>
                    <%-- password 중복체크 결과를 출력할 영역 --%>
                    <div id="checkPasswordResult">
                    
                    </div>
                    
                    <div>
                        <label> 닉네임 </label>
                        <input type="text" id="nickname" name="nickname" value="${user.nickname}"/>
                    </div>
                    <!-- 사용자 닉네임 중복체크 -->
                    <div id="checkNicknameResult">
                    
                    </div>
                    
                    <div>
                        <label> 이름 </label>
                        <input type="text" id="username" name="username" value="${user.username}" />
                    </div>
                    <div>
                        <select name="gender" id="gender" class="d-none">
                            <option value="1">남성</option>
                            <option value="2">여성</option>
                        </select>
                    </div>
                    <div>
                        <input class="d-none" type="text" id="age" name="age" value="${user.age}" />
                    </div>
                    
                    <div>
                        <label> 휴대전화번호 </label>
                        <input type="text" id="phonenumber" name="phonenumber" value="${user.phonenumber}" />
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
                        <select name="residence" id="residence" class="d-none">
                        <option value="">구 선택</option>
                            <% for (String district : seoulDistricts) { %>
                                <option value="<%= district %>"><%= district %></option>
                            <% } %>
                        </select>
                    </div>
                    <div>
                        <label> 이메일 </label>
                        <input type="text" id="email" name="email" value="${user.email}"/>
                    </div>
                     <%-- email 중복체크 결과를 출력할 영역 --%>
                    <div id="checkEmailResult">
                    
                    </div>
                    
                    <div>
                        <input type="hidden" name="authCheck" placeholder="승인" value="1" />
                    </div>
                    <div class="mt-2">
                        <button class="btn" id="btnSignUp">작성 완료</button>
                    </div>
                </form>
                
                <hr/>
                <div>
                    <button >비밀번호 변경</button>
                    <button id="btnDelete" data-user-id="${sessionScope.signedInUserId}">계정 탈퇴</button>
                </div>
                <div>
                    <a></a>
                </div>
            </div>
        </div>
    

      	
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
        
        <!-- Axios JS -->
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        
        <c:url var="userModifyJS" value="/js/user_modify.js"/>
        <script src="${userModifyJS}"></script>
	</body>
</html>