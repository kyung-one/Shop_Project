<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"
	charset="utf-8"></script>
<div class="container mt-3">
	<h3 class="text-center">로그인</h3>
	<div class="d-flex justify-content-center mt-3">
		<form action="/login" method="post">
			<div class="form-group">
				<label for="username">아이디</label> <input type="text"
					class="form-control w-100" id="username" name="username">
			</div>
			<div class="form-group">
				<label for="password">비밀번호</label> <input type="password"
					class="form-control w-100" id="password" name="password">
			</div>
			<div class="text-center mt-4">
				<button type="submit" class="btn btn-primary" id="btnLogin">로그인</button>
				<a href="/register"><button type="button"
						class="btn btn-outline-primary">회원가입</button></a>
			</div>
			<div class="text-center mt-2">
				<a href="/oauth2/authorization/google" role="button"
					class="btn btn-outline-danger bi bi-google">구글로그인</a> <a
					href="/oauth2/authorization/naver" role="button"
					class="btn btn-outline-success">네이버로그인</a>
			</div>
		</form>
	</div>
	<div class="container text-center mt-3">
		<a href="/account/search_id">아이디 찾기</a> <br>
		<a href="/account/search_pwd">비밀번호 찾기</a>
	</div>
</div>



<%@ include file="../includes/footer.jsp"%>