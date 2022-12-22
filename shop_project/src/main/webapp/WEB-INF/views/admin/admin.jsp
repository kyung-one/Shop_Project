<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="container mt-3">
<a href="/admin/members"><button class="btn btn-secondary">회원관리</button></a>
<a href="/catlist"><button class="btn btn-secondary">카테고리관리</button></a>
<a href="/product/pinsert"><button class="btn btn-secondary">상품등록</button></a>
<a href="/noticeinsert"><button class="btn btn-secondary">공지등록</button></a>


</div>
<div class="container mt-3">
	<h3>주문관리</h3>
	<table class="table table-hover">
		<thead>
			<tr>
				<th class="text-center align-middle" width="100">주문번호</th>
				<th class="text-center align-middle" width="150">주문일자</th>
				<th class="text-center align-middle" width="400">주문상품</th>
				<th class="text-center align-middle" width="150">상품금액</th>
				<th class="text-center align-middle" width="100">주문상태</th>
				<th class="text-center align-middle" width="150">상세보기</th>


			</tr>
		</thead>
		<tbody>
			<c:forEach items="${orders }" var="orders" varStatus="st">
				<tr>
					<td class="text-center align-middle">${orders.ordernum }</td>
					<td class="text-center align-middle"><fmt:formatDate
							value="${orders.orderdate }" pattern="yyyy-MM-dd" /></td>
					<td class="text-center align-middle">${orders.pname }</td>
					<td class="text-center align-middle"><fmt:formatNumber
							pattern="###,###,###" value="${orders.price }" />원</td>
					<td class="text-center align-middle">${orders.status }</td>

					<td class="text-center align-middle"><a href="admin_orddetail/${orders.ordernum }"><button class="btn btn-outline-secondary btn-sm">상세보기</button></a></td>

				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>


<%@ include file="../includes/footer.jsp"%>
