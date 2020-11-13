<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>

<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
</head>

<body>
	<form method="post">
		<!-- 가상 URL 맵핑 해주어야 합니다. -->
		아이디 <input id="id" /> <br /> 비밀번호 <input type="password"
			id="pwd"> <br />
	</form>
	<button id="login_btn">로그인</button>
	<!-- 로그인 실패시 메세지 -->
	<!-- param.변수 => request.getParameter("변수")
	<span style="color: red;">${param.message}</span>
     -->
</body>
<script>
	$(document).ready(function() {
		$("#login_btn").on('click', function() {
			loginChk();
		});
	});
	function loginChk() {
		$.ajax({
			url : "${pageContext.request.contextPath}/loginPro.do",
			type : "POST",
			async: false, 
			data : {
				id : $("#id").val(),
				pwd : $("#pwd").val()
			},
			success : function(data) {
				if (data.Code == "0000") {
					window.location.href = "${pageContext.request.contextPath}/home";
				} else {
					alert("로그인실패");
				}
			},
			error : function() {
				alert("err");
			}
		});
	}
</script>
<%@include file="../common/footer.jsp"%>
