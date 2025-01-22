<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
		<title>${gPost.title} : Running</title>
		
		<!-- Bootstrap CSS 링크 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
              rel="stylesheet" 
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
              crossorigin="anonymous">
	</head>
	<body>
        <div class="container-fluid">
            <main>
                <div class="card mt-2">
                    <div class="card-header">
                        <h3>${gPost.title }</h3>
                    </div>
                    <div class="card-body">
                        <form>
                            <div>
                                <label class="form-label" for="id">글 번호</label>
                                <input class="form-control" id="id" name="id" value="${gPost.id}" 
                                     type="text"  readonly/>
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="title">제목</label>
                                <input class="form-control" id="title" name="title" value="${gPost.title}" type="text" readonly/>
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="nickname">작성자</label>
                                <input type="text" readonly class="form-control" id="nickname" name="nickname" value="${gPost.nickname}" >
                            </div>  
                            <div class="mt-2">
                                <label class="form-label" for="content">내용</label>
                                <textarea rows="5" class="form-control" id="content" name="content" readonly>${gPost.content}</textarea>
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="createdTime">작성시간</label>
                                <input class="form-control" type="text" id="createdTime" name="createdTime" 
                                   value="${gPost.formattedCreatedTime}" readonly/>
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="modifiedTime">최종수정시간</label>
                                <input class="form-control" type="text" id="modifiedTime" name="modifiedTime" 
                                   value="${gPost.formattedModifiedTime}" readonly/>
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="formFileMultiple" >파일 업로드</label>
                                <input class="form-control" type="file" id="formFileMultiple" multiple disabled>
                            </div>
                        </form>
                    </div>
<%--                     <c:if test=""> --%>
                    <div class="card-footer">
                        <div class="d-flex justify-content-center">
                            <c:url var="gPostModifyPage" value="/gpost/modify">
                                <c:param name="id" value="${gPost.id}"/>
                            </c:url>
                            <a class="btn btn-outline-success"
                                href="${gPostModifyPage}">수정하기</a>
                        </div>
                    </div>
<%--                     </c:if> --%>
                </div>
            </main>
		
        
        <%-- TODO: 댓글 --%>
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        </div>
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
	</body>
</html>