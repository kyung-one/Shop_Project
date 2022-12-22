<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<div class="container mt-3">
	<div id="cartDiv">

		<h3>장바구니</h3>
		<table class="table table-hover">
			<thead>
				<tr>
					<th class="text-center align-middle">상품번호</th>
					<th class="text-center align-middle"></th>
					<th class="text-center align-middle">상품명</th>
					<th class="text-center align-middle">상품금액(수량)</th>
					<th class="text-center align-middle">가격</th>
					<th class="text-center align-middle">삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:set var="total" value="0" />
				<c:forEach items="${cart}" var="cart">
					<tr>
						<td class="text-center align-middle" width="100">${cart.product.productid }</td>
						<td class="text-center align-middle" width="100"><a
							href="/product/pdetail/${cart.product.productid }"><img
								src="/image/${cart.p_img }" width="100px" height="auto"></a></td>
						<td class="text-center align-middle" width="300"><a
							href="/product/pdetail/${cart.product.productid }">${cart.p_name }</a></td>
						<td class="text-center align-middle" width="150"><fmt:formatNumber
								pattern="###,###,###" value="${cart.p_price}" />원
							(${cart.amount }개)</td>
						<td class="text-center align-middle" width="150"><fmt:formatNumber
								pattern="###,###,###" value="${cart.p_price*cart.amount}" />원</td>
						<td class="text-center align-middle" width="100">
							<button type="button"
								class="btn btn-outline-danger btn-sm cartDelBtn"
								data-mid="${cart.cartnum }">삭제</button>
						</td>
					</tr>
					<c:set var="total" value="${total + cart.p_price*cart.amount}" />
				</c:forEach>
				<tr>
					<td colspan="3" class="text-center align-middle"><h4>합계</h4></td>
					<td colspan="2" class="text-letf align-middle" id="total"><h4>
							<fmt:formatNumber pattern="###,###,###" value="${total}" />
							원
						</h4></td>
					<td class="text-center align-middle" width="100">
						<button type="button" class="btn btn-outline-danger btn-sm"
							id="cartDelAll">전체삭제</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="container">
		<div class="row">
			<div class="col">
				<a href="/shop/checkout/${pinfo.member.username }"><button
						type="button" class="btn btn-success btn-lg" id="chkoutBtn">결제하기</button></a>
			</div>
		</div>
	</div>
</div>

<script>

		//장바구니 0원 체크
		$("#chkoutBtn").click(function() {
			if (${total} == 0) {
				alert("장바구니에 상품이 없습니다")
				return false;
			}
		})
	var del = function() {
		if (!confirm('삭제할까요?')) {// false
			return false;
		}
		$.ajax({
			type : "DELETE",
			url : '/shop/delCart/' + $(this).data("mid"),
			success : function(resp) {
				if (resp == "success") {
					alert("삭제되었습니다");
					location.href = "/shop/cart/${pinfo.member.username}"
				}
			},
			error : function(e) {
				alert("삭제 실패 : " + e)
			}
		})
	}

	$("#cartDiv").on("click", ".cartDelBtn", del);
	$("#cartDelAll").click(function() {
		if (!confirm('전체 삭제할까요?')) {// false
			return false;
		}
		$.ajax({
			type : 'DELETE',
			url : '/shop/delAll/${pinfo.member.username }',
			success : function(resp) {
				if (resp == "success") {
					alert("삭제되었습니다");
					location.href = "/shop/cart/${pinfo.member.username}"
				}
			},
			error : function(e) {
				alert("삭제 실패 : " + e)
			}
		}) //ajax
	})
</script>
<%@ include file="../includes/footer.jsp"%>