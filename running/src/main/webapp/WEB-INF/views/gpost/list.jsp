<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
		<title>자유게시판 : Running</title>
		
		<!-- Bootstrap CSS 링크 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" 
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">
	</head>
	<body>
        <div class="container-fluid">
            <c:url value="/" var="homePage" />
            <a href=${homePage }>리스트</a>
            <main>
                <div class="card mt-3">
                    <div class="card-body">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>제목</th>
                                    <th>작성자</th>
                                    <th>수정시간</th>
                                    <th>조회수</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${gPosts}" var="p">
                                    <tr>
                                        <td>${p.id}</td>
                                        <td>
                                        <c:url var="gPostDetailsPage" value="/gpost/details">
                                            <c:param name="id" value="${p.id}" />
                                        </c:url>
                                        <a href="${gPostDetailsPage}">${p.title}</a>
                                        </td>
                                        <td>${p.nickname}</td>
                                        <td>${p.formattedModifiedTime}</td>
                                        <td>${p.viewCount}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer d-flex justify-content-end">
                        <c:url var="gPostCreatePage" value="/gpost/create"/>
                        <a href="${gPostCreatePage}" class="me-2 btn btn-outline-secondary">글쓰기</a>
                    </div>
                </div>
            </main>
        </div>
		
		
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
	</body>
</html>