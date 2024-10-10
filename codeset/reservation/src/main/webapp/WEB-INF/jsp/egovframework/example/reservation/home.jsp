<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <title>Home</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="/js/jquery-3.5.1.min.js"></script>
  <script src="/css/bootstrap/js/bootstrap.min.js"></script>
  <script type="text/javascript" type="Javascript" defer="defer">
  
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
  
  function out(){
	location.href ="<c:url value='/logout.do'/>";
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
			${sessionScope.userName }님 환영합니다
			<button type="button" class="btn btn-default" onclick="out();">로그아웃</button>
			</div>
			</c:if>
		</div>
        <div class="jumbotron text-center jumbotron-custom">
            <h2>스마트금융학과 회의실 예약 시스템</h2>
            <p>모두 자유롭게 예약해보세요!</p>
        </div>
        <ul class="nav nav-tabs">
            <li class="active"><a href="/">홈</a></li>
            <li><a href="/announcement.do">공지사항</a></li>
            <li><a href="/calender.do">회의실 예약</a></li>
        </ul>
    </div>
</header>


<div class="panel-body">
	<div class="container body text-center">
		   <a href="https://www.kopo.ac.kr/kangseo/content.do?menu=8686" target="_blank">
		     <img src="https://www.kopo.ac.kr/ckimage/2023/101/UKLAgVUsODrrzqUVTcTM.jpg" 
		     class="img-thumbnail" alt="Cinque Terre" width="700" height="600">
		   </a>
		    <p>* 이미지를 누르면 스마트금융학과 홈페이지로 이동합니다.</p>
	</div>
</div>

<footer>
    <div class="panel-footer text-center">
        <p>&copy; 2024 스마트금융학과 회의실 예약 시스템</p>
    </div>
</footer>
</body>
</html>
