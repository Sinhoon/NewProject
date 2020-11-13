<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.study.web.vo.Member"%>
<%@ page session="true"%>

<!DOCTYPE html>
<html>
<head>
<title>상단 영역</title>

<style type="text/css">
#wrap {
	text-align: center;
	width: 800px;
	height: 150px;
}
</style>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<%
	Member meb = new Member();
	if (session.getAttribute("Member") != null) {
		meb = (Member) session.getAttribute("Member");
	} else {
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
<%=request.getSession().getMaxInactiveInterval() * 200%>
	);

	function changeView(value) {

		if (value == "0") {
			location.href = "${pageContext.request.contextPath}/home";
		} else if (value == "1") {
			location.href = "${pageContext.request.contextPath}/board";
		} else if (value == "2") {
			location.href = "${pageContext.request.contextPath}/member";
		} else if (value == "3") {
			location.href = "${pageContext.request.contextPath}/logout";
		}
	}
</script>

</head>
<body>
	<!--  메뉴바 -->
	<div id="wrap">
		<p>
			<button class="btn btn-success" onclick="changeView(0)">HOME</button>
			<button id="updateBtn" class="btn btn-primary"
				onclick="changeView(1)">게시판</button>
			<button id="memberViewBtn" class="btn btn-warning"
				onclick="changeView(2)">회원관리</button>
			<button id="logoutBtn" class="btn btn-primary"
				onclick="changeView(3)">로그아웃</button>
		<h5>
			<%=meb.getname()%>
			님 안녕하세요
		</h5>

		</p>
	</div>

</body>
</html>

