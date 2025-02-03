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
            <c:url value="/gpost/list" var="homePage" />
            <a href=${homePage }>리스트</a>
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
                                <label class="form-label">첨부파일</label><br/>
                                <c:choose>
                                    <c:when test="${empty gImages}">
                                        <p>파일이 없습니다.</p>
                                    </c:when>
                                    <c:otherwise>
                                        <ul class="list-group list-group-flush">
                                        <c:forEach var="images" items="${gImages}">
                                            <li class="list-group-item">
                                                <img alt="${images.originName}"  class="rounded"  
                                                    src="/running/gpost/uploads/${images.uniqName}" style="width:50px; height:50px;">
                                                <span>${images.originName }</span>
                                            </li>
                                        </c:forEach>
                                        </ul>
                                    </c:otherwise>
                                </c:choose>
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
		
        
        <!-- comment 작성 -->
      <c:if test="${not empty signedInUserId}">
         <!-- 로그인한 사람만 댓글작성 가능 -->
      ` <div class="container my-1 py-1">
            <div class="row d-flex justify-content-center">
               <div class="col-md-12 col-lg-10 col-xl-8">
                  <div class="card">
                     <div class="card-body">
                        <!-- 댓글 작성 폼 -->
                        <h5>${signedInUserNickname}</h5>
                        <div class="mb-3">
                           <textarea class="form-control" id="ctext" rows="3"
                              placeholder="댓글을 입력하세요..."></textarea>
                        </div>
                        <div class="form-check mb-1">
                           <input class="form-check-input" type="checkbox" id="secret"
                              name="secret" /> <label class="form-check-label" for="secret">비밀댓글</label>
                        </div>
                        
                        <button type="submit" class="btn btn-primary btn-sm"
                           id="btnRegisterComment">댓글 작성</button>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </c:if>


      <!-- comment section js-->
      <section class="gradient-custom" id="commentSection"></section>

      <script>
         //세션에 저장된 로그인 사용자 아이디를 자바스크립트 변수에 저장.
         //->comment.js 파일의 코드들에서 그 변수를 사용할 수 있도록 하기 위해서
         const signedInUserId = '${signedInUserId}';//문자열 포맷으로 변수를 저장.
         const signedInUserNickname = '${signedInUserNickname}';
         const postId = '${gPost.id}';
         const postUserId = '${gPost.userId}';
      </script>

      <!-- Axios Http Js-->
      <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

      <c:url value="/js/comment.js" var="commentJs" />
      <script src="${commentJs}"></script>
        
        
        </div>
		<!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
	</body>
</html>