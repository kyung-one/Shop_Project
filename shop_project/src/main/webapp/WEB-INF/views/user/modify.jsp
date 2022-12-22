<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<div class="container mt-3">
	<input type="hidden" name="id" id="id" value="${pinfo.member.id }" />
	<h3>회원정보 수정</h3>
	<div class="form-group w-50">
		<label for="name">이름</label> <input type="text" class="form-control"
			id="name" name="name" value="${pinfo.member.name }"
			readonly="readonly">
	</div>
	<div class="form-group w-50">
		<label for="username">아이디</label> <input type="text"
			class="form-control" id="username" name="username"
			value="${pinfo.member.username }" readonly="readonly">
	</div>
	<span id="idCheck"></span>

	<div class="form-group w-50">
		<label for="pass">비밀번호</label> <input type="password"
			class="form-control" id="password" name="password">
	</div>

	<div class="form-group w-50">
		<label for="password_check">비밀번호 확인</label> <input type="password"
			class="form-control" id="password_check" name="password_check">
	</div>

	<div class="form-group w-50">
		<label for="email">이메일</label> <input type="text" class="form-control"
			id="email" name="email" value="${pinfo.member.email }">
	</div>
	<div class="form-row w-50">
		<div class="form-group col-md-3">
			<input type="text" class="form-control" id="zipcode" name="zipcode"
				value="${pinfo.member.zipcode }" readonly="readonly">
		</div>
		<div>
			<input type="button" class="btn btn-secondary"
				onclick="execDaumPostcode()" value="우편번호 찾기"><br>
		</div>
		<div class="form-group col-md-6">
			<input type="text" class="form-control" id="roadaddr" name="roadaddr"
				value="${pinfo.member.roadaddr }" readonly="readonly">
		</div>
	</div>
	<div class="form-row">
		<div class="form-group col-md-6">
			<input type="text" class="form-control" id="jibunaddr"
				name="jibunaddr" value="${pinfo.member.jibunaddr }"
				readonly="readonly">
		</div>
	</div>
	<div class="form-row">

		<span id="guide" style="color: #999; display: none;"></span>
		<div class="form-group col-md-6">
			<input type="text" class="form-control" id="extraaddr"
				name="extraaddr" value="${pinfo.member.extraaddr }">
		</div>
	</div>
	<div class="form-group w-50">
		<label for="phone">전화번호</label> <input type="text"
			class="form-control" id="phone" name="phone"
			value="${pinfo.member.phone }">
	</div>
	<button type="button" class="btn btn-info" id="btnModify">정보수정</button>
	<button type="button" class="btn btn-danger" id="btnDelAccount">회원탈퇴</button>
</div>
<script>
	$("#btnModify").click(function() {
		if ($("#username").val() == "") {
			alert("아이디를 입력하세요")
			$("#username").focus()
			return;
		}
		if ($("#name").val() == "") {
			alert("이름을 입력하세요")
			$("#username").focus()
			return;
		}
		if ($("#password").val() == "") {
			alert("비밀번호를 입력하세요")
			$("#password").focus()
			return;
		}
		if ($("#password").val() != $("#password_check").val()) {
			alert("비밀번호가 일치하지 않습니다")
			$("#password").focus()
			return;
		}
		if ($("#email").val() == "") {
			alert("이메일을 입력하세요")
			$("#email").focus()
			return;
		}
		if ($("#addr").val() == "") {
			alert("주소를 입력하세요")
			$("#addr").focus()
			return;
		}
		if ($("#zipcode").val() == "") {
			alert("우편번호를 입력하세요")
			$("#zipcode").focus()
			return;
		}
		data = {
			"id" : $("#id").val(),
			"name" : $("#name").val(),
			"username" : $("#username").val(),
			"password" : $("#password").val(),
			"email" : $("#email").val(),
			"roadaddr" : $("#roadaddr").val(),
			"jibunaddr" : $("#jibunaddr").val(),
			"extraaddr" : $("#extraaddr").val(),
			"zipcode" : $("#zipcode").val(),
			"phone" : $("#phone").val(),
		}
		$.ajax({
			type : "put",
			url : '/modify',
			contentType : 'application/json;charset=utf-8',
			data : JSON.stringify(data)
		}).done(function(resp) {
			if (resp == "success") {
				alert("수정완료")
				location.href = "/mypage/${pinfo.member.id }"
			}
		}).fail(function() {
			alert("실패")
		})
	})
	$("#btnDelAccount").click(function() {
		if (!confirm('탈퇴할까요?')) {// false
			return false;
		}
		$.ajax({
			type : "DELETE",
			url : "/deleteAcc/${pinfo.member.id }",
			success : function(resp) {
				if (resp == "success") {
					alert("성공");
					location.href = "/login"
				}
			},
			error : function(e) {
				alert("삭제 실패 : " + e)
			}
		}) //ajax
	}) //btnDelete
	function execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 참고 항목 변수

				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('zipcode').value = data.zonecode;
				document.getElementById("roadaddr").value = roadAddr;
				document.getElementById("jibunaddr").value = data.jibunAddress;

				// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
				if (roadAddr !== '') {
					document.getElementById("extraaddr").value = extraRoadAddr;
				} else {
					document.getElementById("extraaddr").value = '';
				}

				var guideTextBox = document.getElementById("guide");
				// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
				if (data.autoRoadAddress) {
					var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
					guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr
							+ ')';
					guideTextBox.style.display = 'none';

				} else if (data.autoJibunAddress) {
					var expJibunAddr = data.autoJibunAddress;
					guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr
							+ ')';
					guideTextBox.style.display = 'none';
				} else {
					guideTextBox.innerHTML = '';
					guideTextBox.style.display = 'none';
				}
			}
		}).open();
	}
</script>
<%@ include file="../includes/footer.jsp"%>