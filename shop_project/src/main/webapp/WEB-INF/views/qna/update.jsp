<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../includes/header.jsp"%>

<div align="center">
<h3>${qlist.member.id } 의 QNA 수정하기</h3>
</div>

<input type="hidden" name="qnanum" id="qnanum" value=${qlist.qnanum } > 
<input type="hidden" name="regdate" id="regdate" value=${qlist.regdate } > 
<div class="container" >

	<table class="table table-hover">
		<tr>
			<th>제목</th>
			<td><input type="text" name="title" id="title" value="${qlist.title}"> </td>
		</tr>
		
		
		
		
			<tr>
			<th>내용</th>
			<td><input type="text" name="content" id="content" value="${qlist.content}"></td>
		</tr>

		
			</table>
			
				<button type="button" class="btn btn-info" value="수정" name="수정" id="btnModify" >수정하기</button>
			
		
		</div>	
		
		<script>
		$("#btnModify").click(function(){
			// # --> id 있어야함 주의          i # ,  . c
			data ={
					"qnanum":$("#qnanum").val(),
					"title":$("#title").val(),
					"content":$("#content").val(),
					"regdate":$("#regdate").val()
			}
			
			$.ajax({
				type:"put",
				url:"/qnaupdate",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
					success:function(resp){
						if(resp=="success"){
							alert("수정완료")
							location.href="/product/plist"
						}//if				
					},//success
					error:function(e){
						alert("수정실패"+e)
					}
				}) //ajax
			})//btnmodify

</script>
<%@ include file="../includes/footer.jsp"%>