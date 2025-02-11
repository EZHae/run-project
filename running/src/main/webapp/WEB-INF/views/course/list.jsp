<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


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
        <%@ include file="../fragments/header.jspf"%>
		<div class="container-fluid">
            <c:set var="pageTitle" value="코스 목록" />
        </div>
        
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
            </div>
        </form>
        <!-- 새글 작성 버튼 추가 -->
        <div>
            <c:url var="courseCreatePage" value="/course/create" />
            <a class="btn btn-outline-primary" href="${courseCreatePage}">새글작성</a>
        </div>
        
        <c:forEach var="course" items="${courses}">
            <div>
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
            </div>
        </c:forEach>
        
        <!-- 페이징 처리 -->
        <div>
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <!-- 맨 처음 페이지 버튼 -->
                    <li class="page-item">
                        <c:choose>
                            <c:when test="${type == '/running/course/search'}">
                                <c:url var="firstPage" value="/course/search">
                                    <c:param name="offset" value="0"/>
                                    <c:param name="limit" value="${limit}"/>
                                    <c:if test="${not empty category}"><c:param name="category" value="${category}"/></c:if>
                                    <c:if test="${not empty order}"><c:param name="order" value="${order}"/></c:if>
                                    <c:if test="${not empty keyword}"><c:param name="keyword" value="${keyword}"/></c:if>
                                </c:url>
                            </c:when>
                            <c:otherwise>
                                <c:url var="firstPage" value="/course/list">
                                    <c:param name="offset" value="0"/>
                                    <c:param name="limit" value="${limit}"/>
                                </c:url>
                            </c:otherwise>
                        </c:choose>
                        <a class="page-link" href="${firstPage}" aria-label="First">
                            <span aria-hidden="true">&laquo;&laquo; First</span>
                        </a>
                    </li>
        
                    <!-- 이전 페이지 버튼 -->
                    <c:if test="${offset > 0}">
                        <li class="page-item">
                            <c:choose>
                                <c:when test="${type == '/running/course/search'}">
                                    <c:url var="prevPage" value="/course/search">
                                        <c:param name="offset" value="${offset - limit}"/>
                                        <c:param name="limit" value="${limit}"/>
                                        <c:if test="${not empty category}"><c:param name="category" value="${category}"/></c:if>
                                        <c:if test="${not empty order}"><c:param name="order" value="${order}"/></c:if>
                                        <c:if test="${not empty keyword}"><c:param name="keyword" value="${keyword}"/></c:if>
                                    </c:url>
                                </c:when>
                                <c:otherwise>
                                    <c:url var="prevPage" value="/course/list">
                                        <c:param name="offset" value="${offset - limit}"/>
                                        <c:param name="limit" value="${limit}"/>
                                    </c:url>
                                </c:otherwise>
                            </c:choose>
                            <a class="page-link" href="${prevPage}" aria-label="Previous">
                                <span aria-hidden="true">&laquo; Previous</span>
                            </a>
                        </li>
                    </c:if>
        
                    <!-- 페이지 번호 버튼 -->
                    <c:if test="${totalPages > 0}">
                        <c:forEach begin="0" end="${totalPages-1}" var="page">
                            <li class="page-item ${page * limit == offset ? 'active' : ''}">
                                <c:choose>
                                    <c:when test="${type == '/running/course/search'}">
                                        <c:url var="pageUrl" value="/course/search">
                                            <c:param name="offset" value="${page * limit}"/>
                                            <c:param name="limit" value="${limit}"/>
                                            <c:if test="${not empty category}"><c:param name="category" value="${category}"/></c:if>
                                            <c:if test="${not empty order}"><c:param name="order" value="${order}"/></c:if>
                                            <c:if test="${not empty keyword}"><c:param name="keyword" value="${keyword}"/></c:if>
                                        </c:url>
                                    </c:when>
                                    <c:otherwise>
                                        <c:url var="pageUrl" value="/course/list">
                                            <c:param name="offset" value="${page * limit}"/>
                                            <c:param name="limit" value="${limit}"/>
                                        </c:url>
                                    </c:otherwise>
                                </c:choose>
                                <a class="page-link" href="${pageUrl}">${page + 1}</a>
                            </li>
                        </c:forEach>
                    </c:if>
                    <!-- 더미 -->
        
                    <!-- 다음 페이지 버튼 -->
                    <c:if test="${offset + limit < totalPosts}">
                        <li class="page-item">
                            <c:choose>
                                <c:when test="${type == '/running/course/search'}">
                                    <c:url var="nextPage" value="/course/search">
                                        <c:param name="offset" value="${offset + limit}"/>
                                        <c:param name="limit" value="${limit}"/>
                                        <c:if test="${not empty category}"><c:param name="category" value="${category}"/></c:if>
                                        <c:if test="${not empty order}"><c:param name="order" value="${order}"/></c:if>
                                        <c:if test="${not empty keyword}"><c:param name="keyword" value="${keyword}"/></c:if>
                                    </c:url>
                                </c:when>
                                <c:otherwise>
                                    <c:url var="nextPage" value="/course/list">
                                        <c:param name="offset" value="${offset + limit}"/>
                                        <c:param name="limit" value="${limit}"/>
                                    </c:url>
                                </c:otherwise>
                            </c:choose>
                            <a class="page-link" href="${nextPage}" aria-label="Next">
                                <span aria-hidden="true">Next &raquo;</span>
                            </a>
                        </li>
                    </c:if>
        
                    <!-- 맨 마지막 페이지 버튼 -->
                    <li class="page-item">
                        <c:choose>
                            <c:when test="${type == '/running/course/search'}">
                                <c:url var="lastPage" value="/course/search">
                                    <c:param name="offset" value="${(totalPages - 1) * limit}"/>
                                    <c:param name="limit" value="${limit}"/>
                                    <c:if test="${not empty category}"><c:param name="category" value="${category}"/></c:if>
                                    <c:if test="${not empty order}"><c:param name="order" value="${order}"/></c:if>
                                    <c:if test="${not empty keyword}"><c:param name="keyword" value="${keyword}"/></c:if>
                                </c:url>
                            </c:when>
                            <c:otherwise>
                                <c:url var="lastPage" value="/course/list">
                                    <c:param name="offset" value="${(totalPages - 1) * limit}"/>
                                    <c:param name="limit" value="${limit}"/>
                                </c:url>
                            </c:otherwise>
                        </c:choose>
                        <a class="page-link" href="${lastPage}" aria-label="Last">
                            <span aria-hidden="true">Last &raquo;&raquo;</span>
                        </a>
                    </li>
                </ul>                  
            </nav>
        </div>
        
        <!-- Bootstrap JS 링크 -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
                crossorigin="anonymous">
        </script>
    </body>
</html>