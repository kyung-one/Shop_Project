<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<div align="center">
	<h3>${catlist.catnum }의 카테고리 수정하기</h3>
</div>

<input type="hidden" name="catnum" id="catnum" value=${catlist.catnum }>
<div class="container">
	<table class="table table-hover">
		<tr>
			<th>카테고리번호</th>
			<td><input type="text" name="catnum" id="catnum"
				value="${catlist.catnum }" readonly></td>
		</tr>
		<tr>
			<th>카테고리이름</th>
			<td><input type="text" name="catname" id="catname"
				value="${catlist.catname}"></td>
		</tr>
	</table>
	<button type="button" class="btn btn-info" value="수정" name="수정"
		id="catbtnModify">수정하기</button>
</div>
<script>
	$("#catbtnModify").click(function() {
		// # --> id 있어야함 주의          i # ,  . c
		data = {
			"catnum" : $("#catnum").val(),
			"catname" : $("#catname").val(),
		}

		$.ajax({
			type : "put",
			url : "/product/catupdate",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(data),
			success : function(resp) {
				if (resp == "success") {
					alert("수정완료")
					location.href = "/catlist"
				}//if				
			},//success
			error : function(e) {
				alert("수정실패" + e)
			}
		}) //ajax
	})//btnmodify
</script>
<%@ include file="../includes/footer.jsp"%>