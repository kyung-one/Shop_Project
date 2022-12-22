<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>


<input type="hidden" name="productid" id="productid"
	value="${productid}">

<div class="container mt-3">
	<button type="button" class="btn btn-info"
		onclick="location.href='/qinsert/${productid}' ">문의사항 작성</button>

	<h3>(${productid })번 상품문의</h3>
	<table class="table table-hover">
		<thead>
			<tr>
				<th class="text-center" width="70">번호</th>
				<th class="text-center" width="100">상품번호</th>

				<th class="text-center">제목</th>
				<th class="text-center" width="150">내용</th>
				<th class="text-center" width="100">아이디</th>
				<th class="text-center" width="150">작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${qlist.content }" var="lists" varStatus="st">
				<tr>
					<td class="text-center">${lists.qnanum}</td>
					<td class="text-center">${productid }</td>
					<td class="text-left"><a href="/qview/${lists.qnanum }">
							${lists.title }</a></td>
					<td class="text-center">${lists.content }</td>
					<td class="text-center">${lists.member.id }</td>
					<td class="text-center"><fmt:formatDate
							value="${lists.regdate}" pattern="yyyy-MM-dd" /></td>
				</tr>

			</c:forEach>

		</tbody>
	</table>



	<div class="d-flex justify-content-between">


		<ul class="pagination mt-3 ">

			<!-- 이전  -->
			<c:if test="${qlist.first==false}">
				<li class="page-item"><a class="page-link"
					href="?page=${qlist.number-1 }&field=${param.field}&word=${param.word}">이전</a></li>
			</c:if>

			<!-- 다음  -->
			<c:if test="${qlist.last==false}">
				<li class="page-item"><a class="page-link"
					href="?page=${qlist.number+1 }&field=${param.field}&word=${param.word}">다음</a></li>
			</c:if>


		</ul>


		<form class="form-inline" action="/qlist" method="get">
			<div class="container" align="center">
				<select name="field" id="field" class="form-control mr-sm-1">
					<option value="title">제목
					<option value="content">내용
				</select>

				<script>
					$("#field option").each(function() {
						if ($(this).val() == "${param.field}") {
							$(this).prop("selected", true);
						}
					})
				</script>

				<input type="text" size=16 name="word" id="word"
					class="form-control">
				<button value="찾기" id="btnSearch" class="btn btn-secondary">search</button>
			</div>
		</form>

	</div>


</div>
<%@ include file="../includes/footer.jsp"%>
