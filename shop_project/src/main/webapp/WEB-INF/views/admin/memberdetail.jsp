<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<style>
table{
font-size:14pt
}
</style>
<div class="container mt-3">
	<h3>회원관리</h3>
	<div class="row">
		<div class="col">
			<input type="hidden" id="id" value="${members.id}">

			<table class="table table-borderless">
				<tbody>
					<tr>
						<th scope="row">회원번호</th>
						<td>${members.id}</td>
					</tr>
					<tr>
						<th scope="row">이름</th>
						<td>${members.name}</td>
					</tr>
					<tr>
						<th scope="row">아이디</th>
						<td>${members.username}</td>
					</tr>
					<tr>
						<th scope="row">전화번호</th>
						<td>${members.phone}</td>
					</tr>
					<tr>
						<th scope="row">이메일</th>
						<td>${members.email}</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col">
			<table class="table table-borderless">
				<tbody>

					<tr>
						<th scope="row">우편번호</th>
						<td>${members.zipcode}</td>
					</tr>
					<tr>
						<th scope="row">도로명주소</th>
						<td>${members.roadaddr}</td>
					</tr>
					<tr>
						<th scope="row">지번주소</th>
						<td>${members.jibunaddr}</td>
					</tr>
					<tr>
						<th scope="row">상세주소</th>
						<td>${members.extraaddr}</td>
					</tr>
					<tr>
						<th scope="row">회원권한</th>
						<td>${members.role}</td>
					</tr>
					<tr>
						<th scope="row">권한변경</th>
						<td><select class="form-control" name="role" id="role">
								<option></option>
								<option value="ROLE_MEMBER">ROLE_MEMBER</option>
								<option value="ROLE_ADMIN">ROLE_ADMIN</option>
						</select></td>
					</tr>
					<tr>
						<th scope="row"><button type="button" class="btn btn-outline-secondary"id="memberUpdate">저장</button></th>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>

<script>
	$("#memberUpdate").click(function() {

		if (!confirm('수정할까요?')) {// false
			return false;
		}
		var data = {
			"id" : $("#id").val(),
			"role" : $("#role").val()
		}
		$.ajax({
			type : "put",
			url : '/admin/memberUpdate',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(data)
		}).done(function(resp) {
			if (resp == "success") {
				alert("수정완료")
				location.href = "/admin/members"
			}
		}).fail(function() {
			alert("실패")
		})
	})
// 	$("#memberDel").click(function() {
// 		if (!confirm('회원 삭제할까요?')) {// false
// 			return false;
// 		}
// 		$.ajax({
// 			type : "DELETE",
// 			url : "/deleteAcc/${pinfo.member.id }",
// 			success : function(resp) {
// 				if (resp == "success") {
// 					alert("성공");
// 					location.href = "/admin/members"
// 				}
// 			},
// 			error : function(e) {
// 				alert("삭제 실패 : " + e)
// 			}
// 		}) //ajax
// 	}) //btnDelete
<!-- </script> -->
<%@ include file="../includes/footer.jsp"%>