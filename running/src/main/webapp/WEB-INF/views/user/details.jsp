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
       
       
        <style>
       /* 전체 페이지 스타일 */
        html, body {
            height: 100%;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        
        /* 프로필 카드 스타일 */
        .profile-container {
            display: flex;
            align-items: center;
            gap: 20px;
        }
        
        .profile-image {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #28a745;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        /* 프로필 정보 섹션 */
        .profile-details {
            flex-grow: 1;
        }
        
        .form-control[readonly] {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            cursor: default;
        }
        
        /* 팀 관리 섹션 */
        .team-container {
            margin-top: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        
        .list-group-item {
            border: none;
            background: #fff;
            border-radius: 8px;
            margin-bottom: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }
        
        .list-group-item a {
            color: #28a745;
            font-weight: 600;
        }
        
        .btnDeleteTeam, .btnLeaveTeam {
            font-size: 14px;
            padding: 5px 10px;
            border-radius: 5px;
        }
        
        .btn-danger {
            background-color: #dc3545;
        }
        
        .btn-warning {
            background-color: #ffc107;
            color: #333;
        }
        
        /* 프로필 수정 버튼 */
        .btn-success {
            background-color: #28a745;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 8px;
        }
        
        .btn-success:hover {
            background-color: #218838;
        }
        /* 읽기 전용 input 스타일 조정 */
        .form-control[readonly] {
            background-color: white !important; /* 밝은 회색 유지 */
            color: #6c757d !important; /* 부트스트랩 기본 글자 색상 유지 */
            box-shadow: none !important; /* 클릭 시 발생하는 효과 제거 */
            font-weight: normal !important; /* 글씨가 두꺼워지지 않도록 설정 */
        }
        
        </style>
      
    </head>
    <body>
        <%@ include file="../fragments/header.jspf"%>
        <div class="container-fluid">
            <c:set var="pageTitle" value="유저 상세보기" />
        </div>
        
        <div class="container my-3">
            <div class="row d-flex justify-content-center">
                <div class="col-md-12 col-lg-10 col-xl-8">
                    <div class="card p-4 shadow-sm">
                        <!-- 프로필 섹션 -->
                        <div class="profile-container">
                            <img src="<c:url value='/image/view/user/${signedInUserId}' />" 
                                 alt="프로필 이미지" 
                                 class="profile-image rounded-circle border border-success shadow-sm" />
                            <div class="profile-details w-100">
                                <div class="row g-3">
                                   <div class="col-md-6">
                                        <label class="form-label fw-bold">닉네임</label>
                                        <input type="text" class="form-control border-success shadow-sm" value="${user.nickname}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">이름</label>
                                        <input type="text" class="form-control border-success shadow-sm" value="${user.username}" readonly>
                                    </div>
                                    <div class="col-md-6"> 
                                        <label class="form-label fw-bold">성별</label>
                                        <input type="text" class="form-control border-success shadow-sm" value="${user.gender == 1 ? '남자' : '여자'}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">나이</label>
                                        <input type="text" class="form-control border-success shadow-sm" value="${user.age}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">휴대전화번호</label>
                                        <input type="text" class="form-control border-success shadow-sm" value="${user.phonenumber}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">주소</label>
                                        <input type="text" class="form-control border-success shadow-sm" value="${user.residence}" readonly>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label fw-bold">이메일</label>
                                        <input type="text" class="form-control border-success shadow-sm" value="${user.email}" readonly>
                                    </div>
                                </div>  
                            </div>
                        </div>
        
                        <!-- 팀 관리 섹션 -->
                        <div class="team-container mt-4">
                            <label class="fw-bold">팀 관리</label>
                            <ul class="list-group mt-1">
                                <c:choose>
                                    <c:when test="${not empty teams}">
                                        <c:forEach items="${teams}" var="t">
                                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                                <a href="${pageContext.request.contextPath}/team/details?teamid=${t.teamId}" class="text-decoration-none">
                                                    ${t.teamName}
                                                </a>
                                                <div>
                                                    <c:if test="${leaderCheck[t.teamId] == 1}">
                                                        <span class="me-2">👑</span>
                                                        <button class="btn btn-danger btn-sm btnDeleteTeam" data-team-id="${t.teamId}">팀 삭제</button>
                                                    </c:if>
                                                    <c:if test="${leaderCheck[t.teamId] == 0}">
                                                        <span class="me-2">👟</span>
                                                        <button class="btn btn-warning btn-sm btnLeaveTeam" data-team-id="${t.teamId}" style="color: white;">팀 탈퇴</button>
                                                    </c:if>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="list-group-item text-center">소속된 팀이 없습니다.</li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
        
                        <!-- 프로필 수정 버튼 -->
                        <div class="d-flex justify-content-center mt-3">
                            <c:url var="userModifyPage" value="/user/modify">
                                <c:param name="userId" value="${user.userId}" />
                            </c:url>
                            <a href="${userModifyPage}" class="btn fw-bold btn-lg w-100" 
                               style="background-color: #28a745; border-color: #008C2C; color: white;">
                                프로필 수정
                            </a>
                        </div>
                    </div>
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
        
        <c:url var="userDetailsJS" value="/js/user_details.js"/>
        <script src="${userDetailsJS}"></script>
    </body>
</html>