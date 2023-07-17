<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/js/jquery-3.6.4.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="resources/css/SignUpForm.css">
<script>
	$(document).ready(function() {
		$("#signUpButton").on('click', function(e) {
			var userid = $("#userid").val();
			var pw = $("#pw").val();
			var pwAgain = $("#pwAgain").val();
			var name = $("#name").val();
			var phone = $("#phone").val();
			var email = $("#emailId").val() + "@" + $("#emailAddress").val();

			if (userid === "") {
				alert("아이디를 입력하세요.");
			} else if (pw === "" || pwAgain === "" || pw !== pwAgain) {
				alert("비밀번호를 확인하세요.");
			} else if (name === "") {
				alert("이름을 입력하세요.");
			} else if (phone === "") {
				alert("전화번호를 입력하세요.");
			} else if (email === "") {
				alert("이메일을 입력하세요.");
			} else {
				$.ajax({
					url : "signup",
					method : "post",
					data : {
						"userid" : userid,
						"pw" : pw,
						"name" : name,
						"phone" : phone,
						"email" : email
					},
					success : function() {
						alert("환영합니다!");
						window.location.href = "/scenema";
					},
					error : function() {
						console.log("에러발생");
					}
				}); // ajax
			}
		}); // click
		
		$('#idCheckButton').click(function() {
		    var userid = $("#userid").val();

		    if (!userid) {
		        alert("아이디를 입력하세요.");
		        return;
		    }

		    $.ajax({
		        url: "duplicateCheck",
		        method: "post",
		        data: {
		            "userid": userid
		        },
		        success: function(response) {
		            if (userid.trim() === "" || response.isDuplicated) {
		                alert("사용할 수 없는 아이디입니다.");
		            } else {
		                alert("사용할 수 있는 아이디입니다.");
		            }
		        },
		        error: function() {
		            console.log("에러 발생");
		        }
		    });
		});
		
	    $('#pw, #pwAgain').on('keyup', function () {
	        if ($('#pw').val() == $('#pwAgain').val()) {
	            $('#message').html('비밀번호가 일치합니다.').css('color', 'green');
	        } else 
	            $('#message').html('비밀번호가 일치하지 않습니다.').css('color', 'red');
	    });
		
		$("#phone").on('change', function() {
	        var phone = $(this).val();
	        var phoneRegEx = /^\d{3}-\d{4}-\d{4}$/;
	        if (!phoneRegEx.test(phone)) {
	            alert("올바른 형식이 아닙니다. '010-1234-1234'");
	            $(this).val("");
	            $(this).focus();
	        }
	    });

		$('#emailAddressDropdown').change(function() {
			var selectedOption = $(this).val();
			if (selectedOption === "") {
				$('#emailAddressInput').prop('disabled', false);
				$('#emailAddressInput').val("");
			} else {
				$('#emailAddressInput').prop('disabled', true);
				$('#emailAddressInput').val(selectedOption);
			}
		});

		$('#email').keyup(function() {
			$('#emailAddressDropdown').val("");
		});

		$('#emailAddressDropdown').change(function() {
			var selectedOption = $(this).val();
			if (selectedOption === "") {
				$('#emailAddressInput').prop('disabled', false);
				$('#emailAddressInput').val("");
			} else {
				$('#emailAddressInput').prop('disabled', true);
				$('#emailAddressInput').val(selectedOption);
			}
		});

	});
</script>
</head>
<body>
	<%@ include file="Header.jsp"%>
<body>
	<article style="height:700px;">
		<form name="signUpForm">
			<h2>회원가입</h2>
			<div class='formindiv'>
				<p class="etc-tag">아이디</p>
				<div id=id_div>
					<input type="text" id="userid" placeholder="ID" maxlength="16">
					<button type="button" id="idCheckButton">중복확인</button>
				</div>
			</div>

			<div class='formindiv'>
				<p class="etc-tag">비밀번호</p>
				<label><input type="password" name="pw" id="pw"
					placeholder="PW" maxlength="16"></label>
			</div>

			<div class='formindiv'>
				<p class="etc-tag">비밀번호 확인</p>
				<input type="password" name="pwAgain" id="pwAgain"
					placeholder="PW CHECK" maxlength="16" style="margin-bottom: 10px;">
					<span id="message" style="font-size:12px;"></span>
			</div>

			<div class='formindiv'>
				<p class="etc-tag">이름</p>
				<input type="text" name="name" id="name" placeholder="NAME">
			</div>

			<div class='formindiv'>
				<p class="etc-tag">휴대폰 번호</p>
				<input type="tel" name="phone" id="phone"
					placeholder="010-1234-1234">
			</div>

			<div class="formindiv">
				<p class="email-tag">이메일</p>
				<div id="emailinner">
					<input type="text" id="email" name="email" placeholder="ID">
					@ <label for="emailAddress"></label> <input type="text"
						id="emailAddressInput" name="emailAddress" placeholder="ADDRESS">
					<select id="emailAddressDropdown" name="emailAddress">
						<option value="">직접 입력</option>
						<option value="naver.com">NAVER</option>
						<option value="kakao.com">KAKAO</option>
						<option value="google.com">GOOGLE</option>
						<option value="gmail.com">GMAIL</option>
						<option value="outlook.com">OUTLOOK</option>
						<option value="daum.net">DAUM</option>
					</select>
				</div>
			</div>

			<div class='formindiv'>
				<button type="button" id="signUpButton">회원가입</button>
			</div>

		</form>
	</article>
</body>
<%@ include file="Footer.jsp"%>
</html>