<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<<<<<<< HEAD
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

        /* 메인 배너 스타일 */
        .banner-container {
            width: 100%;
            max-width: 1600px;
            height: 800px;
            margin: 0 auto;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #ddd;
        }

        .banner-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
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
            padding: 20px;
            text-align: center;
            transition: transform 0.3s;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .card-title {
            font-size: 24px;
            font-weight: bold;
            color: #008C2C;
            margin-bottom: 10px;
        }

        .card-text {
            font-size: 16px;
            color: #555;
        }
    </style>
    </head>
    <body>
    	<%@ include file="./fragments/header.jspf"%>
    	<div class="container-fluid">
    		<c:set var="pageTitle" value="홈페이지" />
    	</div>
    
    	<!-- 메인 배너 -->
        <div class="banner-container mb-3">
<!--             <img alt=""src="./images/run_girl.jpg"> -->
            <img src="./images/main_banner1.jpg" alt="메인 배너">
        </div>
        
        
        <div style="text-align: center; 
            font-size: 1.5rem; 
            font-weight: bold; 
            color: #333; 
            margin: 30px 0; 
            padding: 20px;">
    <span style="color: #008C2C;">러너즈</span>는 러닝메이트를 찾고, 
    다양한 <span style="color: #008C2C;">달리기 모임</span>에 참여할 수 있게 도와주는 <br> 
    <span style="background-color: #008C2C; color: white; padding: 5px 10px; border-radius: 5px;">혁신적인 서비스</span>입니다.
    <br><br>
    혼자 달리는 것이 지겹거나, <br>더 큰 목표를 달성하고 싶다면, <br>
    이제 <span style="color: #008C2C; font-size: 1.8rem;">우리와 함께하세요!</span>
</div>
    
        <hr class="mt-5"/>
        <!-- 카드 3개 배치 -->
        <div class="card-container">
            <div class="card">
                <div class="card-title">🏃‍♂️ 러닝팀 생성</div>
                <div class="card-text">같이 뛸 팀을 생성하세요.</div>
            </div>
            <div class="card">
                <div class="card-title">📅 팀 목록</div>
                <div class="card-text">러닝 스케줄을 정리해 보세요.</div>
            </div>
            <div class="card">
                <div class="card-title">🔥 일반 게시판</div>
                <div class="card-text">다양한 러닝 이벤트에 도전하세요.</div>
            </div>
        </div>
        
        <div class="card-container">
            <div class="card">
                <div class="card-title">🏃‍♂️ 최근 코스</div>
                <div class="card-text">같이 뛸 팀을 찾아보세요.</div>
            </div>
            <div class="card">
                <div class="card-title">📅 최근 모집 팀</div>
                <div class="card-text">러닝 스케줄을 정리해 보세요.</div>
            </div>
            <div class="card">
                <div class="card-title">🔥 최근 일반글</div>
                <div class="card-text">다양한 러닝 이벤트에 도전하세요.</div>
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