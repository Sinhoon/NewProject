<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>글쓰기</title>
</head>
<body>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>게시판 글 작성</h3>
			</div>
			<div>
				<form action="board_write.do" method="post">
					<c:set var="uClass" value="<%=Integer.parseInt(meb.getuClass())%>"></c:set>
					<select name="bKind">
						<option value="2" selected>일반 게시글</option>
						<c:if test="${uClass < 2}">
							<option value="1">부서 공지글</option>
						</c:if>
						<c:if test="${uClass < 1}">
							<option value="0">전체 공지글</option>
						</c:if>
					</select> <input class="w3-input w3-border w3-round" id="title"
						name="bTitle" type="text" placeholder="제목을 입력해주세요.." required>
					<br />
					<textarea class="w3-input w3-border w3-round" id="content"
						name="bContent" rows="10" placeholder="내용을 입력해주세요.."
						style="resize: vertical;" required></textarea>
					<!--  input type="hidden" name="bKind" value=<%=meb.getuClass()%>-->
					<input type="hidden" name="bDept" value=<%=meb.getuDept()%>>
					<input type="hidden" name="bReguser" value=<%=meb.getuNum()%>>
					<input type="hidden" name="bFile" value="1">
					<p class="w3-center">
						<button type="submit"
							class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">확인</button>
						<button type="button"
							class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round"
							onclick="history.go(-1)">취소</button>
					</p>
				</form>
			</div>
		</div>
	</div>
</body>
</html>