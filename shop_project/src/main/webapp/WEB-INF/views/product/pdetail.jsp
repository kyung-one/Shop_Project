<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<link href="/css/star.css" rel="stylesheet" />
<script src="/resources/js/stockBtn.js"></script>

<div class="container mt-3">
	<div class="row">
		<form role="form" method="post">
			<input type="hidden" id="productid" name="productid"
				value="${product.productid}" />
		</form>
		<div class="col">
			<img src="/image/${product.filename} " width="400px" height="auto">
		</div>
		<div class="col">
			<table class="table table-borderless">
				<tbody>
					<tr>
						<th scope="row">상품명</th>
						<td id="pname">${product.pname}</td>
					</tr>
					<tr>
						<th scope="row">카테고리</th>
						<td id="catnum">${product.category.catnum}</td>

					</tr>
					<tr>
						<th scope="row">제조사</th>
						<td id="manufacturer">${product.manufacturer}</td>
					</tr>
					<tr>
						<th scope="row">가격</th>
						<td id="price"><fmt:formatNumber pattern="###,###,###"
								value="${product.price}" />원</td>
					</tr>
					<tr>
						<th scope="row">재고수량</th>
						<td id="pstock">${product.pstock}개</td>
					</tr>
					<tr>

						<th scope="row">구입수량</th>
						<td id="amount"><c:if test="${product.pstock != 0}">
								<p class="cartStock">
									<button type="button" class="minus">-</button>
									<input type="number" class="numBox" min="1"
										max="${product.pstock}" value="1" readonly="readonly" />
									<button type="button" class="plus">+</button>
									<input type="hidden" value="${product.pstock}"
										class="pstock_hidden" />

								</p>
							</c:if></td>
					</tr>
				</tbody>
			</table>
			<p>
				<button type="button" class="btn btn-primary" id="addCart_btn">카트에
					담기</button>
			</p>
			<p>
				<a href="/qinsert/${product.productid}"><button type="button"
						class="btn btn-outline-secondary">상품문의</button></a>
			</p>

			<c:if test="${product.pstock == 0}">
				<p>상품 수량이 부족합니다.</p>
			</c:if>
		</div>
	</div>

	<div class="container mt-3 mb-5">
		<h4>상품정보</h4>
		${product.pinfo}
	</div>
	<hr>
	<sec:authorize access="isAuthenticated()">
		<input type="hidden" id="prin" name="prin"
			value="<sec:authentication property="principal.username"/>" />
	</sec:authorize>
	<sec:authorize access="isAnonymous()">
		<input type="hidden" id="prin" name="prin" value="null" />
	</sec:authorize>
	<input type="hidden" id=p_name name="p_name" value="${product.pname}" />
	<input type="hidden" id="p_info" name="p_info" value="${product.pinfo}" />
	<input type="hidden" id="p_price" name="p_price"
		value="${product.price}" /> <input type="hidden" id="p_img"
		name="p_img" value="${product.filename}" />

	<sec:authorize access="isAuthenticated()">
		<input type="hidden" id="username" value="${pinfo.member.username }">
	</sec:authorize>




	<div align="center">
		<form class="mb-3" name="myform" id="myform" method="post">
			<fieldset>
				<span class="text-bold">별점을 선택해주세요</span> <input type="radio"
					class="rating" name="rating" value="5" id="rate1"><label
					for="rate1">★</label> <input type="radio" class="rating"
					name="rating" value="4" id="rate2"><label for="rate2">★</label>
				<input type="radio" class="rating" name="rating" value="3"
					id="rate3"><label for="rate3">★</label> <input type="radio"
					class="rating" name="rating" value="2" id="rate4"><label
					for="rate4">★</label> <input type="radio" class="rating"
					name="rating" value="1" id="rate5"><label for="rate5">★</label>
			</fieldset>
			<br>

			<textarea rows="3" cols="50" id="msg" name="msg"></textarea>
			<br>
			<button type="button" class="btn btn-secondary" id="btnComment"
				name="btnComment">리뷰쓰기</button>
	</div>

	</form>


	<div id="replyResult"></div>
</div>


<script>



var init = function(){
	$.ajax({
		type:'get',
		url:'/reply/list/'+$("#productid").val(),
	
	})
	.done(function(resp){
		var str="<table class='table mt-3'>";
		
		str +="<tr>"
		str +="<td class='text-center' width='100'>아이디</td>"
		str +="<td class='text-center' width='300'>내용</td>"
		str +="<td class='text-center' width='150'>작성일</td>"
		str +="<td class='text-center' width='70'>별점</td>"
		str +="<td class='text-center' width='70'>삭제</td>"
		
		$.each(resp,function(key,val){
			str +="<tr>"
			str += "<td class='text-center'>"+val.member.username+"</td>"
			str += "<td class='text-center'>"+val.content+"</td>"
			str += "<td class='text-center'>"+val.regdate+"</td>"
			str += "<td class='text-center'>"+val.rating+"점</td>"
			if($("#prin").val()==val.member.username){
			str += "<td class='text-center'><a href='javascript:fdel("+val.reviewnum+")'>삭제</a></td></tr>"
			}
			str += "<br/> "
		}) //each
		str +="</table>"
		$("#replyResult").html(str)
	})//done	
	.fail(function(e){
		alert("실패")
	})//fail
}

$("#btnComment").click(function(){
	if(${empty pinfo.member}){
		alert("로그인하세요")
		location.href="/login"
		return;
	}
	if($("input:radio[name=rating]:checked").length==0){
		alert("별점을 선택하세요")
		return;
	}
	if($("#msg").val()==""){
		alert("내용을 입력하세요")
		return;
	}
	var data={
			"product_id" : $("#productid").val(),
			"content" : $("#msg").val(),	
			"rating" : $("input:radio[name=rating]:checked").val()	
			
	}
	$.ajax({ 
		type:"post",
		url:'/reply/insert/'+$("#productid").val(),
		contentType:'application/json;charset=utf-8',
		data:JSON.stringify(data)	
	}) //ajax
	.done(function(resp,status){
		alert("리뷰가 추가되었습니다.")
		init();
	})
	.fail(function(e){
			alert("리뷰 추가 실패:"+e)
		})//fail	
})//comment

//리뷰삭제
function fdel(reviewnum){
	$.ajax({
		type:"delete",
		url:'/reply/delete/'+reviewnum
	}) //ajax
	.done(function(resp){
		alert(resp+"번 글 삭제 완료")
		init()
	})
	.fail(function(e){
		alert("리뷰 삭제 실패:" + e)
	})
} //fdel

$("#addCart_btn").click(function(){
	if(${empty pinfo.member}){
		alert("로그인하세요");
		location.href="/login";
		return;
	}
	var productid = $("#productid").val();
	var username = $("#username").val();
	var amount = $(".numBox").val();
	var p_name = $("#p_name").val();
	var p_info = $("#p_info").val();
	var p_price = $("#p_price").val();
	var p_img = $("#p_img").val();

	var data = {
			productid : productid,
			username : username,
			amount : amount,
			p_name : p_name,
			p_info : p_info,
			p_price : p_price,
			p_img : p_img
			};
	
	$.ajax({
		url : "/shop/addCart",
		type : "post",
		data : data,
		success : function(resp){
			if(resp == "success") {
				alert("카트에 추가되었습니다")
				$(".numBox").val("1")
				location.href="/shop/cart/${pinfo.member.username }"
			}
		},
		error : function(){
			alert("카트 담기 실패")
		}
	});
});
$(".plus").click(function(){
		   var num = $(".numBox").val();
		   var plusNum = Number(num) + 1;
		   
		   if(plusNum >= ${product.pstock}) {
		    $(".numBox").val(num);
		   } else {
		    $(".numBox").val(plusNum);          
		   }
		  });
		  
		  $(".minus").click(function(){
		   var num = $(".numBox").val();
		   var minusNum = Number(num) - 1;
		   
		   if(minusNum <= 0) {
		    $(".numBox").val(num);
		   } else {
		    $(".numBox").val(minusNum);          
		   }
	});
		  
		  init()	
</script>
<%@ include file="../includes/footer.jsp"%>