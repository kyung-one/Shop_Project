<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<div class="container mt-3">
	<h3>인기상품</h3>
	<div class="row">
		<c:forEach items="${product}" var="product" begin="0" end="7">
			<div class="col-3 mb-2" style="width: 300px">
					<div class="card h-100">
						<!-- Product image-->
						<a href="/pdetail/${product.productid}"><img
							class="card-img-top" src="/image/${product.filename}"
							style="height: 200px" alt="..." /></a>
						<!-- Product details-->
						<div class="card-body p-4">
							<div class="text-left">
								<!-- Product name-->
								<a href="/pdetail/${product.productid}"><h5 class="fw-bolder">${product.pname }</h5></a>
								${product.manufacturer }<br>
								<fmt:formatNumber pattern="###,###,###"
									value="${product.price }" />원<br>
									리뷰 ${product.reviewcnt }개
							</div>
						</div>
					</div>
			</div>
		</c:forEach>
	</div>
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
			<form class="form-inline" action="/product/plist" method="get">
				<select name="field" class="form-control mr-sm-1">
					<option value="pname">상품명</option>
					<option value="manufacturer">제조사</option>
				</select>
				<input type="text" name="word" class="form-control" placeholder="검색">
				<button class="btn btn-secondary">검색</button>
			</form>
		</div>
	</div>
</div>
<%@ include file="../includes/footer.jsp"%>