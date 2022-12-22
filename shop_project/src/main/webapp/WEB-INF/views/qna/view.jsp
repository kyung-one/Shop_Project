<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<div class="container">
	<h3>${qlist.member.id }의QNA보기</h3>
	<div class="form-group">
		<label for="qnanum">글번호:</label> <input type="text" class="form-control"
			id="qnanum" name="qnanum" value="${qlist.qnanum }" readonly="readonly">
	</div>
	<div class="form-group">
		<label for="title">제목:</label> <input type="text" class="form-control"
			id="title" name="title" value="${qlist.title }" readonly="readonly">
	</div>
	
	<div class="form-group">
		<label for="member_id">작성유저id:</label> <input type="text" class="form-control"
			id="member_id" name="member_id" value="${qlist.member.id }" readonly="readonly">
	</div>


	<div class="form-group">
		<label for="content">내용</label>
		<textarea class="form-control" rows="5" id="content" name="content"
			readonly="readonly">${qlist.content }</textarea>
	</div>
	
	
	 <sec:authorize access="isAuthenticated()">
		 
		 <c:if test="${pinfo.member.id == qlist.member.id}">
	
			<div class="form-group text-right">
				<button type="button" class="btn btn-secondary btn-sm"
					id="btnQnaUpdate">수정</button>
				<button type="button" class="btn btn-danger btn-sm" id="btnQnaDelete">삭제</button>
			
			</div>
		</c:if>
 		 </sec:authorize>
	
	
		<div align="center">
		<textarea rows="3" cols="50" id="msg"></textarea>
		<button type="button" class="btn btn-secondary btn-sm" id="btnQnaComment">댓글쓰기</button>
	</div>
	
	
	<div id="replyResult"></div>

 
</div>


<script>


	var init = function(){
		$.ajax({
			type:'get',
			url:'/qnareply/qlist/'+$("#qnanum").val(),
		
		})
		.done(function(resp){
			var str="<table class='table table-hover mt-3'>";
			$.each(resp,function(key,val){
				str +="<tr>"
				str += "<td>"+val.member.id+"</td>"
				str += "<td>"+val.content+"</td>"
				str += "<td>"+val.regdate+"</td>"
				if("${pinfo.member.id}"==val.member.id){
					str += "<td><a href='javascript:fdel("+val.cnum+")'>삭제</a></td></tr><br>"
				}
			}) //each
			str +="</table>"
			$("#replyResult").html(str)
		})//done	
		.fail(function(e){
			alert("실패")
		})//fail
	}
	
	//댓글삭제
	function fdel(cnum) {
		alert(cnum)
		$.ajax({
			type : "DELETE",
			url : '/qnareply/qdelete/' + cnum
		}) //ajax
		.done(function(resp) {
			alert(resp + "번 글 삭제 완료")
			init()
		}).fail(function(e) {
			alert("댓글 삭제 실패 : " + e)
		})
	} //fdel
	
	
	

	$("#btnQnaComment").click(function(){
		
		if(${empty pinfo.member}){
			alert("로그인하세요")
			location.href="/login"
			return;
		}
		
		if($("#msg").val()==""){
			alert("댓글입력하세요")
			return;
		}
		
		
		
		var data={
				"qnanum" : $("#qnanum").val(),
				"content" : $("#msg").val()	
		}
		$.ajax({ 
			type:"post",
			url:'/qnareply/qinsert/'+$("#qnanum").val(),
			contentType:'application/json;charset=utf-8',
			data:JSON.stringify(data)	
		}) //ajax
		.done(function(resp,status){
			alert(status)
			alert("댓글 추가 성공")
			init();
		})
		.fail(function(e){
				alert("댓글 추가 실패:"+e)
			})//fail	
	})//comment
	
	
	
	
	
	
	
	
	
	
	
	$("#btnQnaUpdate").click(function(){
		if (confirm("정말 수정할까요")){
			location.href="/qnaupdate/${qlist.qnanum}"
		}
		
		
	})
	
	
	
	$("#btnQnaDelete").click(function(){
		if (confirm("정말 삭제할까요")==false)return false;

		$.ajax({
			type:"delete",
			url:"/qnadelete/${qlist.qnanum}",
			success:function(resp){
				alert(resp+"번 글 삭제성공")
				location.href="/product/plist"
			},
			error:function(e){
				alert("삭제실패"+e)
			}
		})//ajax		
		
		
	})//btndelete
	
	init()
	</script>
	<%@ include file="../includes/footer.jsp"%>