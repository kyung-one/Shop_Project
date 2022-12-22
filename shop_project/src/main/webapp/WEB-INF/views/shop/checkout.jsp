<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<!-- jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-{SDK-최신버전}.js"></script>
<style>
#btnChkout {
	display: none;
}
</style>

<input type="hidden" id="username" name="username"
	value="${pinfo.username}" />


<div class="container mt-3">
	<h4>주문상품</h4>
	<input type="hidden" name="mid" id="mid" value="${pinfo.member.id }">
	<table class="table table-striped">
		<thead>
			<tr>
				<th class="text-center align-middle">상품번호</th>
				<th class="text-center align-middle"></th>
				<th class="text-center align-middle">상품명</th>
				<th class="text-center align-middle">상품금액(수량)</th>
				<th class="text-center align-middle">가격</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="total" value="0" />
			<c:forEach items="${cart}" var="cart">
				<tr>
					<td class="text-center align-middle" width="100">${cart.product.productid }</td>
					<td class="text-center align-middle" width="100"><img
						src="/image/${cart.p_img }" width="100px" height="auto"></td>
					<td class="text-center align-middle" id="pname" width="300">${cart.p_name }</td>
					<td class="text-center align-middle" width="150"><fmt:formatNumber
							pattern="###,###,###" value="${cart.p_price}" />원 (${cart.amount }개)</td>
					<td class="text-center align-middle" width="150"><fmt:formatNumber
							pattern="###,###,###" value="${cart.p_price*cart.amount}" />원</td>
				</tr>
				<c:set var="total" value="${total + cart.p_price*cart.amount}" />
			</c:forEach>
			<tr>
				<td colspan="3" class="text-center align-middle"><h4>합계</h4></td>
				<td colspan="3" class="text-letf align-middle">
					<h4>
						<fmt:formatNumber pattern="###,###,###" value="${total}" />
						원
					</h4>
				</td>
			</tr>
		</tbody>
	</table>
	<br>
	<h4>배송정보</h4>
	<div class="form-group">
		<label for="name">이름</label> <input type="text" class="form-control"
			id="name" name="name" value="${pinfo.member.name }">
	</div>
	<div class="form-group">
		<label for="phone">전화번호</label> <input type="text"
			class="form-control" id="phone" name="phone"
			value="${pinfo.member.phone }">
	</div>
	<div class="form-group">
		<label for="email">이메일</label> <input type="text" class="form-control"
			id="email" name="email" value="${pinfo.member.email }">
	</div>
	<div class="form-row">
		<div class="form-group col-md-2">
			<input type="text" class="form-control" id="zipcode" name="zipcode"
				placeholder="우편번호" readonly="readonly"
				value="${pinfo.member.zipcode }">
		</div>
		<div>
			<input type="button" class="btn btn-secondary"
				onclick="execDaumPostcode()" value="우편번호 찾기"><br>
		</div>
		<div class="form-group col-md-6">
			<input type="text" class="form-control" id="roadaddr" name="roadaddr"
				placeholder="도로명주소" readonly="readonly"
				value="${pinfo.member.roadaddr }">
		</div>
	</div>
	<div class="form-row">
		<div class="form-group col-md-6">
			<input type="text" class="form-control" id="jibunaddr"
				name="jibunaddr" placeholder="지번주소" readonly="readonly"
				value="${pinfo.member.jibunaddr }">
		</div>
		<span id="guide" style="color: #999; display: none;"></span>
		<div class="form-group col-md-6">
			<input type="text" class="form-control" id="extraaddr"
				name="extraaddr" placeholder="상세주소"
				value="${pinfo.member.extraaddr }">
		</div>
	</div>
	<div class="form-group">
		<label for="memo">배송시 요청사항</label> <input type="text"
			class="form-control" id="memo" name="memo">
	</div>
	<hr>
	<h4>결제수단</h4>
	<div class="form-group">
		<select class="form-control w-25" name="paywith" id="paywith"
			onchange="chageLangSelect()">
			<option value="간편결제">간편결제</option>
			<option value="무통장입금">무통장입금</option>
			<option value="계좌이체">계좌이체</option>
			<option value="신용카드">신용카드</option>

		</select>
	</div>

	<button type="button" class="btn btn-success btn-lg" id="btnChkout">${total}원
		결제하기</button>


	<input type="hidden" name="total" id="total" value="${total}">
</div>


<div class="container">
	<button id="iamportPayment" type="button"
		class="btn btn-outline-warning btn-lg">
		<img src="/imgs/payment_icon_yellow_medium.png"><b>카카오페이 결제</b>
	</button>
</div>
<br>
<br>
<script>
  $(document).ready(function(){ 
		$("#iamportPayment").click(function(){ 
	    	payment(); //버튼 클릭하면 호출 
	    }); 
	})
  
	//버튼 클릭하면 실행
function payment(data) {
    IMP.init('imp40862100');//아임포트 관리자 콘솔에서 확인한 '가맹점 식별코드' 입력
    IMP.request_pay({// param
        pg: "kakaopay.TC0ONETIME", //pg사명 or pg사명.CID (잘못 입력할 경우, 기본 PG사가 띄워짐)
        pay_method: "card", //지불 방법
        merchant_uid: "${random}", //가맹점 주문번호 (아임포트를 사용하는 가맹점에서 중복되지 않은 임의의 문자열을 입력)
        name: "${countCart}개의 상품", //결제창에 노출될 상품명
        amount: "${total}", //금액
        buyer_email : "${pinfo.member.email}", 
        buyer_name : "${pinfo.username}",
        buyer_tel : "${pinfo.member.phone}"
    }, function (rsp) { // callback
        if (rsp.success) {  
           /*  alert("완료 -> imp_uid : "+rsp.imp_uid+" / merchant_uid(orderKey) : " +rsp.merchant_uid); */
           document.getElementById('btnChkout').click();   

			
        } else {
            alert("실패 : 코드("+rsp.error_code+") / 메세지(" + rsp.error_msg + ")");
        }
    });
}
  


  function chageLangSelect(){
      var langSelect = document.getElementById("paywith");
      const btn1 = document.getElementById('iamportPayment');
      const btn2 = document.getElementById('btnChkout');
     if($("#paywith option:selected").val() != "간편결제"){
  	  
  	   btn1.style.display = 'none';
  	   btn2.style.display = 'block';
     }else {
  	   btn1.style.display = 'block';
  	   btn2.style.display = 'none';
  	   
     }
     
  }



	$("#btnChkout").click(function() {
		if ($("#name").val() == "") {
			alert("이름을 입력하세요")
			$("#username").focus()
			return;
		}
		if ($("#email").val() == "") {
			alert("이메일을 입력하세요")
			$("#email").focus()
			return;
		}
		if ($("#addr").val() == "") {
			alert("주소를 입력하세요")
			$("#addr").focus()
			return;
		}
		if ($("#zipcode").val() == "") {
			alert("우편번호를 입력하세요")
			$("#zipcode").focus()
			return;
		}
		if ($("#phone").val() == "") {
			alert("전화번호를 입력하세요")
			$("#phone").focus()
			return;
		}
		
		var pname = document.getElementById("pname").innerText;
		
		data = {
			"ordname" : $("#name").val(),
			"memberid" : $("#mid").val(),
			"memo" : $("#memo").val(),
			"pname" : pname,
			"ordroadaddr" : $("#roadaddr").val(),
			"ordjibunaddr" : $("#jibunaddr").val(),
			"ordextraaddr" : $("#extraaddr").val(),
			"ordzipcode" : $("#zipcode").val(),
			"ordphone" : $("#phone").val(),
			"ordemail" : $("#email").val(),
			"paywith" : $("#paywith").val(),
			"price" : $("#total").val(),
		}
		$.ajax({
			type : "post",
			url : '/shop/checkout',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(data)
		}).done(function(resp) {
			if (resp == "success") {
				alert("결제완료")
				location.href = "/mypage/${pinfo.member.id }"
			}
		}).fail(function() {
			alert("실패")
		})
		.then((arg) =>{ // 두번째 ajax를 실행한다.
		$.ajax({
			type:'delete',
			url : '/shop/checkout/'+$("#username").val()
			}) //ajax
		.done(function(resp){
			alert(resp+"카트 삭제 완료")
			location.href = "/mypage/${pinfo.member.id }"
			})//done
		.fail(function(e){
			alert("삭제 실패:" + e)
			}) //fail
			
			}) //then
	})
	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 참고 항목 변수

				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('zipcode').value = data.zonecode;
				document.getElementById("roadaddr").value = roadAddr;
				document.getElementById("jibunaddr").value = data.jibunAddress;

				// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
				if (roadAddr !== '') {
					document.getElementById("extraaddr").value = extraRoadAddr;
				} else {
					document.getElementById("extraaddr").value = '';
				}

				var guideTextBox = document.getElementById("guide");
				// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
				if (data.autoRoadAddress) {
					var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
					guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr
							+ ')';
					guideTextBox.style.display = 'none';

				} else if (data.autoJibunAddress) {
					var expJibunAddr = data.autoJibunAddress;
					guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr
							+ ')';
					guideTextBox.style.display = 'none';
				} else {
					guideTextBox.innerHTML = '';
					guideTextBox.style.display = 'none';
				}
			}
		}).open();
	}
</script>
<%@ include file="../includes/footer.jsp"%>