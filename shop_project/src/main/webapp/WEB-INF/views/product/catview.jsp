<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ include file="../includes/header.jsp"%>


<div align="center">
<h3>${catlist.catname } 의 상세보기</h3>
</div>
<input type="hidden"  name="catnum" id="catnum" value=${catlist.catnum } > 
<div class="container" >

	<table class="table table-hover">
		<tr>
			<th>카테고리번호</th>
			<td><input type="text" name="catnum" id="catnum" value="${catlist.catnum }"readonly> </td>
		</tr>
		<tr>
			<th>카테고리이름</th>
			<td><input type="text" name="catname" id="catname" value="${catlist.catname }"readonly> </td>
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
			location.href="/catupdate/${catlist.catnum}"
		}
		
		
	})
	
	
	
	$("#btnDelete").click(function(){
		if (confirm("정말 삭제할까요")==false)return false;

		$.ajax({
			type:"delete",
			url:"/catdelete/${catlist.catnum}",
			success:function(resp){
				alert(resp+"번 글 삭제성공")
				location.href="/catlist"
			},
			error:function(e){
				alert("삭제실패"+e)
			}
		})//ajax		
		
		
	})//btndelete
	
	
	</script>
	
	<%@ include file="../includes/footer.jsp"%>