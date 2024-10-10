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
    function list() {
        location.href = "<c:url value='/calender.do'/>";
    }

    function del() {
        if (!confirm("삭제하시겠습니까?")) {
            return;
        }
        document.bookingForm.action = "<c:url value='/bookingView.do'/>";
        document.bookingForm.submit();
    }

    function out() {
        location.href = "<c:url value='/logout.do'/>";
    }

    $(document).ready(function() {
        $("#reservationDate").attr("readonly", true);
    });

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
    <h1>회의실 예약 정보 조회</h1>
    <div class="panel panel-default">
        <div class="panel-body">
            <form id="bookingForm" name="bookingForm" action="/booking.do" method="post" class="form-horizontal">
                <input type="hidden" name="reservation_id" value="${reservationVO.reservation_id}" />
                <div class="form-group">
                    <label for="reservationDate" class="control-label col-sm-2">예약 날짜:</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${reservationVO.start_time}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label for="room_id" class="control-label col-sm-2">회의실:</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${reservationVO.room_id}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label for="user_id" class="control-label col-sm-2">사용자 아이디:</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${reservationVO.user_id}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label for="purpose" class="control-label col-sm-2">회의명:</label>
                    <div class="col-sm-10">
                        <p class="form-control-static">${reservationVO.purpose}</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-2">시작시간/종료시간:</label>
                    <div class="col-sm-5">
                        <p class="form-control-static">${reservationVO.start_time}</p>
                        <p class="form-control-static">${reservationVO.end_time}</p>
                    </div>
                </div>
                <div class="form-group text-right">
                    <button type="button" class="btn btn-primary" onclick="del();">삭제</button>
                    <button type="button" class="btn btn-default" onclick="list();">목록</button>
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
