<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>

<title>회원 상세 정보</title>
</head>
<body>
	<Form name='member_update' method="get" action='${pageContext.request.contextPath}/member_update.do'>
		<input type="hidden" name="uNum" value="${member.uNum}">
		<!-- 이걸 안해주면 수정 컨트롤러가 글 번호를 못읽어와서 에러가 -->
		<table width="500" border="1" cellpadding="0" cellspacing="0"
			align="left">
			<tr>
				<td>사진</td>
				<td><img src=".img/lion.jpg"></td>
			</tr>

			<tr>
				<td>ID</td>
				<td>${member.uId}</td>
			</tr>

			<tr>
				<td>이름</td>
				<td>${member.uName}</td>
			</tr>

			<tr>
				<td>생년월일</td>
				<td>${member.uBirth}</td>
			</tr>

			<tr>
				<td>연락처</td>
				<td>${member.uPhone}</td>
			</tr>

			<tr>
				<td>이메일</td>
				<td>${member.uEmail}</td>
			</tr>

			<tr>
				<td>부서</td>
				<td><c:if test="${member.uDept==0}"> 총괄 </c:if> <c:if
						test="${member.uDept==1}"> 인사 </c:if> <c:if
						test="${member.uDept==2}"> 재무 </c:if> <c:if
						test="${member.uDept==3}"> 개발 </c:if></td>
			</tr>

			<tr>
				<td>등급</td>
				<td><c:if test="${member.uClass==0}"> 슈퍼관리자 </c:if> <c:if
						test="${member.uClass==1}"> 관리자 </c:if> <c:if
						test="${member.uClass==2}"> 일반 </c:if></td>
			</tr>

		</table>
		<br>
		<br>
		<button type="submit" onclick="member_update.do">수정</button>
	</Form>
</body>
</html>