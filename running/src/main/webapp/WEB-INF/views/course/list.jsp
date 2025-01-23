<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
		
		<title>Running</title>
		
		<!-- Bootstrap CSS 링크 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
                rel="stylesheet" 
                integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
                crossorigin="anonymous">
	</head>
	<body>
		<c:url var="homePage" value="/" />
		<a href="${homePage}">홈으로</a>
		
		<h1>Running CourseList</h1>

		<c:url var="courseSearchPage" value="/course/search" />
		<form action="${courseSearchPage}" method="get">
			<div>
				<div>
					<select name="category">
						<option value="0">추천만</option>
						<option value="1">리뷰만</option>
					</select>
					<select name="order">
						<option value="v">조회수 순</option>
						<option value="l">좋아요 순</option>
					</select>
				</div>
				<div>
					<input type="text" name="keyword" placeholder="코스 이름 검색, 공백 가능">
				</div>
				<div>
					<input class="btn btn-secondary" type="submit" value="검색">
				</div>
				<!-- 새글 작성 버튼 추가 -->
				<div>
					<c:url var="courseCreatePage" value="/course/create">
						<c:param name="id" value="${course.id}" />
					</c:url>
					<a href="${courseCreatePage}">새글작성</a>
				</div>
			</div>
		</form>

		<c:forEach var="course" items="${courses}">
			<c:url var="courseDetailsPage" value="/course/details">
				<c:param name="id" value="${course.id}" />
			</c:url>
			<a href="${courseDetailsPage}">
				<span>COURSE.title(코스 제목) = <span>${course.title}</span></span> <br>
			</a>
			<span>COURSE.nickname(코스 작성자 닉네임) = <span>${course.nickname}</span></span> <br>
			<span>COURSE.course_name(코스이름) = <span>${course.courseName}</span></span> <br>
			<span>COURSE.duration_time(소요 시간) = <span>${course.durationTime}</span></span> <br>
			<span>COURSE.category(코스 분류 0: 추천, 1: 리뷰) = <span>${course.category}</span></span> <br>
			<span>COURSE.view_count(조회수) = <span>${course.viewCount}</span></span> <br>
			<span>COURSE.like_count(좋아요 수) = <span>${course.likeCount}</span></span> <br>
			<span>COURSE.created_time(작성 시간) = <span>${course.createdTime}</span></span> <br>
			<hr>
		</c:forEach>
		
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
	</body>
</html>