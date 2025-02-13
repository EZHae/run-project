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
        
    </head>
    <body>
    	<%@ include file="./fragments/header.jspf"%>
    	<div class="container-fluid">
    		<c:set var="pageTitle" value="홈페이지" />
    	</div>
    
    	<h1>Running Home</h1>
    	
    	<%@ include file="./fragments/footer.jspf"%>
    
    	<!-- Bootstrap JS 링크 -->
    	<script
    		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    		crossorigin="anonymous">
    		
    	</script>
    </body>
</html>