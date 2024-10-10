<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
pageContext.setAttribute("crcn", "\r\n"); // Space, Enter
pageContext.setAttribute("br", "<br/>"); // br태그
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/css/bootstrap/css/bootstrap.min.css">
<script src="/js/jquery-3.5.1.min.js"></script>
<script src="/css/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javaScript" type="Javascript"  defer="defer">
	function cancel() {
		location.href = "<c:url value='/announcement.do'/>";
	}

	$(document).ready(function() {
		$("#idx").attr("readonly", true);
		$("#writerNm").attr("readonly", true);
		$("#indate").attr("readonly", true);
	});

	function modify() {
		location.href = "<c:url value='/mgmt.do'/>?idx=${reservationVO.idx}";
	}
	
	function list(){
		location.href = "<c:url value='/announcement.do'/>";
	}
	
	function del(){
		var cnt = ${fn:length(resultList)};
		if ( cnt > 0 ){
			alert("댓글이 있는 게시물은 삭제할 수 없습니다");
			return;
		}
		if (!confirm("삭제하시겠습니까?")){
			return;
		}
		document.form1.action = "<c:url value='mgmt.do'/>?mode=del&idx=${reservationVO.idx}";
		document.form1.submit();
	}

</script>
</head>
<body>
<header>
			<c:if test="${sessionScope.userId !=null && sessionScope.userId !='' }">
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
            <li class="active"><a href="/announcement.do">공지사항</a></li>
            <li><a href="/calender.do">회의실 예약</a></li>
        </ul>
</header>
	<div class="container">
		<h1>게시글 조회 화면</h1>
		<div class="panel panel-default">
			<div class="panel-body">
				<form id="form1" name="form1" class="form-horizontal" method="post" action="/">
					<div class="form-group">
						<label class="control-label col-sm-2" for="idx">게시물번호:</label>
						<div class="col-sm-10 control-label" style="text-align: left;">
							<c:out value="${reservationVO.idx}" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="pwd">제목:</label>
						<div class="col-sm-10 control-label" style="text-align: left;">
							<c:out value="${reservationVO.title}" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2" for="pwd">등록자/등록일:</label>
						<div class="col-sm-10 control-label" style="text-align: left;">
							<c:out value="${reservationVO.writerNm}" /> / <c:out value="${reservationVO.indate}" />
						</div>
					</div>

					<div class="form-group">
						<label class="control-label col-sm-2" for="pwd">내용:</label>
						<div class="col-sm-10 control-label" style="text-align: left;">
							<c:out value="${fn:replace(reservationVO.contents, crcn, br)}" escapeXml="false" />
						</div>
					</div>
					<div class="form-group  text-right">
						<c:if test="${!empty sessionScope.userId && sessionScope.userId == reservationVO.writer}">
						<button type="button" class="btn btn-default" onclick="modify();">수정</button>
						<button type="button" class="btn btn-default" onclick="del();">삭제</button>
						</c:if>
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
