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
		
		<h1>Running CourseDetails</h1>
		<span>COURSE.id(코스 아이디) = <span>${course.id}</span></span> <br>
		<span>COURSE.title(코스 제목) = <span>${course.title}</span></span> <br>	
		<span>COURSE.user_id(코스 작성자 아이디) = <span>${course.userId}</span></span> <br>
		<span>COURSE.nickname(코스 작성자 닉네임) = <span>${course.nickname}</span></span> <br>
		<span>COURSE.course_name(코스이름) = <span>${course.courseName}</span></span> <br>
		<span>COURSE.duration_time(소요 시간) = <span>${course.durationTime}</span></span> <br>
		<span>COURSE.content(코스 내용) = <span>${course.content}</span></span> <br>
		<span>COURSE.category(코스 분류 0: 추천, 1: 리뷰) = <span>${course.category}</span></span> <br>
		<span>COURSE.view_count(조회수) = <span>${course.viewCount}</span></span> <br>
		<span>COURSE.like_count(좋아요 수) = <span>${course.likeCount}</span></span> <br>
		<span>COURSE.created_time(작성 시간) = <span>${course.createdTime}</span></span> <br>
		<span>COURSE.modified_time(최종 수정 시간) = <span>${course.modifiedTime}</span></span> <br>
		
		<!-- TODO
			 js로 처리하거나 restAPI로 하기 -->
		<!-- 추가 -->
		<c:if test="${!signedInUser.equals(userId) && !likeUserIds.contains(signedInUser)}">
			<c:url var="courseLikePage" value="/course/like" />
		    <form action="${courseLikePage}" method="get">
		        <input type="hidden" name="id" value="${course.id}" />
		        <button type="submit">좋아요</button>
		    </form>
		</c:if> 
		<c:if test="${signedInUser eq course.userId}">
			<c:url var="courseUpdatePage" value="/course/update">
				<c:param name="id" value="${course.id}" />
			</c:url>
			<a href="${courseUpdatePage}">수정</a>
			
			<c:url var="courseDeletePage" value="/course/delete">
				<c:param name="id" value="${course.id}" />
			</c:url>
			<a href="${courseDeletePage}">삭제</a>
		</c:if>
		
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
	</body>
</html>