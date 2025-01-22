<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
		<title>${gPost.title} : 수정</title>
		
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
                        <h3>${gPost.title}</h3>
                    </div>
                    <div class="card-body">
                        <form id="modifyForm">
                            <div class="d-none">
                                <label class="form-label" for="id">글 번호</label>
                                <input class="form-control" id="id" name="id" value="${gPost.id}" 
                                     type="text"/>
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="title">제목</label>
                                <input class="form-control" id="title" name="title" value="${gPost.title}" type="text" required/>
                            </div>
                            <div class="mt-2 d-none" >
                                <label class="form-label" for="nickname">작성자</label>
                                <input type="text" readonly class="form-control" id="nickname" name="nickname" value="${gPost.nickname}"  disabled>
                            </div>  
                            <div class="mt-2">
                                <label class="form-label" for="content">내용</label>
                                <textarea rows="5" class="form-control" id="content" name="content" >${gPost.content}</textarea>
                            </div>
                            <div class="mt-2 d-none">
                                <label class="form-label" for="createdTime">작성시간</label>
                                <input class="form-control" type="text" id="createdTime" name="createdTime" 
                                   value="${gPost.formattedCreatedTime}" readonly/>
                            </div>
                            <div class="mt-2 d-none">
                                <label class="form-label" for="modifiedTime">최종수정시간</label>
                                <input class="form-control" type="text" id="modifiedTime" name="modifiedTime" 
                                   value="${gPost.formattedModifiedTime}" readonly/>
                            </div>
                            <div class="mt-2">
                                <label class="form-label" for="formFileMultiple" >파일 업로드</label>
                                <input class="form-control" type="file" id="formFileMultiple" multiple>
                            </div>
                        </form>
                    </div>
<%--                     <c:if test="${signedInUser eq post.author}"> --%>
                        <div class="card-footer d-flex justify-content-center">
                            <button id="btnUpdate" class="me-2 btn btn-outline-success">업데이트</button>
                            <button id="btnDelete" class="btn btn-outline-danger">삭제</button>
                        </div>
<%--                     </c:if> --%>
                </div>
            </main>
        </div>
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
        
        <c:url var="gPostModifyJS" value="/js/gpost_modify.js" />
        <script src="${gPostModifyJS}"></script>
	</body>
</html>