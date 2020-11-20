<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
    $('#update').on('click', check);
})
function check() {
    
        if ($('#title').val().trim() == '') {
        	alert('제목을 입력해주세요');
            $('#title').focus();
        }
        else if ($('#content').val().trim() == ''){
        	alert('내용을 입력해주세요');
            $('#content').focus();
        }
        else {
        	alert('게시글이 수정됩니다');
        }
    
}
</script>
</head>
<body>
<br/>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>게시판 글 수정</h3>
			</div>
			<div>
			<input type="hidden" name="bNum" value="${read.bNum}">
				<form action="board_update.do" method="post" >
				<c:set var="uClass" value="<%=Integer.parseInt(meb.getuClass())%>"></c:set>
					<select name="bKind">
						<option value="2" selected>일반 게시글</option>
						<c:if test="${uClass < 2}">
							<option value="1">부서 공지글</option>
						</c:if>
						<c:if test="${uClass < 1}">
							<option value="0">전체 공지글</option>
						</c:if>
					</select>
					<input type="text" id="title" class="w3-input w3-border w3-round" id="title" name="bTitle" value="${update.bTitle}" required/>
					<br />
					<label for="content"><%=meb.getuName()%> 님이 수정중입니다..</label>
					<textarea class="w3-input w3-border w3-round" id="content" name="bContent" rows="10" style="resize: vertical;" required>${update.bContent}</textarea>
					<input type="hidden" name="bNum" value="${update.bNum}">
					<input type="hidden" name="bModuser" value=<%=meb.getuNum()%>>
					<input type="hidden" name="bModname" value=<%=meb.getuName()%>>
					<p class="w3-center">
						<button type="submit" id="update" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round">확인</button>
						<button type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round" onclick="history.go(-1)">취소</button>
					</p>
				</form>
			</div>
		</div>
	</div>
</body>
</html>