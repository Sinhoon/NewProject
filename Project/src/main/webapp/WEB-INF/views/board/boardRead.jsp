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
</head>
<body>
	<div class="w3-content w3-container w3-margin-top">
		<div class="w3-container w3-card-4">
			<div class="w3-center w3-large w3-margin-top">
				<h3>게시판 글 읽기</h3>
			</div>
			<div>
				<form role="form" method="post">
				<input type="hidden" name="bNum" value="${board.bNum}">
					<label for="title">제목</label>
					<output class="w3-input w3-border w3-round w3-light-grey" id="title" name="bTitle" type="text">${read.bTitle}</output>
					<br />
					<label for="content">내용</label>
					<textarea readonly class="w3-input w3-border w3-round w3-light-grey" id="content" name="bContent" rows="10" style="resize: vertical;">${read.bContent}</textarea>
					
					<p class="w3-center">
						<input type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round" 
						value="수정" onclick="location.href='./boardModForm.do?bNum=${read.bNum}'"/>
						<input type="button" class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-margin-bottom w3-round"
						value="삭제" onclick="location.href='./board_delete.do?bNum=${read.bNum}'"/>
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