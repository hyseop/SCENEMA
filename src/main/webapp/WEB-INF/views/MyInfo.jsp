<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/MyInfo.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Sharp:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Sharp:opsz,wght,FILL,GRAD@48,400,0,0" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
</head>
<script src="resources/js/jquery-3.6.4.min.js"></script>
<script>
$(document).ready(function(){
	$("#UserUpdateButton").on('click',function(){
		location.href = "/scenema/updateuser"		
	});
	
	$("#deleteUser").on('click',function(){
		if(confirm("정말로 회원탈퇴하시겠습니까?\n탈퇴 시 데이터는 복구되지 않습니다.")){
			$.ajax({
				url:'deleteuser',
				data: {
					'userid':"${userid}"
				},
				type:'get',
				success:function(res){
					alert("회원탈퇴되었습니다. 안녕히 가세요.");
					location.href = "/scenema/logout";
				},
				error:function(request,status,e){
					alert("코드="+request.status+"\n메시지="+request.responseText+"\nerror="+e);
				}
			}); //ajax
		}else{
			alert("회원탈퇴를 취소합니다.");
		}
	});//delete user
	
	$("#likemovies").on('click','button',function(){
		if(confirm("좋아요를 취소하시겠습니까?\n취소 후 해당 영화 상세페이지에서 다시 좋아요를 누를 수 있습니다.")){
			$.ajax({
				url:'movieunlike',
				data: {
					'userid':"${userid}",
					'movieid':$(this).attr('id')
				},
				type:'get',
				success:function(res){
					alert("좋아요를 취소하였습니다.");
					$('#likemovies').load(location.href+' #likemovies');
				},
				error:function(request,status,e){
					alert("코드="+request.status+"\n메시지="+request.responseText+"\nerror="+e);
				}
			}); //ajax
		}else{	}
	});//movieunlike
	
});
</script>
<body>
<%@ include file="Header.jsp" %>

<article>
	<h2>내 정보</h2>
		<table id='myinfo'>
		<tr><td>아이디</td><td>${loginUser.userid}</td></tr>
		<tr><td>이름</td><td>${loginUser.name}</td></tr>
		<tr><td>휴대폰번호</td><td>${loginUser.phone}</td></tr>
		<tr><td>이메일</td><td>${loginUser.email}</td></tr>
		<tr><td>정보 수정 및 탈퇴</td><td><button type="button" id="UserUpdateButton">회원정보수정</button><button id="deleteUser">회원탈퇴</button></td></tr>
		</table>
	
	<h2>내가 좋아요한 영화</h2>
	<table id='likemovies' style="margin:0px auto;">
	<c:if test="${!empty movieDBlist}">
		<c:forEach items="${movieDBlist}" var="movie" end='9'>
			<tr><td>${movie.title}</td><td>
			<button id='${movie.movieid}' >
				<span class="material-symbols-sharp" style="font-variation-settings:'FILL' 1, 'wght' 400,'GRAD' 0,'opsz' 40 ">thumb_up</span>
				<span>해제</span>
			</button></td></tr>
		</c:forEach>
		<tr><td colspan='2'><a id='total' href="movietotallike?userid=${loginUser.userid}">전체보기</a></td></tr>
	</c:if>
	<c:if test="${empty movieDBlist}">
		<tr><td colspan='2'><a>좋아요를 누른 영화가 없습니다. 관심있는 영화에 좋아요를 눌러보세요!</a></td></tr>
	</c:if>
	</table>
	
</article>

<%@ include file="Footer.jsp" %>
</body>
</html>