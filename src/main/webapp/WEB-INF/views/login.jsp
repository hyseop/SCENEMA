<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인, SCENEMA</title>
<link rel="stylesheet" href="resources/css/login.css">
<script src="resources/js/jquery-3.6.4.min.js"></script>
</head>
<script>
$(document).ready(function(){
	$("#loginButton").on('click',function(){
		let id = $("#id").val();
		let pw = $("#pw").val();
		
		if(id==""){ alert("아이디를 입력해 주세요");}
		else if(pw==""){ alert("비밀번호를 입력해 주세요");}
		else {
			$.ajax({
				url:'login',
				data: {
					'userid':$("#id").val(),
					'pw':$("#pw").val()
				},
				type:'post',
				success:function(res){
					if(res == "null"){
						alert("존재하지 않는 아이디 입니다.");
					}else if(res=="password error"){
						alert("비밀번호가 올바르지 않습니다.");
					}else{
						location.href = "/scenema";
					}
				},
				error:function(request,status,e){
					alert("코드="+request.status+"\n메시지="+request.responseText+"\nerror="+e);
				}
			}); //ajax
		}
	});
});
</script>

<body>
	<%@ include file="Header.jsp" %>
	
	<article>
		<form id="loginForm" action="" method="post">
			<h2 id="title">로그인</h2>
			<div id='inner'>
				<input type="text" name="id" id="id" placeholder="ID">
				<input type="password" name="pw" id="pw" placeholder="PW">
			</div>
			<button type="button" name="login" id="loginButton">로그인</button>
			<a href="/scenema/signup" id="signUpLink" title="환영합니다.">회원가입</a>
		</form>
	</article>
	
	<%@ include file="Footer.jsp" %>
</body>
</html>