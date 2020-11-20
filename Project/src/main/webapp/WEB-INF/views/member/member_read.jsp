<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style>
.select_img img {
	margin: 20px 0;
}
</style>
<meta charset='utf-8' />
<meta name='viewport'
	content='width=device-width, initial-scale=1, shrink-to-fit=no' />

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
</head>

<script>
$(document).ready(function() {
	$("#uImgchk").val("");
	$("#user_num").prop('disabled', false);
	dactive()
	/* 회원 수정 */
	$("#mod_submit").on('click', function() {
		active()
	});
	/* 취소 */
	$("#can_submit").on('click', function() {
		location.reload();
	});
	$("#rm_submit").on('click', function() {
		rmSubmit();
	});
	$("#bef_submit").on('click', function() {
		window.location.href = "${pageContext.request.contextPath}/memberlist";
	});


	function active(){
		$(".form-control").prop("disabled",false);
		$("#user_class").prop('disabled', false);
		$("#user_dept").prop('disabled', false);
		$("#ureg_submit").css('display', '');
		$("#can_submit").css('display', '');
		$("#uImg").css('display', '');
		$("#mod_submit").css('display', 'none');
		$("#rm_submit").css('display', 'none');
		$("#pwform").css('display', '');
		$("#pw2form").css('display', '');
		$(".check_font").text("");
	}
	function dactive(){
		$(".form-control").prop("disabled",true);
		$("#user_class").prop('disabled', true);
		$("#user_dept").prop('disabled', true);
		$("#before_id").attr("value",'${member.uId}');
		$("#user_id").attr("value",'${member.uId}');
		$("#user_pw").attr("value",'${member.uPwd}');
		$("#user_pw2").attr("value",'${member.uPwd}');
		$("#user_name").attr("value",'${member.uName}');
		$("#user_birth").attr("value",'${member.uBirth}');
		$("#user_email").attr("value",'${member.uEmail}');
		$("#user_phone").attr("value",'${member.uPhone}');
		$("#uImg").css('display', 'none');
		$("#pwform").css('display', 'none');
		$("#pw2form").css('display', 'none');
		$("#ureg_submit").css('display', 'none');
		$("#can_submit").css('display', 'none');
		$("#mod_submit").css('display', '');
		$("#rm_submit").css('display', '');
		$(".check_font").text("");
	}

	/* 회원 삭제 */		
	function rmSubmit() {
		$.ajax({
			url : "${pageContext.request.contextPath}/rmId.do",
			type : "POST",
			async : false,
			data : {
				unum : $("#user_num").val()
			},
			success : function(data) {
				console.log(data);
				if (data.Code == "0000") {
					window.location.href = "${pageContext.request.contextPath}/memberlist";
					alert('회원 삭제 완료');
				}  else {
					alert("err2");
				}
			},
			error : function() {
				alert("err1");
			}
		});
	}
	
	/* 회원 등록 */		
	function regSubmit() {
		var formdata = new FormData(document.getElementById('uploadForm'));
		if ($("#uImgchk").val() == "change"){
			console.log("change");
		}
		$.ajax({
			url : "${pageContext.request.contextPath}/mId.do",
			type : "POST",
			async : false,
			data : formdata,
			processData: false,
            contentType: false,
			success : function(data) {
				console.log(data);
				if (data.Code == "0000") {
					location.reload();
					alert('회원 수정 완료');
				}  else {
					location.reload();
					alert("err2");
				}
			},
			error : function() {
				location.reload();
				alert("err1");
			}
		});
	}
	/* 중복 체크 */
	function ridChk() {
		$.ajax({
			url : "${pageContext.request.contextPath}/ridChk.do",
			type : "POST",
			async : false,
			data : {
				id : $("#user_id").val()
			},
			success : function(data) {
				if (data.Code == "0000") {
					console.log();
				}  else {
					if ($("#before_id").val() != $("#user_id").val()){
					$('#id_check').text('중복아이디 입니다.');
					$('#id_check').css('color', 'red');
					}
					else{
						$('#id_check').text('');
					}
					
				}
			},
			error : function() {
				alert("err");
			}
		});
	}

//모든 공백 체크 정규식
var empJ = /\s/g;
//아이디 정규식
var idJ = /^[a-z0-9]{4,12}$/;
// 비밀번호 정규식
var pwJ = /^[A-Za-z0-9]{4,12}$/; 
// 이름 정규식
var nameJ = /^[가-힣]{2,6}$/;
// 이메일 검사 정규식
var emailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
// 휴대폰 번호 정규식
var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;

//아이디
$("#user_id").blur(function() {
	if (idJ.test($(this).val())) {
		$("#id_check").text('');
		ridChk();
	} else {
		$('#id_check').text('4자리 이상 아이디를 입력해주세요(특수문자 제외)');
		$('#id_check').css('color', 'red');
	}
});

//비밀번호
$("#user_pw").blur(function() {
	if (pwJ.test($(this).val())) {
		$("#pw_check").text('');
	} else {
		$('#pw_check').text('4자리 이상 비밀번호를 입력해주세요');
		$('#pw_check').css('color', 'red');
	}
});

//비밀번호 확인
$("#user_pw2").blur(function() {
	if ($('#user_pw').val() == ($('#user_pw2').val())) {
		$("#pw2_check").text('');
	} else {
		$('#pw2_check').text('비밀번호를 확인해주세요');
		$('#pw2_check').css('color', 'red');
	}
});

//이름
$("#user_name").blur(function() {
	if (nameJ.test($(this).val())) {
		$("#name_check").text('');
	} else {
		$('#name_check').text('이름을 확인해주세요');
		$('#name_check').css('color', 'red');
	}
});

// 휴대전화
$('#user_phone').blur(function(){
	if(phoneJ.test($(this).val())){
		$("#phone_check").text('');
	} else {
		$('#phone_check').text('휴대폰번호를 확인해주세요');
		$('#phone_check').css('color', 'red');
	}
});

//이메일
$('#user_email').blur(function(){
	if(emailJ.test($(this).val())){
		$("#email_check").text('');
	} else {
		$('#email_check').text('이메일형식을 확인해주세요');
		$('#email_check').css('color', 'red');
	}
});


//생일 유효성 검사
var birthJ = false;
// 생년월일	birthJ 유효성 검사
$('#user_birth').blur(function(){
	var dateStr = $(this).val();		
    var year = Number(dateStr.substr(0,4)); // 입력한 값의 0~4자리까지 (연)
    var month = Number(dateStr.substr(4,2)); // 입력한 값의 4번째 자리부터 2자리 숫자 (월)
    var day = Number(dateStr.substr(6,2)); // 입력한 값 6번째 자리부터 2자리 숫자 (일)
    var today = new Date(); // 날짜 변수 선언
    var yearNow = today.getFullYear(); // 올해 연도 가져옴
    if (dateStr.length <=8) {
		// 연도의 경우 1900 보다 작거나 yearNow 보다 크다면 false를 반환합니다.
	    if (1900 > year || year > yearNow){
	    	$('#birth_check').text('생년월일을 확인해주세요');
			$('#birth_check').css('color', 'red');
	    }else if (month < 1 || month > 12) {
	    		
	    	$('#birth_check').text('생년월일을 확인해주세요');
			$('#birth_check').css('color', 'red'); 
	    }else if (day < 1 || day > 31) {
	    	
	    	$('#birth_check').text('생년월일을 확인해주세요');
			$('#birth_check').css('color', 'red'); 	    	
	    }else if ((month==4 || month==6 || month==9 || month==11) && day==31) {	    	 
	    	$('#birth_check').text('생년월일을 확인해주세요');
			$('#birth_check').css('color', 'red'); 	    	 
	    }else if (month == 2) {	    	 
	       	var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));	       	
	     	if (day>29 || (day==29 && !isleap)) {	     		
	     		$('#birth_check').text('생년월일을 확인해주세요)');
				$('#birth_check').css('color', 'red'); 	    	
			}else{
				$('#birth_check').text('');
				birthJ = true;
			}//end of if (day>29 || (day==29 && !isleap))	     	
	    }else{
	    	$('#birth_check').text(''); 
			birthJ = true;
		}//end of if		
		}else{
			//1.입력된 생년월일이 8자 초과할때 :  auth:false
			$('#birth_check').text('생년월일을 확인해주세요');
			$('#birth_check').css('color', 'red');  
		}
	}); //End of method /*

// 가입하기 실행 버튼 유효성 검사!
var inval_Arr = new Array(6).fill(false);
	$('#ureg_submit').click(function(){
		// 비밀번호가 같은 경우 && 비밀번호 정규식
		if (($('#user_pw').val() == ($('#user_pw2').val()))
				&& $('#pw_check').text('') && $('#pw2_check').text('') ) {
			inval_Arr[0] = true;
		} else {
			inval_Arr[0] = false;
		}
		// 이름 정규식
		if ($('#name_check').text('')){
			inval_Arr[1] = true;	
		} else {
			inval_Arr[1] = false;
		}
		// 아이디 정규식
		if ($('#id_check').text('')){
			inval_Arr[2] = true;
		} else {
			inval_Arr[2] = false;
		}
		// 휴대폰번호 정규식
		if ($('#phone_check').text('')) {
			inval_Arr[3] = true;
		} else {
			inval_Arr[3] = false;
		}
		// 생년월일 정규식
		if ($('#birth_check').text('')) {
			inval_Arr[4] = true;
		} else {
			inval_Arr[4] = false;
		}
		// 이메일 정규식
		if ($('#email_check').text('')) {
			inval_Arr[5] = true;
		} else {
			inval_Arr[5] = false;
		}	
		
		var validAll = true;
		for(var i = 0; i < inval_Arr.length; i++){
			if(inval_Arr[i] == false){
				validAll = false;
			}
		}
		if(validAll){ // 유효성 모두 통과
			console.log("ddddddddddddss")
			regSubmit(); 
		} else{
			if ($(".check_font").text() != ""){
				return false
			}
		}
	});
	
});

</script>


<!-- 섹션 -->
<body>
	<div class="container">
		<div class="row mt-5">
			<h3>회원정보</h3>
		</div>
		<div class="row mt-5">
			<div class="col-12">
				<form method="POST" id="uploadForm" name="uploadForm"
					enctype="multipart/form-data">
					<div class="form-group">
						<input type="text" id="user_num" name="user_num"
							value=${member.uNum } placeholder="번호" style="display: none">
					</div>
					<!-- 아이디 -->
					<div class="form-group">
						<label for="user_id">아이디</label> <input type="text"
							class="form-control" id="user_id" name="user_id"
							placeholder="아이디" required>
						<div class="check_font" id="id_check"></div>
						<input type="text" id="before_id" name="before_id"
							placeholder="아이디" style="display: none">
					</div>
					<!-- 비밀번호 -->
					<div class="form-group" id="pwform">
						<label for="user_pw">비밀번호</label> <input type="password"
							class="form-control" id="user_pw" name="user_pw"
							placeholder="비밀번호" required>
						<div class="check_font" id="pw_check"></div>
					</div>
					<!-- 비밀번호 재확인 -->
					<div class="form-group" id="pw2form">
						<label for="user_pw2">비밀번호 확인</label> <input type="password"
							class="form-control" id="user_pw2" name="user_pw2"
							placeholder="비밀번호 확인" required>
						<div class="check_font" id="pw2_check"></div>
					</div>
					<!-- 이름 -->
					<div class="form-group">
						<label for="user_name">이름</label> <input type="text"
							class="form-control" id="user_name" name="user_name"
							placeholder="이름" required>
						<div class="check_font" id="name_check"></div>
					</div>
					<!-- 생년월일 -->
					<div class="form-group required">
						<label for="user_birth">생년월일</label> <input type="text"
							class="form-control" id="user_birth" name="user_birth"
							placeholder="ex) 19990415" required>
						<div class="check_font" id="birth_check"></div>
					</div>
					<!-- 휴대전화 -->
					<div class="form-group required">
						<label for="user_phone">휴대전화</label> <input type="text"
							class="form-control" id="user_phone" name="user_phone"
							placeholder="ex) 01088293231" required>
						<div class="check_font" id="phone_check"></div>
					</div>
					<!-- 이메일 -->
					<div class="form-group required">
						<label for="user_email">이메일</label> <input type="text"
							class="form-control" id="user_email" name="user_email"
							placeholder="ex) abc@naver.com" required>
						<div class="check_font" id="email_check"></div>
					</div>
					<!-- 부서 -->
               <fmt:parseNumber var="uuClass" type="number"
                  value="${member.uClass}" />
               <fmt:parseNumber var="uuDept" type="number" 
                  value="${member.uDept}" />
                  
               <div class="form-group required" name="dept">
                  <label for="user_dept">부서</label> <select id="user_dept"
                     name="user_dept">
                     <c:forEach items="${deptlist}" var="deptlist">
                        <c:choose>
                           <c:when test="${deptlist.dNum == uuDept}">
                              <option value="${deptlist.dNum}" selected="selected">${deptlist.dName}</option>
                           </c:when>
                           <c:otherwise>
                              <option value="${deptlist.dNum}">${deptlist.dName}</option>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>		
                  </select>
                  <div class="check_font" id="dept_check"></div>
               </div>
               <!-- 직급 -->


               <div class="form-group required" name="class">
                  <label for="user_class">직급</label> <select id="user_class"
                     name="user_class">
                     <c:forEach items="${classlist}" var="classlist">
                        <c:choose>
                           <c:when test="${classlist.cNum == uuClass}">
                              <option value="${classlist.cNum}" selected="selected">${classlist.cName}</option>
                           </c:when>
                           <c:otherwise>
                              <option value="${classlist.cNum}">${classlist.cName}</option>
                           </c:otherwise>
                        </c:choose>
                     </c:forEach>
                  </select>
                  <div class="check_font" id="class_check"></div>
               </div>
					<!-- 이미지 -->
					<label for="uImg">이미지</label> 
					<input type="file" id="uImg" name="upload" /> 
					<input id="uImgchk" name="uImgchk" value=""
						style="display: none" /> <input id="uImgurl" name="uImgurl"
						value="${member.uImg}" style="display: none" />
					<div class="select_img">
						<img src="/resources/${member.uImg}" width="100" />
					</div>
				</form>
				<%
					String uNum = meb.getuNum() +"";
					pageContext.setAttribute("uNum", uNum);
				%>
				<c:set var="uClass" value="<%=Integer.parseInt(meb.getuClass())%>"></c:set>
				<button type="submit" id="bef_submit" class="btn btn-primary">목록</button>
				<c:if test="${uClass <2  ||( member.uNum == uNum )}">
					<button type="submit" id="mod_submit" class="btn btn-primary">수정</button>
					<button type="submit" id="ureg_submit" class="btn btn-primary">저장</button>
					<button type="submit" id="can_submit" class="btn btn-primary">취소</button>
				</c:if>
				<c:if test="${uClass < member.uClass }">
				 <button type="submit" id="rm_submit" class="btn btn-primary">삭제</button>
				</c:if>
				<script>
					  $("#uImg").change(function(){
					   if(this.files && this.files[0]) {
						$("#uImgchk").val("change");
					    var reader = new FileReader;	
					    reader.onload = function(data) {
					     $(".select_img img").attr("src", data.target.result).width(500);        
					    }
					    reader.readAsDataURL(this.files[0]);
					   }
					  });
					  
				/* 	  $("#uImg").change(function(){
						   if(this.files && this.files[0]) {
						    var reader = new FileReader;
						    reader.onload = function(data) {
						     $(".select_img img").attr("src", data.target.result).width(500);        
						    }
						    reader.readAsDataURL($("#uImg").files[0]);
						   }
						  }); */
					 </script>
			</div>
		</div>
	</div>


</body>
</html>


