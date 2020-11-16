<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원 상세 정보</title>
</head>
<body>
 
 <Form name='member_update' method="post" action='${pageContext.request.contextPath}/member_updateProc.do' enctype="multipart/form-data">
 <input type='hidden' name='uNum' id='uNum' required="required" value='${member.uNum}'>
 
<table width="500" border="1" cellpadding="0" cellspacing="0" align="left">
			
			<tr>
				<td>사진</td>	
				<td><img src ="${member.uImg}"> 
				<input type="file" name="file" value="">
				</td>				
			</tr>
			
			<tr>
				<td>ID</td>	
				<td> <input type='text' name='uId' id='uId' required="required" value='${member.uId}'></td>				
			</tr>
			
			<tr>
				<td>이름</td>	
				<td>
				<input type='text' name='uName' id='uName' required="required" value='${member.uName}'>
				</td>				
			</tr>
			
			<tr>
				<td>생년월일</td>	
				<td>
				<input type='text' name='uBirth' id='uBirth' required="required" value='${member.uBirth}'>
				</td>				
			</tr>
			
			<tr>
				<td>연락처</td>	
				<td>
				<input type='text' name='uPhone' id='uPhone' required="required" value='${member.uPhone}'>
				</td>				
			</tr>
			
			<tr>
				<td>이메일</td>	
				<td>
				<input type='text' name='uEmail' id='uEmail' required="required" value='${member.uEmail}'>
				</td>				
			</tr>
			
			<tr>
				<td>부서</td>	
				<td>	
					<c:if test="${member.uDept==0}"> 총괄 </c:if>
					<c:if test="${member.uDept==1}"> 인사 </c:if>
					<c:if test="${member.uDept==2}"> 재무 </c:if>	
					<c:if test="${member.uDept==3}"> 개발 </c:if>	
					
				<select id="select_uDept" name="select_uDept" onchange="">
				<option value="1"> 인사 </option>
				<option value="2"> 재무 </option>
				<option value="3"> 개발 </option> 
				</select>	
				
				
				</td>	
			</tr>
			
			<tr>
				<td>등급</td>	 
				<td>	
					<c:if test="${member.uClass==0}"> 슈퍼관리자 </c:if>					
					<c:if test="${member.uClass==1}"> 관리자 </c:if>					
					<c:if test="${member.uClass==2}"> 일반 </c:if>
					
				<select id="select_uClass" name="select_uClass" onchange="">
				<option value="0"> 권한변경 </option>
				<option value="1"> 관리자 </option>
				<option value="2"> 일반 </option>				
				</select>
					
					
				</td>	
			</tr>
	 
		</table>
		<br><br>
		<button type="submit" onclick="${pageContext.request.contextPath}/member_updateProc.do">저장</button>
		</Form>
</body>
</html>