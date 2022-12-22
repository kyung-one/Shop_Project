<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<div class="container mt-3">
	<h3>회원관리</h3>
	<table class="table table-hover">
		<thead>
			<tr>
				<th class="text-center align-middle" width="100">회원번호</th>
				<th class="text-center align-middle" width="100">이름</th>
				<th class="text-center align-middle" width="150">아이디</th>
				<th class="text-center align-middle" width="150">전화번호</th>
				<th class="text-center align-middle" width="100">회원권한</th>
				<th class="text-center align-middle" width="150">상세보기</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${members }" var="members">
				<tr>
					<td class="text-center align-middle">${members.id }</td>
					<td class="text-center align-middle">${members.name }</td>
					<td class="text-center align-middle">${members.username }</td>
					<td class="text-center align-middle">${members.phone }</td>
					<td class="text-center align-middle">${members.role }</td>
					<td class="text-center align-middle">
					<a href="/admin/memberdetail/${members.id }"><button class="btn btn-outline-secondary btn-sm">
					상세보기</button></a></td>
	
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<%@ include file="../includes/footer.jsp"%>