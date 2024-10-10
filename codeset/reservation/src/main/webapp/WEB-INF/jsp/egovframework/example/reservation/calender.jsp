<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회의실 예약</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/css/bootstrap/css/bootstrap.min.css">
<script src="/js/jquery-3.5.1.min.js"></script>
<script src="/css/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.css">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.js"></script>
<script type="text/javascript" defer="defer">
document.addEventListener('DOMContentLoaded', function() {
    var reservations = [
        <c:forEach var="reservation" items="${list}" varStatus="status">
            {
                title: '${reservation.purpose}',
                start: '${reservation.start_time}',
                end: '${reservation.end_time}',
                id: '${reservation.reservation_id}' // 예약 ID를 이벤트 객체에 추가
            }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];


        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            timeZone: 'UTC',
            initialView: 'dayGridMonth',
            events: reservations,
            editable: true,
            dateClick: function(info) {
                hold(info.dateStr);
            },
        	eventClick: function(info) {
        		var detailsUrl = '<c:url value="/bookingView.do"/>' + '?reservation_id=' + info.event.id;
        		location.href = detailsUrl;
        	}
        });
        calendar.render();

        function hold(dateStr) {
            var bookingUrl = '<c:url value="/booking.do"/>' + '?date=' + dateStr;
            location.href = bookingUrl;
        }
    });
    
    function setUser(user_id) {
        if (user_id == "2420340029") {
            $("#password").val("1234") // 비밀번호 설정
            $("#email").val("kdw@kopo.com") // 이메일 설정
        } else if (user_id == "2420340033") {
            $("#password").val("1234")
            $("#email").val("ksh@kopo.com")
        } else if (user_id == "2420340034") {
            $("#password").val("1234")
            $("#email").val("kug@kopo.com")
        } else if (user_id == "2420340039") {
            $("#password").val("1234")
            $("#email").val("bgw@kopo.com")
        } else if (user_id == "2420340044") {
            $("#password").val("1234")
            $("#email").val("wyc@kopo.com")
        } else if (user_id == "2420340046") {
            $("#password").val("1234")
            $("#email").val("lje@kopo.com")
        } else if (user_id == "2420340052") {
            $("#password").val("1234")
            $("#email").val("csm@kopo.com")  
        } else if (user_id == "1"){
      	  $("#password").val("1234")
      	  $("#email").val("kopo@kopo.com")
        } else {
            $("#password").val("") // 선택을 초기화하면 비밀번호와 이메일을 비웁니다.
            $("#email").val("")
        }
    }
    function out(){
    	location.href ="<c:url value='/logout.do'/>";
    }
    
    
</script>
<style>
#calendarBox {
    width: 100%;
    padding: 0;
    margin: 0 auto;
}

#calendar {
    max-width: 1200px;
    margin: 0 auto;
}

.jumbotron-custom {
    background-color: #f5f5f5;
    padding: 30px 15px;
    margin-bottom: 30px;
}
</style>
</head>
<body>
<header>
    <div class="panel">
        <div class="panel-heading">
            <c:if test="${sessionScope.userId == null || sessionScope.userId == '' }"> 
                <form class="form-inline text-right" method="post" action="/login.do">                
                    <div class="form-group">
                        <label for="id">ID:</label>
                        <input type="text" class="form-control" id="user_id" name="user_id" onchange="setUser(this.value);">
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" class="form-control" id="password" name="password">
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control" id="email" name="email">
                    </div>
                    
                    <button type="submit" class="btn btn-default" onclick="return check();">로그인</button>
                </form>
            </c:if>
            <c:if test="${sessionScope.userId != null && sessionScope.userId != '' }">
                <div class="pull-right">
                    ${sessionScope.userName}님 환영합니다
                    <button type="button" class="btn btn-default" onclick="out();">로그아웃</button>
                </div>
            </c:if>
        </div>
        <div class="jumbotron text-center jumbotron-custom">
            <h2>스마트금융학과 회의실 예약 시스템</h2>
            <p>모두 자유롭게 예약해보세요!</p>
        </div>
        <ul class="nav nav-tabs">
            <li><a href="/">홈</a></li>
            <li><a href="/announcement.do">공지사항</a></li>
            <li class="active"><a href="/calender.do">회의실 예약</a></li>
        </ul>
    </div>
</header>
<div class="panel-body">
    <div id="calendar"></div>
</div>
<footer>
    <div class="panel-footer text-center">
        <p>&copy; 2024 스마트금융학과 회의실 예약 시스템</p>
    </div>
</footer>
</body>
</html>
