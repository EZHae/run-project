<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
	<head>
		<meta charset="UTF-8">
				
		<!-- Bootstrap을 사용하기 위한 meta name="viewport" 설정. -->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
	    <title>모임 일정 수정</title>
	    
	    <!-- Bootstrap CSS 링크 -->
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" 
	          rel="stylesheet" 
	          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" 
	          crossorigin="anonymous">
	                
	    <!-- jQuery & jQuery UI   -->
	    <!-- (1) jQuery UI 컴포넌트에 필요한 스타일시트 -->
	    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
	    <!-- (2) jQuery의 핵심 라이브러리 -->
	    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	    <!-- (3) jQuery UI 라이브러리로 추가 UI 컴포넌트를 제공 -->
	    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
	    
	    <!-- jQuery Timepicker 플러그인 -->
	    <!-- (1) 시간 선택 플러그인용 자바스크립트 파일 -->
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-timepicker-addon/1.6.3/jquery-ui-timepicker-addon.min.js"></script>
	    <!-- (2) 시간 선택 플러그인용 스타일시트 -->
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-timepicker-addon/1.6.3/jquery-ui-timepicker-addon.min.css">
	
	    <script>
	        $(function() {
	            // 한국어 지역화 설정
	            $.timepicker.regional['ko'] = {
	                timeOnlyTitle: '시간 선택',
	                timeText: '시간',
	                hourText: '시',
	                minuteText: '분',
	                secondText: '초',
	                millisecText: '밀리초',
	                microsecText: '마이크로초',
	                timezoneText: '시간대',
	                currentText: '현재 시간',
	                closeText: '확인',
	                amNames: ['오전', 'AM', 'A'],
	                pmNames: ['오후', 'PM', 'P'],
	                isRTL: false
	            };
	            $.timepicker.setDefaults($.timepicker.regional['ko']);
	
	            // 날짜 선택 기능 활성화
	            $("#date").datepicker({
	                dateFormat: 'yy-mm-dd',
	                minDate: 0 // 오늘 이후 날짜만 선택 가능
	            });
	
	            // 시간 선택 기능 활성화
	            $("#time").timepicker({
	                timeFormat: 'tt h:mm',
	                interval: 30, // 30분 간격
	                minTime: '06:00am',
	                maxTime: '11:30pm',
	                defaultTime: '12:00pm',
	                startTime: '06:00am',
	                dynamic: false,
	                dropdown: true,
	                scrollbar: true
	            });
	        });
	    </script>
	</head>
	<body>
    <h2>모임 일정 수정</h2>
    <c:url value="/teampage/${teamId}/tcalendar/update" var="tCalendarUpdatedPage"/>
    <form action="${tCalendarUpdatedPage}" method="post">
        <input type="hidden" name="calendarId" value="${tCalendar.id}" />
        <table>
            <tr>
                <td><label for="title">제목:</label></td>
                <td><input type="text" id="title" name="title" value="${tCalendar.title}" readonly></td>
            </tr>
            <tr>
                <td><label for="date">날짜/시간:</label></td>
                <td><input type="text" id="date" name="date" autocomplete="off" value="${tCalendar.dateTime}" disabled></td>
            </tr>
            <tr>
                <td><label for="content">내용:</label></td>
                <td><textarea id="content" name="content" rows="5" cols="30" readonly>${tCalendar.content}</textarea></td>
            </tr>
            <tr>
            	<!-- 최대인원수 수정 가능 범위 : 게시글의 최대인원수 ~ 99 -->
                <td><label for="max_num">최대 인원수:</label></td>
                <td><input type="number" id="max_num" name="max_num" min="${tCalendar.maxNum}" max="99" placeholder="${tCalendar.maxNum}" required autofocus></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <button type="submit">작성완료</button>
                </td>
            </tr>
        </table>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" 
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" 
            crossorigin="anonymous"></script>
            
</body>
	
</html>