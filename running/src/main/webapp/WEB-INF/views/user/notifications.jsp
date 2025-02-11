<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<!-- Bootstrap CSS 링크. -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<style type="text/css">
.notifications {
	display: flex;
	flex-direction: column;
	gap: 10px; /* 알림 간격 */
}

.notification-card {
	padding: 15px;
	border-radius: 8px;
	background: #f8f9fa;
	box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
	transition: 0.3s;
}

.notification-card.unread {
	background: #ffeeba; /* 읽지 않은 알림 배경 */
}

.notification-type {
	font-weight: bold;
	font-size: 14px;
	color: #333;
}

.notification-content {
	font-size: 16px;
	margin-top: 5px;
}

.noti-link {
	text-decoration: none;
	color: #000;
	font-weight: bold;
}

.noti-link:hover {
	color: #007bff;
}
</style>
</head>
<body>
	<%@ include file="../fragments/header.jspf"%>
	<div class="container mt-3">
		<div class="notifications">
			<c:forEach items="${notiList}" var="noti">
				<div
					class="notification-card <c:if test="${noti.checked eq 0}">unread</c:if>">
					<div class="notification-header">
						<div class="notification-type">
							<button class="btn-close"
								onclick="deleteNotification('${noti.id}')"></button>
							<c:choose>
								<c:when test="${noti.type eq 1}">📢 전체게시판 새 댓글</c:when>
								<c:when test="${noti.type eq 2}">💬 전체게시판 새 답글</c:when>
								<c:when test="${noti.type eq 3}">👥 새 팀원 신청</c:when>
								<c:when test="${noti.type eq 4}">✅ 팀원 수락</c:when>
							</c:choose>
						</div>
						<!-- 삭제 버튼 (X 버튼) -->
					</div>
					<div class="notification-content">
						<c:choose>
							<c:when test="${noti.type eq 1}">댓글내용:</c:when>
							<c:when test="${noti.type eq 2}">답글내용:</c:when>
							<c:when test="${noti.type eq 3}">팀 이름/신청 인사말:</c:when>
							<c:when test="${noti.type eq 4}">해당 팀 신청이 수락되었습니다:</c:when>
						</c:choose>
						<c:url value="/api/notification/chekced/${noti.id}" var="checkedLink">
							<c:param name="target" value="${noti.link}"></c:param>
						</c:url>
						<a href="${checkedLink}" class="noti-link">${noti.content}</a>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>


	<!-- Bootstrap Javascript  -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<!-- Axios Http Js-->
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<script>
		const signedInUserId='${signedInUserId}';
	</script>
	<script>
	function deleteNotification(notificationId) {
	    // 삭제할 알림의 ID를 서버로 전송하는 요청
	    axios.delete(`../api/notification/`+notificationId)
	        .then(response => {
	            if (response.data == 1) {
	                //리다이렉트
	            	window.location.href = `../user/notifications?userid=${signedInUserId}`;
	            } else {
	                alert('알림 삭제 실패');
	            }
	        })
	        .catch(error => {
	            console.error('삭제 실패:', error);
	        });
	}

	</script>
</body>
</html>