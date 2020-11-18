<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../common/header.jsp"%>
<html>
	<head>
	 	<title>게시판</title>
	 	
	 
	</head>
	<body>
	
	<table>
<nav class="navbar navbar-expand-lg navbar-light bg-light rounded">
    <a class="navbar-brand" href="#">전체글</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample09" aria-controls="navbarsExample09" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarsExample09">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="#">총괄 <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">인사</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">재무</a>
        </li>
        <li class="nav-item">
          <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">개발</a>
        </li>
      </ul>
    </div>
  </nav>
	</table>
	
	
	
	<table width="500" align="center">
		<tr>
			<td align="right" style="font-family: Gulim; font-size: 12px;">총&nbsp;${count}건
				${currentPage}페이지</td>
			 </tr>
	</table>
	
	
	
	<section id="container">
	<form role="form" method="post" action="../board/board_write.do">
	<table width="850" border="1" cellpadding="0" cellspacing="0"
		align="left">
		
		<tr>
			<th style="font-family: Gulim; font-size: 12px;">번호</th>
			<th style="font-family: Gulim; font-size: 12px;">제목</th>
			<th style="font-family: Gulim; font-size: 12px;">부서</th>
			<th style="font-family: Gulim; font-size: 12px;">작성자</th>
			<th style="font-family: Gulim; font-size: 12px;">작성일</th>
		</tr>
		
		<c:forEach items="${list}" var = "board">
			<tr>
				<td width="15">${board.bNum}</td>
				<td width="280" style="font-family: Gulim; font-size: 12px;"><a href="board_read.do?bNum=${board.bNum}">${board.bTitle}</a></td>
				<td width="60" style="font-family: Gulim; font-size: 12px;">${board.bDept}</td>
				<td width="60" style="font-family: Gulim; font-size: 12px;">${board.bReguser}</td>
				<td width="80" style="font-family: Gulim; font-size: 12px;">${board.bRegdate}</td>
			</tr>
		</c:forEach>
	</table>
	</form>
	</section>

	<br><br>
	<br><br>
	
	<form action="boardlist.do" name="search" method="post"
		onsubmit="return seachCheck()">
		<table width="500" align="center">
			<tr>
				<td align="center" width="90%"><select name="keyField">
						<option value="all">전체</option>
						<option value="uName">제목</option>
						<option value="uId">작성자</option>

				</select> <input type="text" size="15" name="keyWord"> <input
					type="submit" value="검색"
					style="font-family: Gulim; font-size: 12px;"> <A
					href='boardlist.do'> <input type="button" value="초기화"
						style="font-family: Gulim; font-size: 12px;">
				</A></td>

			</tr>
		</table>
	</form>
	</body>
</html>