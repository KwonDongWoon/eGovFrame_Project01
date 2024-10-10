<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/css/bootstrap/css/bootstrap.min.css">
<script src="/js/jquery-3.5.1.min.js"></script>
<script src="/css/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javaScript" type="Javascript" defer="defer">
	$(document).ready(function() {
		$("#idx").attr("readonly", true);
		$("#writerNm").attr("readonly", true);
		$("#indate").attr("readonly", true);
	})
	function cancel() {
		location.href = "<c:url value='/announcement.do'/>";
	}
	function add() {
		if ($("#title").val() == '') {
			alert("제목을 입력하세요");
			$("#title").focus();
			return;
		}
		if ($("#contents").val() == '') {
			alert("내용을 입력하세요");
			$("#contents").focus();
			return;
		}
		if (!confirm("등록하시겠습니까?")) {
			return;
		}
		document.boardRegForm.action = "<c:url value='mgmt.do'/>?mode=add";
		document.boardRegForm.submit();
	}
	function modify() {
		if ($("#title").val() == '') {
			alert("제목을 입력하세요");
			$("#title").focus();
			return;
		}
		if ($("#contents").val() == '') {
			alert("내용을 입력하세요");
			$("#contents").focus();
			return;
		}
		if (!confirm("수정하시겠습니까?")) {
			return;
		}
		document.boardRegForm.action = "<c:url value='mgmt.do'/>?mode=modify";
		document.boardRegForm.submit();
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
		document.boardRegForm.action = "<c:url value='mgmt.do'/>?mode=del&idx=${reservationVO.idx}";
		document.boardRegForm.submit();
	}
	
	$(document).ready(function() {
		$("#idx").attr("readonly", true);
		$("#writerNm").attr("readonly", true);
		$("#indate").attr("readonly", true);
	});
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
            <li ><a href="/">홈</a></li>
            <li class="active"><a href="/announcement.do">공지사항</a></li>
            <li><a href="/calender.do">회의실 예약</a></li>
        </ul>

</header>

<div class="container">
	<h1>등록/수정 화면</h1>
	<div class="panel panel-default">
		<div class="panel-body">
			<form class="form-horizontal" id="boardRegForm" name="boardRegForm"
				method="post" action="/">
				<div class="form-group">
					<label class="control-label col-sm-2" for="idx">게시물번호:</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="idx" name="idx"
							placeholder="자동발번" value="${reservationVO.idx }">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="pwd">제목:</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="title" name="title"
							placeholder=" 제목을 입력하세요" maxLength="100"
							value="${reservationVO.title }">
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2" for="pwd">등록자/등록일:</label>
					<input type="hidden" class="form-control" id="writer" name="writer"
						placeholder="등록자를 입력하세요" maxLength="15"
						style="float: left; width: 40%" value="${reservationVO.writer }">
					<input type="text" class="form-control" id="writerNm"
						name="writerNm" placeholder="등록일를 입력하세요" maxLength="15"
						style="float: left; width: 40%" value="${reservationVO.writerNm }">
					<c:set var="indate" value="${reservationVO.indate}" />
					<c:if test="fn:length(indate >9)">
						<c:set var="indate" value="${fn:substring(indate,0, fn:length(indate)-2) }" />
					</c:if>
					<input type="text" class="form-control" id="indate" name="indate"
						placeholder="등록일을 입력하세요" maxLength="10"
						style="float: left; width: 40%" value="${indate }">
				</div>

					<div class="form-group">
					<label class="control-label col-sm-2" for="pwd">내용:</label>
					<div class="col-sm-10">
						<textarea class="form-control" rows="5" id="contents"
							name="contents" maxlength="1000"> ${reservationVO.contents} </textarea>
					</div>
				</div>
				
			</form>
		</div>
		<div class="panel-footer text-right" >
			<c:if test="${!empty sessionScope.userId && sessionScope.userId == reservationVO.writer}">
				<button type="button" class="btn btn-default" onclick="del();">삭제</button>
				<button type="button" class="btn btn-default" onclick="modify();">수정</button>
			</c:if>
			<button type="button" class="btn btn-default" onclick="cancel();">취소</button>
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
