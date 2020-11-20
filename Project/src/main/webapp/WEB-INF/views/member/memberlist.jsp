<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="../common/header.jsp"%>
<title>회원목록</title>
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>	
</head>


<script>
	$(document).on("click", ".lock_btn", function() {
		console.log("1")
		var temp = this;
 	 $(this).text("비활성화");
		$(this).prop('class', 'unlock_btn');  
		lockChk(temp);
	});

	$(document).on("click", ".unlock_btn", function() {
		console.log("2")
		var temp = this;
 		 $(this).text("활성화");
		$(this).prop('class', 'lock_btn');  
	
		unlockChk(temp);
	});


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
				$(temp).css("background-color","red");
				$(temp).attr('class', 'unlock_btn'); 
	
			},
			error : function() {
				alert("err");
			}
		});
	};
	function unlockChk(temp) {
		$.ajax({
			url : "${pageContext.request.contextPath}/unlockPro.do",
			type : "GET",
			async : false,
			data : {
				unum : $(temp).val(),
			},
			success : function(data) {
				$(temp).css("background-color","green");
				$(temp).text("활성화");
				$(temp).attr('class', 'lock_btn'); 
			},
			error : function() {
				alert("err");
			}
		});
	};

	$(document).ready(function() {

		var uclas =
<%=meb.getuClass()%>
	;
		if (uclas != 0) {
			$('#showdept').attr('disabled', 'true');
		}
		document.search.keyWord.value = '${before_keyWord}';
		$("#keyField").on('change', function() {
			document.search.keyWord.value = '';
			if ($("#keyField").val() == "all") {
				$('#keyWord').css("display", "")
			} else {
				$('#keyWord').css("display", "")
			}

		});

		document.search.keyField.value = '${before_keyField}';
		if ($("#keyField").val() == "all") {
			$('#keyWord').css("display", "")
		} else {
			$('#keyWord').css("display", "")
		}

	});
</script>


<body>

	<c:set var="uClass" value="<%=Integer.parseInt(meb.getuClass())%>"></c:set>
	<table width="300" align="center"
		style="position: relative; bottom: -10px; right: -550px;">
		<tr>
			<td align="right" style="font-family: Gulim; font-size: 12px;">
				총&nbsp;${count}건 ${currentPage}페이지</td>
		</tr>
	</table>

	<table data-toggle="table">
		<!-- 	<table class="table w-50"  border="1" cellpadding="0" cellspacing="0"
		align="left" style="position : relative; bottom : -20px"> -->
		<thead>
			<tr>
				<th scope="col" style="font-family: Gulim; font-size: 12px;">이름</th>
				<th scope="col" style="font-family: Gulim; font-size: 12px;">이메일</th>
				<th scope="col" style="font-family: Gulim; font-size: 12px;">부서</th>
				<th scope="col" style="font-family: Gulim; font-size: 12px;">가입날짜</th>
				<th scope="col" style="font-family: Gulim; font-size: 12px;">비고</th>
				<c:if test="${uClass < 2}">
					<th style="font-family: Gulim; font-size: 12px;">계정상태</th>
				</c:if>
			</tr>


		</thead>
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
								<button class="lock_btn" value="${member.uNum}" style="background-color:green;color:white">활성화</button> 
							</c:if> <c:if test="${member.uLock >= 5}">
								 <button class="unlock_btn" value="${member.uNum}" style="background-color:red;color:white">비활성화</button>  		
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





	<form action="/memberlist" name="search" method="post"
		onsubmit="return seachCheck()">
		<table width="500" align="center">
			<tr>
				<!--  게시판 선택 -->
				<td align="center" width="90%"><select name="showdept"
					id="showdept"
					style="height: 30px; width: 70px; position: relative; bottom: -80px; right: -10px;">
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
				</select> <select name="keyField" id="keyField"
					style="height: 30px; width: 70px; position: relative; bottom: -80px; right: -10px;">
						<option value="all">전체</option>
						<option value="uName">이름</option>
						<option value="uId">ID</option>
						<option value="uEmail">이메일</option>

				</select> <input type="text" size="17" name="keyWord" id="keyWord"
					style="height: 30px; position: relative; bottom: -80px; right: -10px;">
					<input type="submit"
					class="w3-button w3-block w3-gray w3-ripple w3-margin-top w3-round"
					value="검색" id="submit"
					style="display: inline; font-family: Gulim; font-size: 12px; height: 30px; width: 70px;; position: relative; bottom: -80px; right: -10px;">

					<A href='memberlist'> <input type="button" value="초기화"
						class="w3-button w3-block w3-black w3-ripple w3-margin-top w3-round"
						style="display: inline; font-family: Gulim; font-size: 12px; height: 30px; width: 70px; position: relative; bottom: -80px; right: -10px;">
				</A> <!--  회원 등록 버튼 --> <c:if test="${uClass < 1}">
						<input type="button" class="ui black deny button" value="회원등록"
							style="position: relative; bottom: 10px; right: -600px;"
							onClick="location.href='${pageContext.request.contextPath}/member_regist'">
					</c:if></td>


			</tr>

		</table>

	</form>
	<!-- 페이징 -->
	<div class="ui pagination menu"
		style="position: relative; bottom: 50px; right: -650px;">
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


</body>
</html>