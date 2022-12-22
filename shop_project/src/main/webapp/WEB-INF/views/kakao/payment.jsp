<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <!-- iamport.payment.js -->
  <script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-{SDK-최신버전}.js"></script>
 
  
  
 
    
</head>
<body>

<h1> kakaoPay api 이용하기 </h1>




<form method="post" action="/kakaoPay">

<button class="btm_image" id="imgbtn"><img  src="/imgs/payment_icon_yellow_medium.png"><br><b>카카오페이 결제</b></button>
    
</form>

<br>

<button id="iamportPayment" type="button"><img  src="/imgs/payment_icon_yellow_medium.png"><br><b>카카오페이 결제</b></button>



<br><br>

 	<div id="replyResult"></div>
 	
 	
 	
 	
 	
 	
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
        merchant_uid: "test_id6", //가맹점 주문번호 (아임포트를 사용하는 가맹점에서 중복되지 않은 임의의 문자열을 입력)
        name: "${pinfo.member.username}", //결제창에 노출될 상품명
        amount: 1000, //금액
        buyer_email : "testiamport@naver.com", 
        buyer_name : "${pinfo.member.username}",
        buyer_tel : "01012341234"
    }, function (rsp) { // callback
        if (rsp.success) {  
           /*  alert("완료 -> imp_uid : "+rsp.imp_uid+" / merchant_uid(orderKey) : " +rsp.merchant_uid); */
           
            var str="<table class='table table-hover mt-3'>";
			
				str +="<tr>"
				str += "<td>상품명: "+rsp.name+"</td>"
				str += "<td>가격: "+rsp.paid_amount+"</td>"
				str += "<td>고유ID: "+rsp.imp_uid+"</td>"
				str += "<td>상점 거래ID: "+rsp.merchant_uid+"</td></tr><br>"
				
			str +="</table>"
			$("#replyResult").html(str)
			
			
        } else {
            alert("실패 : 코드("+rsp.error_code+") / 메세지(" + rsp.error_msg + ")");
        }
    });
}
  

</script>
  

</body>
</html>