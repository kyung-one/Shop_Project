<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>


<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="container mt-3">

	<h4>카테고리 추가</h4>
	<form action="catinsert" method="post">

		<div class="form-group">
			<label for="catname">카테고리명</label> <input type="text"
				class="form-control" id="catname" name="catname">
		</div>
		<button type="submit" class="btn btn-primary">추가</button>
	</form>
</div>
<div class="container mt-3">
	<h4>카테고리 목록(${catcount })</h4>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>카테고리명</th>


			</tr>
		</thead>
		<tbody>
			<c:forEach items="${catlist }" var="catlist" varStatus="st">
				<tr>
					<td>${catlist.catnum}</td>
					<td><a href="/catview/${catlist.catnum }">
							${catlist.catname }</a></td>


				</tr>

			</c:forEach>
		</tbody>
	</table>


	<div class="d-flex justify-content-between mr-auto">
		<!-- 		<ul class="pagination"> -->
		<%-- 			<c:if test="${product.first==false }"> --%>
		<!-- 				<li class="page-item"><a class="page-link" -->
		<%-- 					href="?page=${product.number-1 }&field=${param.field}&word=${param.word}">이전</a></li> --%>
		<%-- 			</c:if> --%>
		<%-- 			<c:if test="${product.last==false }"> --%>
		<!-- 				<li class="page-item"><a class="page-link" -->
		<%-- 					href="?page=${product.number+1 }&field=${param.field}&word=${param.word}">다음</a></li> --%>
		<%-- 			</c:if> --%>
		<!-- 		</ul> -->
		<div>
			<form class="form-inline" action="/catlist" method="get">
				<select name="catfield" class="form-control mr-sm-1">
					<option value="catname">카테고리명</option>
				</select> <input type="text" name="catword" class="form-control"
					placeholder="검색">
				<button class="btn btn-secondary">검색</button>
			</form>
		</div>

	</div>
</div>



<%@ include file="../includes/footer.jsp"%>