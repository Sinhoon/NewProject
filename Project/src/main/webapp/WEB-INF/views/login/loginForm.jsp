<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>

<head>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<title>4조 프로젝트</title>
</head>

<body>
<br />
	<div class="w3-content w3-container w3-margin-top">
	<br />
		<div class="w3-container w3-card-4">
		<br />
			<div class="w3-center w3-large w3-margin-top">
				<h3>Log In</h3>
			</div>
			<br />
			<div>
				<form method="post">
					<!-- 가상 URL 맵핑 해주어야 합니다. -->
					<p><label>아이디</label> <input class="w3-input" id="id" /> </p> 
					<br />
					<p><label>비밀번호</label> <input class="w3-input" type="password" id="pwd"></p>
				</form>
				<br />
				<p class="w3-center">
				<button id="login_btn" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">로그인</button>
				</p>
				<br />
			</div>
		</div>
	</div>
	<br />
	<br />
</body>
<script>
	$(document).ready(function() {
		$("#login_btn").on('click', function() {
			loginChk();
		});
	});
	function loginChk() {
		$
				.ajax({
					url : "${pageContext.request.contextPath}/loginPro.do",
					type : "POST",
					async : false,
					data : {
						id : $("#id").val(),
						pwd : $("#pwd").val()
					},
					success : function(data) {
						if (data.Code == "0000") {
							window.location.href = "${pageContext.request.contextPath}/home";
						} else if (data.Code == "0001") {
							alert("없는 아이디입니다");
						} else if (data.Code == "0002") {
							alert("잠긴 아이디입니다");
						} else {
							alert("비밀번호를 다시 확인해주세요");
						}
					},
					error : function() {
						alert("err");
					}
				});
	}
</script>
<%@include file="../common/footer.jsp"%>