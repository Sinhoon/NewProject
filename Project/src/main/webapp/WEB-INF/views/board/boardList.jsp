<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../common/header.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.3/css/all.css"
	integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://unpkg.com/bootstrap-table@1.18.0/dist/themes/semantic/bootstrap-table-semantic.min.css">
</head>
<body>

	<table>
		<nav class="navbar navbar-expand-lg navbar-light bg-light rounded">
			<a class="navbar-brand" href="boardList?keyDept=0"> 전체글 </a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarsExample09" aria-controls="navbarsExample09"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarsExample09">
				<ul class="navbar-nav mr-auto">

					<li class="nav-item"><a class="nav-link"
						href="boardList?keyDept=1"><c:if test="${keyDeptSave==1}">
								<b>
							</c:if>인사</b> </a></li>
					<li class="nav-item"><a class="nav-link"
						href="boardList?keyDept=2"><c:if test="${keyDeptSave==2}">
								<b>
							</c:if>재무</b> </a></li>
					<li class="nav-item"><a class="nav-link"
						href="boardList?keyDept=3"><c:if test="${keyDeptSave==3}">
								<b>
							</c:if>개발</b> </a></li>
				</ul>
			</div>
		</nav>
	</table>



	<table width="500" align="center">
		<tr>
			<td align="right" style=";position: relative; bottom: -10px; right: -350px;">총&nbsp;${count}건
				${currentPage}페이지</td>
		</tr>
	</table>



	<section id="container">
		<table data-toggle="table">
			<thead>
				<tr>
					<th style="font-family: Gulim; font-size: 12px;">번호</th>
					<th style="font-family: Gulim; font-size: 12px;">제목</th>
					<th style="font-family: Gulim; font-size: 12px;">부서</th>
					<th style="font-family: Gulim; font-size: 12px;">작성자</th>
					<th style="font-family: Gulim; font-size: 12px;">작성일</th>
				</tr>
			</thead>
			<c:forEach items="${notice}" var="board">
				<tr style="background-color:#F8ECE0">
					<td width="15"><strong style="color:red">공지</strong></td>
					<td width="280" style="font-family: Gulim; font-size: 12px;"><a
						href="board_read.do?bNum=${board.bNum}"><strong style="color:red">${board.bTitle}</strong></a></td>
					<td width="60" style="font-family: Gulim; font-size: 12px;"><c:if
							test="${board.bDept==0}">전체</c:if> <c:if test="${board.bDept==1}">인사</c:if>
						<c:if test="${board.bDept==2}">재무</c:if> <c:if
							test="${board.bDept==3}">개발</c:if></td>
					<td width="60" style="font-family: Gulim; font-size: 12px;">${board.bRegname}</td>
					<td width="80" style="font-family: Gulim; font-size: 12px;">${board.bRegdate}</td>
				</tr>
			</c:forEach>

			<c:forEach items="${list}" var="board">
				<tr>
					<td width="15">${board.bNum}</td>
					<td width="280" style="font-family: Gulim; font-size: 12px;"><a
						href="board_read.do?bNum=${board.bNum}">${board.bTitle}</a></td>
					<td width="60" style="font-family: Gulim; font-size: 12px;"><c:if
							test="${board.bDept==0}">전체</c:if> <c:if test="${board.bDept==1}">인사</c:if>
						<c:if test="${board.bDept==2}">재무</c:if> <c:if
							test="${board.bDept==3}">개발</c:if></td>
					<td width="60" style="font-family: Gulim; font-size: 12px;">${board.bRegname}</td>
					<td width="80" style="font-family: Gulim; font-size: 12px;">${board.bRegdate}</td>
				</tr>
			</c:forEach>
		</table>
		</form>
	</section>

	<br>
	<br>

	<!-- 페이징 -->

	<input type="button" value="글쓰기" class="ui black deny button"
		onclick="location.href='./boardRegForm.do'"
		style="position: relative; bottom: 15px; left: 1300px;">

	<div class="ui pagination menu"
		style="position: relative; bottom: 15px; right: -550px;">
		<c:if test="${count>0}">
			<tr>
				<c:if test="${currentPage > 1}">
					<a class="page-item item"
						href='${pageContext.request.contextPath}/memberlist?pageNum=1'>처음</a>
				</c:if>

				<c:if test="${currentPage > 10}">
					<a class="page-item item"
						href='${pageContext.request.contextPath}/memberlist?pageNum=${currentPage-10 }'></a>
				</c:if>

				${pagingHtml}
				<!-- 글목록 밑에 1,2,3 이렇게 뜨는거 -->


				<c:if test="${currentPage > 10}">
					<a class="page-item item"
						href='${pageContext.request.contextPath}/memberlist?pageNum=${currentPage+10 }'>
						> </a>
				</c:if>

				<c:if test="${currentPage < end}">
					<a class="page-item item"
						href='${pageContext.request.contextPath}/memberlist?pageNum=${end}'>끝</a>
				</c:if>
		</c:if>

	</div>


	<br>
	<br>

	<form action="boardList" name="search" method="post"
		onsubmit="return seachCheck()">
		<table width="500" align="center">
			<tr>
				<td align="center" width="90%"><select name="keyField"
					style="height: 30px; width: 70px; position: relative; bottom: 20px; right: 40px;">
						<option value="all">전체</option>
						<option value="bTitle">제목</option>
						<option value="bReguser">작성자</option>

				</select> <input type="text" size="30" name="keyWord"
					style="height: 30px; position: relative; bottom: 20px; right: 40px;">
					<input type="submit" value="검색"
					style="font-family: Gulim; font-size: 12px; height: 30px; width: 70px;; position: relative; bottom: 20px; right: 40px;">
					<A href='boardList'> <input type="button" value="초기화"
						style="font-family: Gulim; font-size: 12px; height: 30px; width: 70px;; position: relative; bottom: 20px; right: 40px;">
				</A> <input type="hidden" name="keyDept" value="${keyDeptSave}" /></td>

			</tr>
		</table>
	</form>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"
		integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg=="
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.js"></script>
	<script
		src="https://unpkg.com/bootstrap-table@1.18.0/dist/bootstrap-table.min.js"></script>
	<script
		src="https://unpkg.com/bootstrap-table@1.18.0/dist/themes/semantic/bootstrap-table-semantic.min.js"></script>
</body>
</html>