<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>게시글</title>

<script src="https://code.jquery.com/jquery-2.1.4.js"></script>
<script>
$(function(){
    $('#delete').on('click', check);
})
function check() {
    alert('게시글이 삭제됩니다'); 
}
</script>
</head>
<body>
<br/>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>게시판 글 읽기</h3>
			</div>
			<div>
				<form role="form" method="post">
				<input type="hidden" name="bNum" value="${board.bNum}">
					<label for="title">
					<c:if test="${read.bDept==0}">[총괄]</c:if>
					<c:if test="${read.bDept==1}">[인사]</c:if>
					<c:if test="${read.bDept==2}">[재무]</c:if>
					<c:if test="${read.bDept==3}">[개발]</c:if>
					-
					<c:if test="${read.bKind==0}">전체공지</c:if>
					<c:if test="${read.bKind==1}">부서공지</c:if>
					<c:if test="${read.bKind==2}">일반글</c:if>
					
					</label>
					<output class="w3-input w3-border w3-round w3-light-grey" id="title" name="bTitle" type="text">${read.bTitle}</output>
					<br />
					<label for="content">
					작성자:
					${read.bRegname} | ${read.bRegdate}
					<c:if test="${read.bModuser!=NULL}">(수정자:${read.bModname} | ${read.bModdate})</c:if>
					</label>
					<textarea readonly class="w3-input w3-border w3-round w3-light-grey" id="content" name="bContent" rows="10" style="resize: vertical;">${read.bContent}</textarea>
					
					<p class="w3-center">
					<c:set var="uClass" value="<%=Integer.parseInt(meb.getuClass())%>"></c:set>
					<c:set var="uDept" value="<%=Integer.parseInt(meb.getuDept())%>"></c:set>
					<c:set var="uNum" value="<%=meb.getuNum()%>"></c:set>
					<c:if test="${(uClass == 2 && uNum==read.bReguser) || 
					(uClass == 1 && uDept==read.bDept) || uClass==0}">
						<input type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" 
						value="수정" onclick="location.href='./boardModForm.do?bNum=${read.bNum}'"/>
						<input type="button" id="delete" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round"
						value="삭제" onclick="location.href='./board_delete.do?bNum=${read.bNum}'"/>
					</c:if>
						<button type="button"
							class="w3-button w3-block w3-gray w3-ripple w3-margin-top w3-margin-bottom w3-round"
							onclick="history.go(-1)">목록</button>
					</p>
				</form>
			</div>
		</div>
	</div>
</body>
</html>