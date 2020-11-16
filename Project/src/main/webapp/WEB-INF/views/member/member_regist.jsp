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
	/* 회원 등록 */
	function regSubmit() {
		var formdata = new FormData(document.getElementById('uploadForm'));
		console.log(formdata);
		$.ajax({
			url : "${pageContext.request.contextPath}/rId.do",
			type : "POST",
			async : false,
			data : formdata,
			processData: false,
            contentType: false,
			success : function(data) {
				console.log(data);
				if (data.Code == "0000") {
					window.location.href = "${pageContext.request.contextPath}/memberlist";
				}  else {
					window.location.href = "${pageContext.request.contextPath}/member_regist";
				}
			},
			error : function() {
				alert("err");
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
					$('#id_check').text('중복아이디 입니다.');
					$('#id_check').css('color', 'red');
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
	$('#reg_submit').click(function(){
		// 비밀번호가 같은 경우 && 비밀번호 정규식
		if (($('#user_pw').val() == ($('#user_pw2').val()))
				&& pwJ.test($('#user_pw').val())) {
			inval_Arr[0] = true;
		} else {
			inval_Arr[0] = false;
		}
		// 이름 정규식
		if (nameJ.test($('#user_name').val())){
			inval_Arr[1] = true;	
		} else {
			inval_Arr[1] = false;
		}
		// 아이디 정규식
		if (idJ.test($('#user_id').val()) && ($('#id_check').text()=="")  ){
			inval_Arr[2] = true;
		} else {
			inval_Arr[2] = false;
		}
		// 휴대폰번호 정규식
		if (phoneJ.test($('#user_phone').val())) {
			inval_Arr[3] = true;
		} else {
			inval_Arr[3] = false;
		}
		// 생년월일 정규식
		if (birthJ) {
			inval_Arr[4] = true;
		} else {
			inval_Arr[4] = false;
		}
		// 이메일 정규식
		if (emailJ.test($('#user_email').val())) {
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
/* 			var mem = {};
			mem.uId = $("#user_id").val();
			mem.uPwd = $("#user_pw").val();
			mem.uName = $("#user_name").val();
			mem.uBirth = $("#user_birth").val();
			mem.uPhone = $("#user_phone").val();
			mem.uEmail = $("#user_email").val();
			mem.uDept = $("#user_dept").val();
			mem.uClass = $("#user_class").val();  */
			regSubmit(); 
			alert('회원 등록 완료');
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
			<h3>회원등록</h3>
		</div>
		<div class="row mt-5">
			<div class="col-12">
				<form method="POST" id="uploadForm" enctype="multipart/form-data">
					<!-- 아이디 -->
					<div class="form-group">
						<label for="user_id">아이디</label> <input type="text"
							class="form-control" id="user_id" name="user_id"
							placeholder="아이디"  required>
						<div class="check_font" id="id_check"></div>
					</div>
					<!-- 비밀번호 -->
					<div class="form-group">
						<label for="user_pw">비밀번호</label> <input type="password"
							class="form-control" id="user_pw" name="user_pw"
							placeholder="비밀번호" required>
						<div class="check_font" id="pw_check"></div>
					</div>
					<!-- 비밀번호 재확인 -->
					<div class="form-group">
						<label for="user_pw2">비밀번호 확인</label> <input type="password"
							class="form-control" id="user_pw2" name="user_pw2"
							placeholder="비밀번호 확인" required>
						<div class="check_font" id="pw2_check"></div>
					</div>
					<!-- 이름 -->
					<div class="form-group">
						<label for="user_name">이름</label> <input type="text"
							class="form-control" id="user_name" name="user_name"
							placeholder="이름"  required>
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
					<div class="form-group required">
						<label for="user_dept">부서</label> <select id="user_dept"
							name="user_dept">
							<c:forEach items="${deptlist}" var="deptlist">
								<option value="${deptlist.dNum}">${deptlist.dName}</option>
							</c:forEach>
						</select>
						<div class="check_font" id="dept_check"></div>
					</div>
					<!-- 직급 -->
					<div class="form-group required">
						<label for="user_class">직급</label> <select id="user_class"
							name="user_class">
							<c:forEach items="${classlist}" var="classlist">
								<option value="${classlist.cNum}">${classlist.cName}</option>
							</c:forEach>
						</select>
						<div class="check_font" id="class_check"></div>
					</div>
					<!-- 이미지 -->
					<label for="uImg">이미지</label> <input type="file" id="uImg"
						name="upload" />
					<div class="select_img">
						<img src="" />
					</div>
				</form>
				<button type="submit" id="reg_submit" class="btn btn-primary">등록</button>
				<script>
					  $("#uImg").change(function(){
					   if(this.files && this.files[0]) {
					    var reader = new FileReader;
					    reader.onload = function(data) {
					     $(".select_img img").attr("src", data.target.result).width(500);        
					    }
					    reader.readAsDataURL(this.files[0]);
					   }
					  });
					 </script>
			</div>
		</div>
	</div>


</body>
</html>


