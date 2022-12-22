<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%><style>
table{
font-size:14pt
}
</style>
<div class="container mt-3">
	<div class="row">
		<div class="col">
		<input type="hidden" id="ordernum" value="${orders.ordernum}">

			<table class="table table-borderless">
				<tbody>
					<tr>
						<th scope="row">주문번호</th>
						<td id="ordernum1">${orders.ordernum}</td>
					</tr>
					<tr>
						<th scope="row">주문일자</th>
						<td id="orderdate">${orders.orderdate}</td>
					</tr>
					<tr>
						<th scope="row">이름</th>
						<td id="ordname">${orders.ordname}</td>
					</tr>
					<tr>
						<th scope="row">전화번호</th>
						<td id="ordphone">${orders.ordphone}</td>
					</tr>
					<tr>
						<th scope="row">이메일</th>
						<td id="ordemail">${orders.ordemail}</td>
					</tr>

					<tr>
						<th scope="row">주문상품</th>
						<td id="pstock">${orders.pname }</td>
					</tr>
					<tr>
						<th scope="row">결제금액</th>
						<td id="price"><fmt:formatNumber pattern="###,###,###"
								value="${orders.price}" />원</td>
					</tr>
					<tr>
						<th scope="row">결제수단</th>
						<td id="paywith">${orders.paywith}</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col">
			<table class="table table-borderless">
				<tbody>

					<tr>
						<th scope="row">우편번호</th>
						<td id="ordzipcode">${orders.ordzipcode}</td>
					</tr>
					<tr>
						<th scope="row">도로명주소</th>
						<td id="ordroadaddr">${orders.ordroadaddr}</td>
					</tr>
					<tr>
						<th scope="row">지번주소</th>
						<td id="ordjibunaddr">${orders.ordjibunaddr}</td>
					</tr>
					<tr>
						<th scope="row">상세주소</th>
						<td id="ordextraaddr">${orders.ordextraaddr}</td>
					</tr>
					<tr>
						<th scope="row">배송요청사항</th>
						<td id="memo">${orders.memo}</td>
					</tr>
					<tr>
						<th scope="row">주문상태변경</th>
						<td><select class="form-control" name="status"
							id="status">
								<option>-----</option>
								<option value="입금대기중">입금대기중</option>
								<option value="결제완료">결제완료</option>
								<option value="배송준비중">배송준비중</option>
								<option value="발송완료">발송완료</option>
						</select></td>
					</tr>
					<tr>
						<th scope="row">운송장번호</th>
						<td><input type="text" id="trackingnum" value="${orders.trackingnum }"></td>
					</tr>
					<tr>
						<th scope="row"><button type="button" id="btnStatusUpdate">저장</button></th>
					</tr>
					<tr>
						<th scope="row"><button type="button" id="btnCancel">주문취소</button></th>
					</tr>

				</tbody>
			</table>
		</div>
	</div>
</div>

<script>
	$("#btnStatusUpdate").click(function() {

		if (!confirm('저장할까요?')) {// false
			return false;
		}
		var data = {
			"ordernum" : $("#ordernum").val(),
			"status" : $("#status").val(),
			"trackingnum" : $("#trackingnum").val()
		}
		$.ajax({
			type : "put",
			url : '/admin_ordUpdate',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(data)
		}).done(function(resp) {
			if (resp == "success") {
				alert("저장되었습니다")
				location.href = "/admin_orddetail/${orders.ordernum }"
			}
		}).fail(function() {
			alert("실패")
		})
	})
	$("#btnCancel").click(function() {
		if (!confirm('취소할까요?')) {// false
			return false;
		}
		$.ajax({
			type : 'DELETE',
			url : '/cancelOrd/${orders.ordernum}',
			success : function(resp) {
				if (resp == "success") {
					alert("취소되었습니다");
					location.href = "/admin"
				}
			},
			error : function(e) {
				alert("취소 실패 : " + e)
			}
		}) //ajax
	}) //btnDelete
</script>
<%@ include file="../includes/footer.jsp"%>