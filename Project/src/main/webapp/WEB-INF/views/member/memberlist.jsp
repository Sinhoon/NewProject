<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../common/header.jsp"%>
<title>회원목록</title>
</head>
<script>
	$(document).ready(function() {
		$(".lock_btn").on('click', function() {
			var temp = this;
			lockChk(temp);
		});
		$(".unlock_btn").on('click', function() {
			var temp = this;
			unlockChk(temp);
		});

		var uclas = <%=meb.getuClass()%> ;
		if (uclas != 0){
			$('#showdept').attr('disabled', 'true');
		}
		document.search.keyWord.value = '${before_keyWord}';
		$("#keyField").on('change', function() {
			document.search.keyWord.value = '';
			if ($("#keyField").val() == "all") {
				$('#keyWord').css("display", "none")
			}
			else {
				$('#keyWord').css("display", "")
			}
			
		});
		
		document.search.keyField.value= '${before_keyField}';
		if ($("#keyField").val() == "all") {
			$('#keyWord').css("display", "none")
		}
		else {
			$('#keyWord').css("display", "")
		}

		
		
		function lockChk(temp) {
			$.ajax({
				url : "${pageContext.request.contextPath}/lockPro.do",
				type : "GET",
				async : false,
				data : {
					unum : $(temp).val(),
				},
				success : function(data) {
					$(temp).text("비활성화");
					$(temp).attr('class', 'unlock_btn');
				},
				error : function() {
					alert("err");
				}
			});
		}
		;
		function unlockChk(temp) {
			$.ajax({
				url : "${pageContext.request.contextPath}/unlockPro.do",
				type : "GET",
				async : false,
				data : {
					unum : $(temp).val(),
				},
				success : function(data) {
					$(temp).text("활성화");
					$(temp).attr('class', 'lock_btn');
				},
				error : function() {
					alert("err");
				}
			});
		}
		;

	});
</script>


<body>
 
	<c:set var="uClass" value="<%=Integer.parseInt(meb.getuClass())%>"></c:set>
	<form action="/memberlist" name="search" method="post" 
		onsubmit="return seachCheck()">
		<table width="500" align="center">
			<tr>
				<!--  게시판 선택 -->
				<td align="center" width="90%"><select name="showdept"
					id="showdept">
						<option value="0">부서</option>
						<c:forEach items="${deptlist}" var="deptlist">
							<c:choose>
								<c:when test="${before_showdept == deptlist.dNum}">
									<option value="${deptlist.dNum}" selected="selected">${deptlist.dName}</option>
								</c:when>
								<c:otherwise>
									<option value="${deptlist.dNum}">${deptlist.dName}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
				</select> <select name="keyField" id="keyField">
						<option value="all">전체</option>
						<option value="uName">이름</option>
						<option value="uId">ID</option>

				</select> <input type="text" size="16" name="keyWord" id="keyWord" style="display:none"> <input
					type="submit" value="검색" id="submit"
					style="font-family: Gulim; font-size: 12px;"> <A
					href='memberlist'> <input type="button" value="초기화"
						style="font-family: Gulim; font-size: 12px;"></A></td>


			</tr>

		</table>

	</form>

	<table width="500" align="center">
		<tr>
			<td align="right" style="font-family: Gulim; font-size: 12px;">총&nbsp;${count}건
				${currentPage}페이지</td>
		</tr>
	</table>
	<table width="850" border="1" cellpadding="0" cellspacing="0"
		align="left">
		<tr>
			<th style="font-family: Gulim; font-size: 12px;">이름</th>
			<th style="font-family: Gulim; font-size: 12px;">이메일</th>
			<th style="font-family: Gulim; font-size: 12px;">부서</th>
			<th style="font-family: Gulim; font-size: 12px;">가입날짜</th>
			<th style="font-family: Gulim; font-size: 12px;">비고</th>
			<c:if test="${uClass < 2}">
				<th style="font-family: Gulim; font-size: 12px;">계정상태</th>
			</c:if>
		</tr>
		<tbody>
			<c:forEach items="${result}" var="member">
				<tr>

					<td width="100"><a href="member_read.do?uNum=${member.uNum}">
							${member.uName} </a></td>


					<td width="210" style="font-family: Gulim; font-size: 12px;">
						${member.uEmail}</td>

					<td align="center" width="70"
						style="font-family: Gulim; font-size: 12px;"><c:if
							test="${member.uDept==0}">
					총괄
					</c:if> <c:if test="${member.uDept==1}">
					인사
					</c:if> <c:if test="${member.uDept==2}">
					재무
					</c:if> <c:if test="${member.uDept==3}">
					개발
					</c:if></td>

					<td width="120" style="font-family: Gulim; font-size: 12px;"
						align="center">${member.uRegdate}</td>

					<td width="50" align="center"
						style="font-family: Gulim; font-size: 12px;"><c:if
							test="${member.uClass==0}"> 슈퍼관리자 </c:if> <c:if
							test="${member.uClass==1}"> 관리자 </c:if> <c:if
							test="${member.uClass==2}"> 일반 </c:if></td>

					<c:if test="${uClass < 2}">
						<td width="50" align="center"
							style="font-family: Gulim; font-size: 12px;"><c:if
								test="${member.uLock < 5}">
								<button class="lock_btn" value="${member.uNum}">활성화</button>
							</c:if> <c:if test="${member.uLock >= 5}">
								<button class="unlock_btn" value="${member.uNum}">비활성화</button>
							</c:if></td>
					</c:if>
				</tr>
			</c:forEach>
			<c:if test="${count==0}">
				<tr>
					<td colspan="5" align="center"
						style="font-family: Gulim; font-size: 12px;">게시물이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>


	<!-- 페이징 -->
	<table align="center">

		<c:if test="${count>0}">
			<tr>

				<td align="center"><c:if test="${currentPage > 1}">
						<a href='list.do?pageNum=1'>처음</a>
					</c:if></td>

				<td align="center"><c:if test="${currentPage > 10}">
						<a href='list.do?pageNum=${currentPage-10 }'> < </a>
					</c:if></td>


				<td align="center">${pagingHtml}</td>
				<!-- 글목록 밑에 1,2,3 이렇게 뜨는거 -->


				<td align="center"><c:if test="${currentPage > 10}">
						<a href='list.do?pageNum=${currentPage+10 }'> > </a>
					</c:if></td>

				<td align="center"><c:if test="${currentPage <= number}">
						<a href='list.do?pageNum=${end}'>끝</a>
					</c:if></td>

			</tr>
		</c:if>

	</table>
	<!--  회원 등록 버튼 -->
	<c:if test="${uClass < 1}">
		<input type="button" value="회원등록"
			onClick="location.href='${pageContext.request.contextPath}/member_regist'">
	</c:if>






</body>
</html>