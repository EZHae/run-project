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
        
		<title>회원가입 : Running</title>
		
		<!-- Bootstrap CSS 링크 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" 
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">
              
              
        <style>
        /* 전체 페이지 스타일 */
        html, body {
            height: 100%;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        
        /* 회원가입 컨테이너 (헤더 높이 고려 & 중앙 정렬) */
        .signup-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 80px); /* 헤더 높이 고려한 중앙 정렬 */
            padding-top: 10px; /* 헤더와 카드 간격 유지 */
        }
        
        /* 회원가입 카드 스타일 */
        .signup-card {
            max-width: 500px;
            width: 100%;
            padding: 2rem;
            border-radius: 10px;
            border: 1px solid #008C2C !important;
            box-shadow: 0 0 10px rgba(0, 140, 44, 0.2) !important;
            background: white;
        }
        
        /* 입력 필드 스타일 */
        .form-control, .form-select {
            border: 1px solid #008C2C !important;
            box-shadow: 0 0 5px rgba(0, 140, 44, 0.3);
            padding: 10px;
            font-size: 16px;
        }
        
        /* 버튼 스타일 */
        .btn-signup {
            background-color: #008C2C;
            border-color: #005A1E;
            color: white;
            font-weight: bold;
            width: 100%;
            padding: 12px;
            font-size: 18px;
        }
        
        .btn-signup:hover {
            background-color: #006A24;
        }
        
        /* 프로필 이미지 선택 스타일 */
        .selectable-image {
            width: 80px !important; /* 기존 100px에서 80px로 줄임 */
            height: 80px !important;
            border: 2px solid black;
            border-radius: 50%;
            cursor: pointer;
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }
        
        /* 선택된 이미지 강조 효과 */
        .image-option input:checked + img {
            border: 3px solid #008C2C !important;
            box-shadow: 0 0 8px rgba(0, 140, 44, 0.5) !important;
        }
        
        /* 이미지 호버 효과 */
        .image-option:hover img {
            transform: scale(1.05);
            box-shadow: 0 0 8px rgba(0, 140, 44, 0.3);
        }
        
        /* 이미지 선택 안내 텍스트 */
        .image-selection-text {
            font-size: 12px;  /* 글씨 크기 작게 */
            color: #6c757d;   /* 연회색 */
            display: block;   /* 한 줄 차지하도록 설정 */
            margin-left: 5px; /* 이미지와 살짝 간격 조정 */
            margin-top: 4px;  /* 위쪽 여백 조정 */
        }
        
        /* 입력 필드 오류 강조 */
        .is-invalid {
            border: 2px solid #dc3545 !important;
            box-shadow: 0 0 5px rgba(220, 53, 69, 0.5);
        }
        
        /* 중복 체크 메시지 */
        .check-result {
            font-size: 14px;
            margin-top: 4px;
            margin-left: 4px;
            color: red;
        }
        
        /* 드롭다운 옵션 개수를 5개로 제한 */
        #residence {
            max-height: 160px;
            overflow-y: auto;
        }
        
    </style>      
        
	</head>
	<body>
        <%@ include file="../fragments/header.jspf"%>
		<div class="container-fluid">
            <c:set var="pageTitle" value="유저 회원가입" />
        </div>
        
        <div class="container signup-container">
            <div class="card signup-card">
                <h3 class="text-center fw-bold text-success">회원가입</h3>
                <p class="mt-2"></p>
                <form method="post">
                    <!-- 사용자 아이디 -->
                    <div class="mb-3">
                        <input type="text" id="userId" name="userId" class="form-control"
                               placeholder="사용자 아이디" required autofocus/>
                        <div id="checkUserIdResult" class="check-result"></div>
                    </div>
                    
                    <!-- 비밀번호 -->
                    <div class="mb-3">
                        <input type="password" id="password" name="password" class="form-control"
                               placeholder="비밀번호" required />
                        <div id="checkPasswordResult" class="check-result"></div>
                    </div>
                    
                    <!-- 닉네임 -->
                    <div class="mb-3">
                        <input type="text" id="nickname" name="nickname" class="form-control"
                               placeholder="닉네임" required />
                        <div id="checkNicknameResult" class="check-result"></div>
                    </div>
                    
                    <!-- 이름 -->
                    <div class="mb-3">
                        <input type="text" id="username" name="username" class="form-control"
                               placeholder="사용자 이름" required />
                    </div>

                    <!-- 성별 -->
                    <div class="mb-3">
                        <select name="gender" id="gender" class="form-select">
                            <option value="1">남성</option>
                            <option value="2">여성</option>
                        </select>
                    </div>

                    <!-- 나이 -->
                    <div class="mb-3">
                        <input type="text" id="age" name="age" class="form-control"
                               placeholder="나이" required />
                        <div id="checkAgeResult" class="check-result"></div>
                    </div>

                    <!-- 휴대전화번호 -->
                    <div class="mb-3">  
                        <input type="text" id="phonenumber" name="phonenumber" class="form-control"
                               placeholder="휴대전화번호" required />
                        <div id="checkPhoneNumberResult" class="check-result"></div>
                    </div>

                    <!-- 거주지 선택 -->
                    <div class="mb-3">
                     <!-- 거주지 선택 -->
                    <div class="col-md-12">
                        <c:set var="seoulDistricts" value="
                            강남구, 강동구, 강북구, 강서구, 관악구, 광진구, 구로구, 금천구, 노원구, 도봉구, 동대문구, 동작구,
                            마포구, 서대문구, 서초구, 성동구, 성북구, 송파구,
                            양천구, 영등포구, 용산구, 은평구, 종로구, 중구, 중랑구
                        " />
                        <c:set var="cleanedDistricts" value="${fn:replace(seoulDistricts, ' ', '')}" />
                        <c:set var="districtList" value="${fn:split(cleanedDistricts, ',')}" />
                        <select name="residence" id="residence" class="form-select border-success shadow-sm">
                            <option value="${user.residence}" ${empty user.residence ? 'selected' : ''}>
                                ${not empty user.residence ? user.residence : '주소 선택'}
                            </option>
                            <c:forEach var="district" items="${districtList}">
                                <option value="${district}" ${district eq user.residence ? 'selected' : ''}>
                                    ${district}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    </div>

                    <!-- 이메일 -->
                    <div class="mb-3">
                        <input type="text" id="email" name="email" class="form-control"
                               placeholder="이메일" required />
                        <div id="checkEmailResult" class="check-result"></div>
                    </div>

                    <!-- 이미지 선택 -->
                    <div class="d-flex flex-wrap justify-content-center gap-2 mt-3">
                        <c:forEach var="index" begin="1" end="5">
                            <label class="image-option position-relative">
                                <input type="radio" name="imgId" value="${index}" class="d-none" ${index == 1 ? 'checked' : ''}>
                                <img src="../images/profile0${index}.jpeg" alt="기본 이미지 ${index}" class="selectable-image">
                            </label>
                        </c:forEach>
                        <span  class="image-selection-text">프로필 이미지를 선택하세요</span>
                    </div>

                    <!-- 작성 완료 버튼 -->
                    <div class="mt-3">
                        <button class="btn btn-signup btn-lg w-100 disabled" id="btnSignUp">작성 완료</button>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- CSS Script -->
		 <script>
        document.addEventListener("DOMContentLoaded", function () {
            const selectElement = document.getElementById("residence");

            selectElement.addEventListener("focus", function () {
                this.setAttribute("size", "5"); // 드롭다운 열 때 5개까지만 보이도록 설정
            });

            selectElement.addEventListener("change", function () {
                this.removeAttribute("size"); // 선택하면 드롭다운 닫힘
                this.blur(); // 즉시 포커스 해제하여 반응 빠르게
            });

            selectElement.addEventListener("blur", function () {
                this.removeAttribute("size"); // 포커스 벗어나면 원래 크기로 복귀
            });
        });
        </script>
        
        
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
        
        <!-- Axios JS -->
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
        
        <!-- members.js -->
        <c:url var="userSignUpJS" value="/js/user_signup.js"/>
        <script src="${userSignUpJS}"></script>
	</body>
</html>