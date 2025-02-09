<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
                    
                    <!-- 유저 프로필 이미지 -->
                    <div>
                        <img src="<c:url value='/image/view/user/${signedInUserId}' />" alt="프로필 이미지" style="width:70px; height:70px; border-radius:50%;"/>
                            <button type="button" id="changeImageBtn" data-user-id="${sessionScope.signedInUserId}">변경</button>
                    </div>

                    <div class="modal" tabindex="-1" id="imageModal">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">프로필 이미지 변경</h5>
                                    <button type="button" class="btn-close"
                                        data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                                </div>
                                <div class="modal-body text-center">
                                    <img id="previewImage"
                                        src="<c:url value='/image/view/user/${signedInUserId}' />"
                                        alt="프로필 이미지 미리보기"
                                        style="width: 70px; height: 70px; border-radius: 50%;" />
    
                                    <c:set var="imageList"
                                        value="${fn:split('profile01.jpeg,profile02.jpeg,profile03.jpeg,profile04.jpeg,profile05.jpeg', ',')}" />
    
                                    <div id="imageForm">
                                        <c:forEach var="image"
                                            items="${imageList}"
                                            varStatus="status">
                                            <label> <input
                                                type="radio" name="imgId"
                                                value="${status.index + 1}"
                                                ${userImagePath.endsWith(image) ? 'checked' : ''}>
                                                <img
                                                src="../images/${image}"
                                                alt="기본 이미지 ${status.index + 1}"
                                                data-img-id="${status.index + 1}"
                                                data-image-name="기본 이미지 ${status.index + 1}"
                                                data-image-file="${image}"
                                                style="width: 100px; height: auto; border: 2px solid black; border-radius: 50%;">
                                            </label>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button"
                                        class="btn btn-secondary"
                                        data-bs-dismiss="modal">취소</button>
                                    <button id=btnUpload type="button"
                                        class="btn btn-primary" data-user-id="${sessionScope.signedInUserId}">업로드</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                        <!-- 유저 정보 -->
                    <input class="d-none" type="text" id="userId" name="userId" value="${user.userId}" />
                    
<!--                     유저 패스워드 변경 -->
                    <input class="d-none" type="password" id="password" name="password" value="${user.password}" />
                    
                    <div class="modal" tabindex="-1" id="passwordModal">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">패스워드 변경</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body text-center">
                                <form id="passwordForm">
                                    현재 비밀번호 입력
                                    <div>
                                        <label for="currentPassword"></label>
                                        <input type="password" id="currentPassword" required />
                                    </div>
                                    
                                    새 비밀번호 입력
                                    <div>
                                        <label for="newFirstPassword"></label>
                                        <input type="password" id="newFirstPassword" required />
                                    </div>
                                    
                                     새 비밀번호 확인
                                    <div>
                                        <label for="newSecondPassword"></label>
                                        <input type="password" id="newSecondPassword" required />
                                    </div>
                                    
                                    
                                     <div class="modal-footer">`
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                                        <button id=btnUpdatePassword type="submit" class="btn btn-primary">확인</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    </div>
                    <input class="d-none" type="text" id="imgId" name="imgId" value="${user.imgId}"/>
                    <input class="d-none" type="text" id="age" name="age" value="${user.age}" />
                    <div>
                        <label> 닉네임 </label>
                        <input type="text" id="nickname" name="nickname" value="${user.nickname}"/>
                    </div>
                    <!-- 사용자 닉네임 중복체크 -->
                    <div id="checkNicknameResult">
                    
                        <label> 이름 </label>
                        <input type="text" id="username" name="username" value="${user.username}" />
                    </div>
                    <div>
                        <select name="gender" id="gender">
                           <option value="1" ${user.gender == '1' ? 'selected' : ''}>남성</option>
                           <option value="2" ${user.gender == '2' ? 'selected' : ''}>여성</option>
                        </select>
                    </div>
                    <div>
                        <label> 휴대전화번호 </label>
                        <input type="text" id="phonenumber" name="phonenumber" value="${user.phonenumber}" />
                    </div>
                    <!-- 사용자 전화번호 중복체크 -->
                    <div id="checkPhoneNumberResult">
                    
                    </div>
                    
                    
                    <div>
                        <c:set var="seoulDistricts" value="
                            강남구, 강동구, 강북구, 강서구, 관악구, 광진구, 구로구, 금천구, 노원구, 도봉구, 동대문구, 동작구,
                            마포구, 서대문구, 서초구, 성동구, 성북구, 송파구,
                            양천구, 영등포구, 용산구, 은평구, 종로구, 중구, 중랑구
                        " />
                        <c:set var="cleanedDistricts" value="${fn:replace(seoulDistricts, ' ', '')}" />
                        <c:set var="districtList" value="${fn:split(cleanedDistricts, ',')}" />

                    <select name="residence" id="residence">
                        <option value="${user.residence}"
                            ${empty user.residence ? 'selected' : ''}>
                            ${not empty user.residence ? user.residence : '주소 선택'}
                        </option>

                        <c:forEach var="district"
                            items="${districtList}">
                            <option value="${district}"
                                ${district eq user.residence ? 'selected' : ''}>${district}</option>
                        </c:forEach>
                    </select>

                    <!-- 디버깅용: residence 값 확인 -->
                        <p>현재 선택된 주소: ${user.residence}</p>
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
                </form>
                <div>
                    <button class="btn" id="btnUpdate" data-user-id="${sessionScope.signedInUserId}">작성 완료</button>
                </div>
                
                <hr/>
                <div>
                    <button  id="changePasswordBtn" data-user-id="${sessionScope.signedInUserId}">비밀번호 변경</button>
                    <button id="btnDelete" data-user-id="${sessionScope.signedInUserId}">계정 탈퇴</button>
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