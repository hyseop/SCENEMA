<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link href="resources/css/BoardWriting.css" rel="stylesheet">
<meta charset="UTF-8">
<title>Scenema 커뮤니티 글쓰기</title>
<script src="resources/js/jquery-3.6.4.min.js"></script>
<script src="resources/SmartEditor/js/service/HuskyEZCreator.js"></script>

<script type="text/javascript">
    $(document).ready(function(){
        var oEditors = [];
        nhn.husky.EZCreator.createInIFrame({
            oAppRef: oEditors,
            elPlaceHolder: "boardContent", 
            sSkinURI: "resources/SmartEditor/SmartEditor2Skin.html", 
            fCreator: "createSEditor2",
            htParams: {
                // 툴바 사용 여부 (true: 사용 / false: 사용하지 않음)
                bUseToolbar: true,
                // 입력창 크기 조절바 사용 여부 (true: 사용 / false: 사용하지 않음)
                bUseVerticalResizer: false,
                // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true: 사용 / false: 사용하지 않음)
                bUseModeChanger: false,
                // 페이지 out alert 삭제
                fOnBeforeUnload : function(){}
            },
            fOnAppLoad: function () {
                // 스마트 에디터가 로드되면 실행할 코드 추가
                oEditors.getById["boardContent"].exec("UPDATE_CONTENTS_FIELD", []);
            }
        });
        
        $("#submitButton").on('click', function(e){
            e.preventDefault();
            var title = $("#title").val();
            var userid = $("#userid").val();
            var boardContent = oEditors.getById["boardContent"].getIR();
            var attachment = $("#attachment").val();
            
            if (title === "" || boardContent === "") {
                alert("제목, 내용은 필수 입력 항목입니다.");
            } else {
                $.ajax( {
                    url : "boardwriting",
                    method : "post",
                    data : {
                        "title" : title,
                        "userid" : userid,
                        "boardContent" : boardContent,
                        "attachment" : attachment
                    },
                    success : function(){
                        alert("글이 성공적으로 등록되었습니다.");
                        window.location.href = "/scenema/boardlist";
                       
                    },
                    error : function(){
                        console.log("에러발생");
                    }
                }); // ajax
            }
        });
    });
</script>
</head>
<body>
<%@ include file="Header.jsp" %>
<form action="writingboard" method=post>
	<div id="board">
		<div>
			<h2 id="board_writing">커뮤니티 글쓰기</h2>
		</div>
<!-- 
		<div>
			<label for="boardCategory"></label> <select id="boardCategory"
				name="boardCategory">
				<option value="">선택</option>
				<option value="게시판1">게시판1</option>
				<option value="게시판2">게시판2</option>
				<option value="게시판3">게시판3</option>
				<option value="게시판4">게시판4</option>
			</select>
		</div>
 -->
		<div>
			<label for="userid">작성자 : </label><input type="text" id="userid" value="${userid}" readonly>
		</div>
		<div>
			<label for="title"></label> <input type="text" placeholder="제목"
				id="title" name="title"><br>
		</div>
		<div>
			<textarea id="boardContent" name="boardContent" placeholder="내용"
				rows="10" cols="100" style="width: 100%;"></textarea>
		</div>
		<div>
			<!-- <label for="attachment">첨부파일</label> 
			<input type=file id="attachment" name="attachment" multiple>  -->
			<input type=submit id="submitButton" name="submitButton" value="글쓰기">
		</div>
	</div>
</form>
</body>
<%@ include file="Footer.jsp" %>
</html>