<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>


<div class="container mt-3">
<button type="button" class="btn btn-info"  onclick="location.href='/catlist' ">카테고리리스트</button>
	<h3>카테고리 등록</h3>
	<form action="catinsert" method="post">

		<div class="form-group">
			<label for="catname">카테고리이름</label> <input type="text"
				class="form-control" id="catname" name="catname">
		</div>
		<button type="submit" class="btn btn-primary">카테고리 작성</button>
	</form>
</div>


<%@ include file="../includes/footer.jsp"%>