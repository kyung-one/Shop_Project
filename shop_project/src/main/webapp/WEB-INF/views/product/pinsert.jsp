<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<div class="container mt-3">
	<h3>상품등록</h3>
	<form action="pinsert" method="post" enctype="multipart/form-data">

		<div class="form-group">
			<label for="pname">제품명</label> <input type="text"
				class="form-control" id="pname" name="pname">
		</div>
		<div class="form-group">
			<select class="form-control" name="catnum" id="catnum">
				<option value="1">카테고리1</option>
				<option value="2">카테고리2</option>
				<option value="3">카테고리3</option>
				<option value="4">카테고리4</option>
			</select>
		</div>
		<div class="form-group">
			<label for="price">가격</label> <input type="text" class="form-control"
				id="price" name="price">
		</div>
		<div class="form-group">
			<label for="manufacturer">제조사</label> <input type="text"
				class="form-control" id="manufacturer" name="manufacturer">
		</div>
		<div class="form-group">
			<label for="pinfo">상품설명</label>
			<textarea class="form-control" rows="3" id="pinfo" name="pinfo"></textarea>
		</div>
		<div class="form-group">
			<label for="pstock">재고수량</label> <input type="text"
				class="form-control" id="pstock" name="pstock">
		</div>
		<div class="form-group">
			<label for="files">상품 이미지</label> <input type="file"
				class="form-control-file" id="files" name="files">
		</div>
		<div class="form-group">
			<button type="submit" class="btn btn-primary btn-sm">등록</button>
		</div>
	</form>
</div>
<%@ include file="../includes/footer.jsp"%>