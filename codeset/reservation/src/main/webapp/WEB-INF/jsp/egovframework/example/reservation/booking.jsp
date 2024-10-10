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
<script type="text/javascript" defer="defer">
    function booking() {
        if ($("#user_id").val() == '') {
            alert("로그인을 해주세요");
            $("#user_id").focus();
            return;
        }
        if ($("#purpose").val() == '') {
            alert("회의명을 입력하세요");
            $("#purpose").focus();
            return;
        }

        // 시작 시간과 종료 시간을 yyyy-MM-dd HH:mm:ss 형식으로 변환
        var date = $("#reservationDate").val();
        var startTime = $("#start_time").val();
        var endTime = $("#end_time").val();

        $("#start_time_full").val(date + " " + startTime + ":00");
        $("#end_time_full").val(date + " " + endTime + ":00");

        // 폼 제출
        $('#bookingForm').submit();
    }

    function cancel() {
        location.href = "<c:url value='/calender.do'/>";
    }

    $(document).ready(function() {
        $("#reservationDate").attr("readonly", true);
    });

    function setRoom(room_id) {
        if (room_id == "1207호") {
            $("#name").val("1207호")
        } else if (room_id == "1208호") {
            $("#name").val("1208호")
        } else if (room_id == "1209호") {
            $("#name").val("1209호")
        }
    }
    
    function out(){
    	location.href ="<c:url value='/logout.do'/>";
    }
</script>
<style>
.jumbotron-custom {
    background-color: #f5f5f5;
    padding: 30px 15px;
    margin-bottom: 30px;
}
</style>
</head>
<body>
<header>
    <c:if test="${sessionScope.userId != null && sessionScope.userId != ''}">
        <div class="pull-right">
            ${sessionScope.userName}님 환영합니다
            <button type="button" class="btn btn-default" onclick="out();">로그아웃</button>
        </div>
    </c:if>
    <div class="jumbotron text-center jumbotron-custom">
        <h2>스마트금융학과 회의실 예약 시스템</h2>
        <p>모두 자유롭게 예약해보세요!</p>
    </div>
    <ul class="nav nav-tabs">
        <li><a href="/">홈</a></li>
        <li><a href="/announcement.do">공지사항</a></li>
        <li class="active"><a href="/calender.do">회의실 예약</a></li>
    </ul>
</header>
<div class="container">
    <h1>회의실 예약</h1>
    <div class="panel panel-default">
        <div class="panel-body">
            <form id="bookingForm" name="bookingForm" action="/booking.do" method="post" class="form-horizontal">
                <div class="form-group">
                    <label for="reservationDate" class="control-label col-sm-2">예약 날짜:</label>
                    <div class="col-sm-10">
                        <input type="date" id="reservationDate" name="reservationDate" class="form-control" value="${param.date}" readonly>
                    </div>
                </div>
                <div class="form-group">
                    <label for="idx" class="control-label col-sm-2">예약 번호:</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="idx" name="idx" value="${reservationIdx}" readonly>
                    </div>
                </div>
                <div class="form-group">
                    <label for="room_id" class="control-label col-sm-2">회의실:</label>
                    <div class="col-sm-10">
                        <select id="room_id" name="room_id" class="form-control">
                            <option value="1207호">1207호 (2층, 수용인원: 15명)</option>
                            <option value="1208호">1208호 (2층, 수용인원: 20명)</option>
                            <option value="1209호">1209호 (2층, 수용인원: 15명)</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="user_id" class="control-label col-sm-2">사용자 아이디:</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${sessionScope.userId}</p>
                    </div>
                    <input type="hidden" id="user_id" name="user_id" value="${sessionScope.userId}">
                </div>
                <div class="form-group">
                    <label for="purpose" class="control-label col-sm-2">회의명:</label>
                    <div class="col-sm-10">
                        <input type="text" id="purpose" name="purpose" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2">시작시간/종료시간:</label>
                    <div class="col-sm-5">
                        <select id="start_time" name="start_time" class="form-control">
                            <c:forEach var="hour" begin="9" end="17">
                                <option value="${hour < 10 ? '0' : ''}${hour}:00">${hour < 10 ? '0' : ''}${hour}:00</option>
                                <option value="${hour < 10 ? '0' : ''}${hour}:30">${hour < 10 ? '0' : ''}${hour}:30</option>
                            </c:forEach>
                            <option value="18:00">18:00</option>
                        </select>
                    </div>
                    <div class="col-sm-5">
                        <select id="end_time" name="end_time" class="form-control">
                            <c:forEach var="hour" begin="9" end="17">
                                <option value="${hour < 10 ? '0' : ''}${hour}:00">${hour < 10 ? '0' : ''}${hour}:00</option>
                                <option value="${hour < 10 ? '0' : ''}${hour}:30">${hour < 10 ? '0' : ''}${hour}:30</option>
                            </c:forEach>
                            <option value="18:00">18:00</option>
                        </select>
                    </div>
                </div>
                <!-- Hidden inputs to store the full datetime strings -->
                <input type="hidden" id="start_time_full" name="start_time_full">
                <input type="hidden" id="end_time_full" name="end_time_full">
                <div class="form-group text-right">
                    <button type="button" class="btn btn-primary" onclick="booking();">예약</button>
                    <button type="button" class="btn btn-default" onclick="cancel();">취소</button>
                </div>
            </form>
        </div>
    </div>
</div>
<footer>
    <div class="panel-footer text-center">
        <p>&copy; 2024 스마트금융학과 회의실 예약 시스템</p>
    </div>
</footer>
</body>
</html>
