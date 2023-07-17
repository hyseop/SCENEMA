<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="resources/css/BoardListById.css" rel="stylesheet">
<script src="resources/js/jquery-3.6.4.min.js"></script>
<script>
$(document).ready(function(){
	$(".bt_wrap").on('click','#Writing',function(e){
		e.preventDefault();
		let id = "${userid}";
		
		if(id!=""){
			location.href = "/scenema/boardwriting";
		}else{
			let con = confirm("로그인이 필요한 항목입니다.\n로그인 창으로 이동하시겠습니까?");
			if(con){
				location.href = "/scenema/login";
			}
		}
	});
	
	$("#Delete").on('click',function(e){
		e.preventDefault();
		let loginid = "${userid}";
		let writerid = "${BoardListById[0].userid}";
		
		if(confirm('해당 게시물을 삭제하시겠습니까? \n삭제 후에는 복구할 수 없습니다.')){
			$.ajax({
				url:'boarddelete',
				data: {
					'boardid': "${BoardListById[0].boardid}"
				},
				type:'get',
				success:function(res){
					alert("게시물이 삭제되었습니다.");
					location.href = "/scenema/boardlist";
				},
				error:function(request,status,e){
					alert("코드="+request.status+"\n메시지="+request.responseText+"\nerror="+e);
				}
			}); //ajax
		}else{
			alert("게시물 삭제를 취소합니다.");
		}
	});
	
	$("#Update").on('click',function(e){
		e.preventDefault();
		let loginid = "${userid}";
		let writerid = "${BoardListById[0].userid}";
		if(loginid == writerid){
			location.href = "/scenema/boardupdate?boardid="+"${BoardListById[0].boardid}";
		}
	});
})
</script>
</head>
<body>
	<%@ include file="Header.jsp"%>
	<div class="board_view_wrap">
		<div class="board_menu">
			<h2>커뮤니티</h2>
		</div>
		<div class="board_view">
			<c:forEach var="board" items="${BoardListById}">
				<div class="title">${board.title}</div>
				<div class="info">
					<dl>
						<dt>번호</dt>
						<dd id="boardid">${board.boardid}</dd>
					</dl>
					<dl>
						<dt>작성자</dt>
						<dd>${board.userid}</dd>
					</dl>
					<dl>
						<dt>작성일</dt>
						<dd>${board.creatAt}</dd>
					</dl>
					<dl>
						<dt>조회수</dt>
						<dd>${board.boardCount}</dd>
					</dl>
					<%-- <dl>
						<dt>좋아요</dt>
						<dd>${board.boardLike }</dd>
					</dl> --%>
				</div>
			</c:forEach>
			<c:forEach var="board" items="${BoardListById }">
				<div class="cont">${board.boardContent }</div>
			</c:forEach>
		</div>
		<div class="bt_wrap">
			<a href="/scenema/boardlist" class="on" style="text-decoration:none">목록보기</a> 
			<a href="/scenema/boardwriting" id="Writing" style="text-decoration:none">새글쓰기</a> 
			
			<c:if test="${userid==BoardListById[0].userid}">
	 			<a href="" id="Delete" style="text-decoration:none">글삭제</a>
	 			<a href="" id="Update" style="text-decoration:none">글수정</a>
			</c:if>
			
		</div>
		
<!-- 
			<div class="comment-in">
				<input type="text" id="add_comment" placeholder="댓글을 남겨주세요." autocomplete="off"/>
				<button id="addComment">댓글 추가</button>
			</div>
		<c:forEach var="boardComment" items="${BoardCommentById}">
			<div id="comment-list">
				<div id="item" class="item">
					<span id="userid">${boardComment.userid}</span> <span id="bcCreateAt">${boardComment.bcCreateAt}</span>
					<span id="contents">${boardComment.contents}</span>
				</div>
			</div>
		</c:forEach>
-->
	</div>
</body>
<%@ include file="Footer.jsp"%>
</html>