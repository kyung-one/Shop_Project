<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>    
      <%@ include file="../includes/header.jsp"%>  
<script>
var path = "${pageContext.request.contextPath }";
 
$(document).ready(function() {
var msg = "${msg}";
if(msg != ""){
alert(msg);    
}
});
 
 
function fnSubmit() {
 
var email_rule =  /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

 
 
if ($("#username").val() == null || $("#username").val() == "") {
alert("이름을 입력해주세요.");
$("#username").focus();
 
return false;
}
 
 
if ($("#email").val() == null || $("#email").val() == "") {
alert("email 입력해주세요.");
$("#email").focus();
 
return false;
}
 
 
 
if (confirm("비밀번호를 찾으시겠습니까?")) {
 
$("#createForm").submit();
 
return false;
}
}
 
</script>
 
<head>
 
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
 
<title>SB Admin 2 - Register</title>
 
<!-- Custom fonts for this template-->
<link href="/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link
href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
rel="stylesheet">
 
<!-- Custom styles for this template-->
<link href="/css/sb-admin-2.min.css" rel="stylesheet"> 
 
</head>
 
<form:form commandName="searchVO" id="createForm" action="${path}/account/search_result_pwd" method="post">

 
<body class="bg-gradient-primary">
 
<div class="container">
 
<!-- Outer Row -->
<div class="row justify-content-center">
 
<div class="col-xl-10 col-lg-12 col-md-9">
 
<div class="card o-hidden border-0 shadow-lg my-5">
<div class="card-body p-0">
<!-- Nested Row within Card Body -->
<div class="row">
<div class="col-lg-6 d-none d-lg-block bg-password-image"></div>
<div class="col-lg-6">
  <div class="p-5">
      <div class="text-center">
          <h1 class="h4 text-gray-900 mb-2">Forgot Your Password?</h1>
          <p class="mb-4">We get it, stuff happens. Just enter your ID, name, phon number below
              and we'll send you a link to reset your password!</p>
      </div>
      <form class="user">
          <div class="form-group">
              <input type="text" class="form-control form-control-user"
                  id="id" name="id"
                  placeholder="Enter ID...">
          </div>
          <div class="form-group">
              <input type="text" class="form-control form-control-user"
                  id="username" name="username"
                  placeholder="Enter name...">
          </div>
          <div class="form-group">
              <input type="email" class="form-control form-control-user"
                  id="email" name="email"
                  placeholder="Enter phon email...">
          </div>
          <a href="javascript:void(0)" onclick="fnSubmit(); return false;" class="btn btn-primary btn-user btn-block">
              Reset Password
          </a>
      </form>
      <hr>
      <div class="text-center">
          <a class="small" href="/user/join">Create an Account!</a>
      </div>
      <div class="text-center">
          <a class="small" href="/user/login">Already have an account? Login!</a>
      </div>
  </div>
</div>
</div>
</div>
</div>
 
</div>
 
</div>
 
</div>
 
<!-- Bootstrap core JavaScript-->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
 
<!-- Core plugin JavaScript-->
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>
 
<!-- Custom scripts for all pages-->
<script src="js/sb-admin-2.min.js"></script>
 
</body>
 
 
</form:form>
</html>