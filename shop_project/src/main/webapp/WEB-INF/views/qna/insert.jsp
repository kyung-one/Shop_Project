<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%@ include file="../includes/header.jsp"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<br><br>
<div class="container mt-3">
<input type="hidden" name="productid" id="productid" value="${productid}" > 


<div class="w3-content w3-container w3-margin-top">
<button type="button" class="btn btn-info"  onclick="location.href='/qlist/${productid}' ">목록</button><br><br>

		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>상품 문의하기</h3><br>
			</div>
			<div>
				
					<label for="title">제목</label> 
					<input class="w3-input w3-border w3-round" id="title" name="title" type="text" required>
					<br />
			
					<label for="content">내용</label> 
					<textarea class="w3-input w3-border w3-round" id="content" name="content" rows="10" style="resize: vertical;" required></textarea>
					<p class="w3-center">
						<button type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" id=btnInsert>확인</button>
						<button type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round" onclick="history.go(-1)">취소</button>
					</p>
					
				
				
			</div>
		</div>
	</div>
	
	
	</div>
	
	<br><br><br><br><br>
	
<script>



$("#btnInsert").click(function(){
	
	
	
	if($("#title").val()==""){
		alert("제목입력하세요")
		return;
	}
	
	if($("#content").val()==""){
		alert("내용입력하세요")
		return;
	}
	
	
	var data={
			"product_id" : $("#productid").val(),
			"title" : $("#title").val(),
			"content" : $("#content").val()
			
	}
	$.ajax({ 
		type:"post",
		url:'/qinsert/'+$("#productid").val(),
		contentType:'application/json;charset=utf-8',
		data:JSON.stringify(data)	
	}) //ajax
	.done(function(resp,status){
		alert(status)
		alert(" 추가 성공")
		
	})
	.fail(function(e){
			alert(" 추가 실패:"+e)
		})//fail	
})//
	</script>
	
	
<%@ include file="../includes/footer.jsp"%>