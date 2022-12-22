<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>





<div class="container mt-3">
	<h3>공지사항 등록</h3>
	<form action="noticeinsert" method="post">

		<div class="form-group">
			<label for="title">제목</label> <input type="text"
				class="form-control" id="title" name="title">
		</div>



		<div class="form-group">
			<label for="writer">작성자</label> <input type="text"
				class="form-control" id="member_id" placeholder="Enter member_id"
				name="member_id" value="${pinfo.member.username }"
				readonly="readonly">
		</div>



		<div class="form-group">
			<label for="content">내용</label>
			<textarea class="form-control" rows="5" id="content" name="content"></textarea>
			<br>

			<button type="submit" class="btn btn-primary">등록	</button>
		</div>
	</form>
</div>
<%@ include file="../includes/footer.jsp"%>