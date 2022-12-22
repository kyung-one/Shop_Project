<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
</head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />

<title>Shop</title>

<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<!-- Bootstrap core JS-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="js/scripts.js"></script>
</head>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="pinfo" />
</sec:authorize>
<body>
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light bg-white">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="/">HOME</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav mr-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item"><a class="nav-link" href="/noticelist">공지사항</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">Shop</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" href="/product/plist">전체상품</a></li>
							<li><a class="dropdown-item" href="/product/hotlist">인기상품</a></li>
						</ul></li>

				</ul>
				<ul class="navbar-nav">
					<sec:authorize access="isAnonymous()">
						<li class="nav-item"><a class="nav-link" href="/login">로그인</a></li>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
							role="button" data-bs-toggle="dropdown" aria-expanded="false">관리자</a>
							<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
								<li><a class="dropdown-item" href="/admin">관리자페이지</a></li>
								<li><a class="dropdown-item" href="/admin/members">회원관리</a></li>
								<li><a class="dropdown-item" href="/catlist">카테고리 관리</a></li>
								<li><a class="dropdown-item" href="/product/pinsert">상품등록</a></li>
								<li><a class="dropdown-item" href="/noticeinsert">공지사항
										등록</a></li>
							</ul></li>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<li class="nav-item"><a class="nav-link"
							href="/mypage/${pinfo.member.id }">마이페이지</a></li>
						<li class="nav-item"><a class="nav-link" href="/logout">로그아웃</a></li>

					</sec:authorize>
				</ul>
				<sec:authorize access="isAuthenticated()">
					<form class="d-flex">
						<a href="/shop/cart/${pinfo.member.username }"><button
								class="btn btn-outline-dark" type="button">
								<i class="bi-cart-fill me-1"></i> Cart
							</button></a>
					</form>
				</sec:authorize>
			</div>
		</div>
	</nav>
	<!-- Header-->
	<!-- 	<header class="bg-dark py-1"> -->
	<!-- 		<div class="container px-4 px-lg-5 my-5"> -->
	<!-- 			<div class="text-center text-white"> -->
	<!-- 				<h2 class="display-4 fw-bolder">Shop in style</h2> -->
	<!-- 			</div> -->
	<!-- 		</div> -->
	<!-- 	</header> -->