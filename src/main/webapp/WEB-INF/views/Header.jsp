<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@charset "UTF-8";
@import url("https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css");
* {font-family: 'NanumSquareNeoBold'; }
div {
	width: 1024px;
	margin: 0px auto;
}
header {
	height: 98px;
	margin: 10px auto;
}
#logo {
	font-family: 'NanumSquareNeoHeavy';
	height: 40px;
}
#headlinks {
	width:1024px;
	display:flex;
	justify-content: flex-end;
}
#headlinks>a {
	height: 15px; display: inline-block;
	color: black; font-size: 13px;
	text-decoration: none; text-align: right;
	border-bottom: 1px solid transparent;
	margin-left: 5px;
}
#headlinks>a:hover { border-bottom: 1px solid black; }

.menu {
	width: 100%; height: 40px;
	display: flex; justify-content: center; align-items: center;
	background-color: white;
	border-top: solid 1px lightgrey;
	border-bottom: solid 1px lightgrey;
	position:relative;
}

.menu ul, li {
	list-style: none; float: left;
	line-height: 35px;
}

.menu_in>a {
	width: 130px; height: 30px;
	color: black; font-size: 18px;
	text-decoration: none; text-align: center;
	line-height: 30px;
	border: solid 5px transparent;
	display: block;
	font-family: 'NanumSquareNeoExtraBold';
}

.menu_in>a:hover {
	color: #FF7322;
	border-bottom: solid 5px #FF7322;
}
</style>
<script src="resources/js/jquery-3.6.4.min.js"></script>
<script>
$(document).ready(function(){
	$("#myinfolink").on('click',function(e){
		e.preventDefault();
		let id = "${userid}";
		
		if(id!=""){
			location.href = "/scenema/myinfo";
		}else{
			let con = confirm("로그인이 필요한 항목입니다.\n로그인 창으로 이동하시겠습니까?");
			if(con){
				location.href = "/scenema/login";
			}
		}
	});
})
</script>
</head>
<body>
	<header id='header'>
		<div >
			<nav id='headlinks'>
				<c:if test="${empty userid}">
					<a href="/scenema/login">로그인</a> <a href="/scenema/signup">회원가입</a>
				</c:if>
				<c:if test="${!empty userid}">
					<a href="/scenema/logout">로그아웃</a>
				</c:if>
			</nav>
			<h1 id=logo
				style="margin-top: 0px; margin-bottom: 30px; text-align: center; font-size: 45px">SCENEMA</h1>
		</div>

		<nav id='menu' class='menu'>
			<ul>
				<li class='menu_in'><a href="/scenema/">홈</a></li>
				<li class='menu_in'><a href="/scenema/movielist">영화</a></li>
				<li class='menu_in'><a href="/scenema/boardlist">커뮤니티</a></li>
				<li class='menu_in'><a href="/scenema/myinfo" id="myinfolink">내정보</a></li>
			</ul>
		</nav>
	</header>
</body>
</html>