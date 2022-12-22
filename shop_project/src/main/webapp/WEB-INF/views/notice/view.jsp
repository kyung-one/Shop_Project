<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../includes/header.jsp"%>


<div align="center">
<h3>${list.member.username } 의 공지사항</h3>
</div>
<input type="hidden"  name="num" id="num" value=${list.noticenum } > 
<div class="container" >

	<table class="table table-hover">
		<tr>
			<th>제목</th>
			<td><input type="text" name="title" id="title" value="${list.title }"readonly> </td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><input type="text" name="member_id" id="member_id" value="${list.member.username }"readonly> </td>
		</tr>
			<tr>
			<th>내용</th>
			<td><input type="text" name="content" id="content" value="${list.content }"readonly></td>
		</tr>

		
			</table>
	<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
		 <button type="button" class="btn btn-info" value="수정" name="수정" id="btnUpdate" >수정하기</button>		
		<button type="button" class="btn btn-info" value="삭제" name="삭제" id="btnDelete">삭제</button>
		
	 </sec:authorize>
			<br>
			
	</div>	
	
	<script>
	
	$("#btnUpdate").click(function(){
		if (confirm("정말 수정할까요")){
			location.href="/update/${list.noticenum}"
		}
		
		
	})
	
	
	
	$("#btnDelete").click(function(){
		if (confirm("정말 삭제할까요")==false)return false;

		$.ajax({
			type:"delete",
			url:"/delete/${list.noticenum}",
			success:function(resp){
				alert(resp+"번 글 삭제성공")
				location.href="/noticelist"
			},
			error:function(e){
				alert("삭제실패"+e)
			}
		})//ajax		
		
		
	})//btndelete
	
	
	</script>
	
	<%@ include file="../includes/footer.jsp"%>