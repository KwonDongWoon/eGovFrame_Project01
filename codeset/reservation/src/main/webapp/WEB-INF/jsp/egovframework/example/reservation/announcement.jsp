<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Bootstrap Example</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="/js/jquery-3.5.1.min.js"></script>
<script src="/css/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" type="Javascript" defer="defer">
    function add() {
        location.href = "<c:url value='/mgmg.do'/>";
    }
    
    function view(idx) {
        location.href = "<c:url value='/view.do'/>?idx="+idx;
    }
    
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
    
    $(document).ready(function() {
        <c:if test="${!empty msg}">
          alert("${msg}");
        </c:if>
      });
    
    function check(){
        if( $("#user_id").val() ==""){
        alert("아이디를 입력하세요");
        return false;
        }
        if( $("#password").val() ==""){
        alert("비밀번호를 입력하세요");
        return false;
        }
        return true;
        }
    
    function page(pageNo){
    	location.href = "<c:url value='/announcement.do'/>?pageIndex="+pageNo;
    }
    
    function out(){
    	location.href ="<c:url value='/logout.do'/>";
    }
</script>
</head>
<body>
<header>
    <div class="panel">
        <div class="panel-heading">
       <c:if test = "${sessionScope.userId ==null || sessionScope.userId == '' }"> 
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
				<input type="email"class="form-control" id="email" name="email">
			</div>	
             <button type="submit" class="btn btn-default" onclick="return check();">로그인</button>
          </form>
          </c:if>
			<c:if test="${sessionScope.userId !=null && sessionScope.userId !='' }">
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
            <li class="active"><a href="/announcement.do">공지사항</a></li>
            <li><a href="/calender.do">회의실 예약</a></li>
        </ul>
    </div>
</header>

    <div class="panel-body">
		<form class="form-inline" method="post" action="/announcement.do">
			<div class="form-group">
				<label for="searchName">제목:</label> <input type="text"
					class="form-control" id="searchName" name="searchKeyword">
			</div>
			<button type="submit" class="btn btn-default">검색</button>
		</form>
		<div class="container tabs-table-container">
            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>게시물번호</th>
                                    <th>제목</th>
                                    <th>조회수</th>
                                    <th>등록자</th>
                                    <th>등록일</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="result" items="${resultList}" varStatus="status">
                                    <tr>
                                        <td><a href="javascript:view('${result.idx}');"><c:out
                                                value="${result.idx}" /></a></td>
                                        <td><a href="javascript:view('${result.idx}');"><c:out
                                                value="${result.title}" /></a></td>
                                        <td><c:out value="${result.count}" /></td>
                                        <td><c:out value="${result.writerNm}" /></td>
                                        <td><fmt:formatDate value="${result.indate}" pattern="yyyy-MM-dd hh:mm:ss" /></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

		<div id="paging">
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="page" />
			<!-- <form:hidden path="pageIndex" /> -->
		</div>

		<div class="form-group text-right">
            <c:if test="${sessionScope.userId == '1'}">
                <button type="button" class="btn btn-default" onclick="add();">등록</button>
            </c:if>
        </div>
    </div>
    <div class="panel-footer">
        <footer>
            <div class="panel-footer text-center">
                <p>&copy; 2024 스마트금융학과 회의실 예약 시스템</p>
            </div>
        </footer>
    </div>
</body>
</html>
