<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ�� �� ����</title>
</head>
<body>
 
 <Form name='member_update' method="post" action='${pageContext.request.contextPath}/member_updateProc.do' enctype="multipart/form-data">
 <input type='hidden' name='uNum' id='uNum' required="required" value='${member.uNum}'>
 
<table width="500" border="1" cellpadding="0" cellspacing="0" align="left">
			
			<tr>
				<td>����</td>	
				<td><img src ="${member.uImg}"> 
				<input type="file" name="file" value="">
				</td>				
			</tr>
			
			<tr>
				<td>ID</td>	
				<td> <input type='text' name='uId' id='uId' required="required" value='${member.uId}'></td>				
			</tr>
			
			<tr>
				<td>�̸�</td>	
				<td>
				<input type='text' name='uName' id='uName' required="required" value='${member.uName}'>
				</td>				
			</tr>
			
			<tr>
				<td>�������</td>	
				<td>
				<input type='text' name='uBirth' id='uBirth' required="required" value='${member.uBirth}'>
				</td>				
			</tr>
			
			<tr>
				<td>����ó</td>	
				<td>
				<input type='text' name='uPhone' id='uPhone' required="required" value='${member.uPhone}'>
				</td>				
			</tr>
			
			<tr>
				<td>�̸���</td>	
				<td>
				<input type='text' name='uEmail' id='uEmail' required="required" value='${member.uEmail}'>
				</td>				
			</tr>
			
			<tr>
				<td>�μ�</td>	
				<td>	
					<c:if test="${member.uDept==0}"> �Ѱ� </c:if>
					<c:if test="${member.uDept==1}"> �λ� </c:if>
					<c:if test="${member.uDept==2}"> �繫 </c:if>	
					<c:if test="${member.uDept==3}"> ���� </c:if>	
					
				<select id="select_uDept" name="select_uDept" onchange="">
				<option value="1"> �λ� </option>
				<option value="2"> �繫 </option>
				<option value="3"> ���� </option> 
				</select>	
				
				
				</td>	
			</tr>
			
			<tr>
				<td>���</td>	 
				<td>	
					<c:if test="${member.uClass==0}"> ���۰����� </c:if>					
					<c:if test="${member.uClass==1}"> ������ </c:if>					
					<c:if test="${member.uClass==2}"> �Ϲ� </c:if>
					
				<select id="select_uClass" name="select_uClass" onchange="">
				<option value="0"> ���Ѻ��� </option>
				<option value="1"> ������ </option>
				<option value="2"> �Ϲ� </option>				
				</select>
					
					
				</td>	
			</tr>
	 
		</table>
		<br><br>
		<button type="submit" onclick="${pageContext.request.contextPath}/member_updateProc.do">����</button>
		</Form>
</body>
</html>