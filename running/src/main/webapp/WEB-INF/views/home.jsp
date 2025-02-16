<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        
        <!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
        <title>Running</title>
        
        <!-- 지해가 작성 -->
        <!-- Bootstrap CSS 링크 -->
        <link
        	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        	rel="stylesheet"
        	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
        	crossorigin="anonymous">
        
        <style>
        /* 전체 레이아웃 스타일 */
        body {
        
        }
        /* 전체 배너 영역 (브라우저 전체 너비 사용) */
        .banner-wrapper {
            width: 100%;
            display: flex;
            justify-content: center; /* 중앙 정렬 */
            background-color: #f8f8f8; /* 여백 배경색 */
            padding: 60px 0; /* 위아래 여백 */
        }
        
        /* 배너 컨테이너 (좌우 여백 추가) */
        .banner-container {
            width: 100%;
            max-width: 1700px; /* 최대 너비를 줄여서 여백 확보 */
            height: 800px; /* 고정 높이 */
            display: flex;
            justify-content: center; /* 내부 요소 중앙 정렬 */
            align-items: center;
            overflow: hidden;
            margin: 0 auto; /* 좌우 여백 추가 */
        }
        
        /* 메인 이미지 */
        .banner-image {
            width: 100%;
            height: 100%;
            object-fit: cover; /* 컨테이너에 맞게 채우기 */
        }
        
        /* 카드 컨테이너 */
        .card-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            padding: 50px 0;
        }

        /* 개별 카드 스타일 */
        .card {
            width: 30%;
            height: 300px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;    
            text-align: center;
            transition: transform 0.3s;
            overflow: hidden;   
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .card-title {
            font-size: 24px;
            font-weight: bold;
            color: #008C2C;
        }

        .card-text {
            font-size: 16px;
            color: #555;
        }
        
        .card-section {
            background-color : #F7F7F7;
        }
        
        /* 테이블 헤더 스타일 */
        .table{
            margin: 0px;
        }

        .table thead th {
            font-weight: bold;
            text-align: center;
            border-top: 2px solid #008C2C; /* 헤더 위쪽 테두리 추가 */
        }
        
        /* 테이블 본문 셀 스타일 */
        .table tbody td {
            border-bottom: 1px solid #ddd;
        }
        
        /* 마지막 행의 테두리 제거 */
        .table tbody tr:last-child td {
            border-bottom: none;
        }
        
        /* 행 호버 효과 */
        .table tbody tr:hover {
            background-color: #f2f2f2;
        }
        
        /* 게시글이 없을 때의 스타일 */
        .text-muted {
            color: #888;
            font-size: 14px;
            text-align: center;
        }
        a {
            text-decoration: none;
        }
        
        .table td {
            white-space: nowrap; /* 줄바꿈 방지 */
            overflow: hidden; /* 넘친 내용 숨김 */
            text-overflow: ellipsis; /* 말줄임 (...) 적용 */
            max-width: 150px; /* 최대 너비 제한 (원하는 크기로 조정) */
        }
        
        /* 카드 높이를 늘릴 요소만 선택 */
        .card-container:nth-of-type(2) .card {
            min-height: 340px;
            max-height: 400px;
        }
        
    </style>
    </head>
    <body>
    	<%@ include file="./fragments/header.jspf"%>
    	<div class="container-fluid">
    		<c:set var="pageTitle" value="홈페이지" />
    	</div>
    
    
        
<!--     	메인 배너 -->
        <div class="banner-container mb-3">
            <img src="./images/main_banner3.jpg" alt="메인 배너">
<!--             <img src="./images/main_banner2.jpg" alt="메인 배너"> -->
        </div>
        
        
        <div style="text-align: center; font-size: 1.5rem; 
            font-weight: bold; color: #333; margin: 30px 0; padding: 20px;">
            <span style="color: #008C2C;">러너즈</span>는 러닝메이트를 찾고, 
            다양한 <span style="color: #008C2C;">달리기 모임</span>에 참여할 수 있게 도와주는 <br> 
            <span style="background-color: #008C2C; color: white; padding: 5px 10px; border-radius: 5px;">혁신적인 서비스</span>입니다.
            <br><br>
            혼자 달리는 것이 지겹거나, <br>더 큰 목표를 달성하고 싶다면, <br>
            이제 <span style="color: #008C2C; font-size: 1.8rem;">우리와 함께하세요!</span>
        </div>
    
        <!-- 카드 3개 배치 -->
        <div class="card-section">
            <div class="card-container">
                <div class="card">
                    <c:url value="/gpost/list" var="gposListPage" />
                    <div class="card-title">
                    🔥<a href="${gposListPage}">일반 게시판</a>
                    </div>
                    <div class="card-text">다양한 러닝 정보를 나누고 소통하는 공간입니다.</div>
                </div>
                <div class="card">
                    <c:url value="/team/create" var="teamCreatePage" />
                    <div class="card-title">
                    🏃<a href="${teamCreatePage}">러닝팀 생성</a> 
                    </div>
                    <div class="card-text">함께 달릴 팀을 만들고 모집하세요.</div>
                </div>
                <div class="card">
                    <c:url value="/team/list" var="teamListPage" />
                    <div class="card-title">
                    📅 <a href="${teamListPage}">팀 목록</a>
                    </div>
                    <div class="card-text">원하는 러닝팀을 찾아 가입하세요.</div>
                </div>
            </div>
    
            
            <div class="card-container">
                <div class="card">
                        <div class="card-title">최근 게시글</div>
                        <div class="card-text"></div>
                            <table class="table">
                                    <thead >
                                        <tr>
                                            <th>제목</th>
                                            <th>작성자</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${gposts}" var="p">
                                            <tr>
                                                <td><c:url var="GPostDetailsPage" value="/gpost/details">
                                                        <c:param name="id" value="${p.id}" />
                                                    </c:url> <a href="${GPostDetailsPage}" class="text-success">${p.title}</a></td>
                                                <td>${p.nickname}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>    
                    </div>
                    <div class="card">
                        <div class="card-title">🏃‍♂️ 최근 코스</div>
                            <div class="card-text"></div>
                                <table class="table">
                                    <thead >
                                        <tr>
                                            <th>제목</th>
                                            <th>작성자</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${courses}" var="courses">
                                            <tr>
                                                <td><c:url var="courseDetailsPage" value="/course/details">
                                                        <c:param name="id" value="${courses.id}" />
                                                    </c:url> <a href="${courseDetailsPage}" class="text-success">${courses.title}</a></td>
                                                <td>${courses.nickname}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                    </div>
                    <div class="card">
                        <div class="card-title">🤝 최근 모집 팀</div>
                        <div class="card-text"></div>
                            <table class="table">
                                <thead >
                                    <tr>
                                        <th>팀 이름</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${teams}" var="t">
                                        <tr>
                                            <td><c:url var="teamDetailsPage" value="/team/details">
                                                    <c:param name="teamid" value="${t.teamId}" />
                                                </c:url> <a href="${teamDetailsPage}" class="text-success">${t.teamName}</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                    </div>
                
            </div>
        </div>
        <hr/>
    	
        
    	<%@ include file="./fragments/footer.jspf"%>
    
    	<!-- Bootstrap JS 링크 -->
    	<script
    		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    		crossorigin="anonymous">
    		
    	</script>
    </body>
</html>