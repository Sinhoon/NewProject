<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.study.web.vo.Member"%>
<%@ page session="true"%>

<!DOCTYPE html>
<html>
<head>
<title>상단 영역</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<%
	Member meb = new Member();
if (session.getAttribute("Member") != null) {
	meb = (Member) session.getAttribute("Member"); // 세션안에 멤버 
} else { // meb.getClass(); 0이면 총괄
%>
<script>
	window.location = "${pageContext.request.contextPath}/login";
</script>
<%
	}
%>


<script type="text/javascript">
	function expireSession() {
		window.location = "${pageContext.request.contextPath}/login";
	}
	setTimeout('expireSession()',
<%=request.getSession().getMaxInactiveInterval() * 2000%>
	// 세션유지시간
	);
	function changeView(value) {
		if (value == "0") {
			location.href = "${pageContext.request.contextPath}/home";
		} else if (value == "1") {
			location.href = "${pageContext.request.contextPath}/boardList";
		} else if (value == "2") {
			location.href = "${pageContext.request.contextPath}/memberlist";
		} else if (value == "3") {
			location.href = "${pageContext.request.contextPath}/logout";
		}
	}
</script>

</head>
<body>
	<!--  메뉴바 -->
	<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
		<a class="navbar-brand" href="#" onclick="changeView(0)">Home</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarsExample03" aria-controls="navbarsExample03"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarsExample03">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link"
					onclick="changeView(1)">게시판</a></li>
				<li class="nav-item"><a class="nav-link"
					onclick="changeView(2)">회원관리</a></li>
				<li class="nav-item"><a class="nav-link"
					onclick="changeView(3)">로그아웃</a></li>
			</ul>
		</div>
		<h7 style="color:white"> <%=meb.getuName()%> 님 안녕하세요 </h7>
	</nav>


</body>
</html>