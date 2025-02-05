<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>모임 일정 생성</title>
    <!-- jQuery 및 jQuery UI -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
    <!-- jQuery Timepicker 플러그인 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-ui-timepicker-addon/1.6.3/jquery-ui-timepicker-addon.min.js"></script>
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
    <h2>모임 일정 생성</h2>
    <c:url value="/teampage/${teamId}/tcalendar/create" var="tCalendarCreatePage"/>
    <form action="${tCalendarCreatePage}" method="post">
        <table>
            <tr>
                <td><label for="title">제목:</label></td>
                <td><input type="text" id="title" name="title" required></td>
            </tr>
            <tr>
                <td><label for="date">날짜 선택:</label></td>
                <td><input type="text" id="date" name="date" autocomplete="off" required></td>
            </tr>
            <tr>
                <td><label for="time">시간 선택:</label></td>
                <td><input type="text" id="time" name="time" autocomplete="off" required></td>
            </tr>
            <tr>
                <td><label for="content">내용:</label></td>
                <td><textarea id="content" name="content" rows="5" cols="30" required></textarea></td>
            </tr>
            <tr>
                <td><label for="max_num">최대 인원수:</label></td>
                <td>
                    <select id="max_num" name="max_num" required>
                        <option value="">선택하세요</option>
                        <c:forEach var="i" begin="2" end="99">
                            <option value="${i}">${i}명</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">
                    <button type="submit">작성완료</button>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>

