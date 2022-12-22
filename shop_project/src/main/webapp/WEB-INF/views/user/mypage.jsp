<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="container mt-3">
	<h3>마이페이지</h3>
	<br>
	<h5>주문내역</h5>
	<div id="mypage">
		<table class="table table-hover">
			<thead>
				<tr>
					<th class="text-center align-middle" width="90">주문번호</th>
					<th class="text-center align-middle" width="100">주문일자</th>
					<th class="text-center align-middle" width="400">상품명</th>
					<th class="text-center align-middle" width="150">결제금액</th>
					<th class="text-center align-middle" width="100">주문상태</th>
					<th class="text-center align-middle" width="150">운송장번호</th>

				</tr>
			</thead>
			<tbody>
				<c:forEach items="${orders }" var="orders" varStatus="st">
					<tr>
						<td class="text-center align-middle" id="ordernum">${orders.ordernum }<br>
						<a href="/shop/orddetail/${orders.ordernum }"><button type="button" class="btn btn-outline-secondary btn-sm" >
						상세보기</button></a></td>
						<td class="text-center align-middle"><fmt:formatDate
								value="${orders.orderdate }" pattern="yyyy-MM-dd" /></td>
						<td class="text-center align-middle">${orders.pname }</td>
						<td class="text-center align-middle"><fmt:formatNumber
								pattern="###,###,###" value="${orders.price }" />원</td>
						<td class="text-center align-middle" id="status">${orders.status }
						</td>
						<td class="text-center align-middle">${orders.trackingnum }</td>

					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<hr>
	<div>
		<a href="modify/${pinfo.member.id }"><button type="button"
				class="btn btn-info btn-lg">회원정보수정</button></a>
	</div>
</div>

<script>
	var ordernum = document.getElementById("ordernum").innerText;
	var view = function() {
		$.ajax({
			type : 'get',
			url : '/orddetail/' + $(this).data("mid"),
			success : function(resp) {
				if (resp == "success") {
					location.href="/shop/orderdetail/"+ $(this).data("mid")
				}
			},
			error : function(e) {
				alert("실패 : " + e)
			}
		}) //ajax
	} //btnDelete
	$("#mypage").on("click",".btnView",view);
</script>

<%@ include file="../includes/footer.jsp"%>