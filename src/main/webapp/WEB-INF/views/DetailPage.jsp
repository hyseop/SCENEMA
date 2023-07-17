<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<link href="resources/css/DetailPage.css" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Sharp:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Sharp:opsz,wght,FILL,GRAD@48,400,0,0" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
<script src="resources/js/jquery-3.6.4.min.js"></script>
<script>
$(document).ready(function() {
	//세부정보 하단 클릭시 구현
	let d_items = [];
	let d_divs = [];
	$('.detail_item').each(function() {
		d_items.push($(this).attr('id'));
	});
	$('.detail_divs').each(function() {
		d_divs.push($(this).attr('id'));
	});

	$('#ditem1,#ditem2').click(function() {
		let itemNum = $(this).attr('id').slice(-1);
		for (i = 0; i < 3; i++) {
			let str = d_divs[i];
			if ($(this).attr('id') == d_items[i]) {
				$("#" + d_items[i]).css({
					'border' : '1px solid #FF7322',
					'border-bottom-width' : '0px',
					'color' : '#FF7322'
				});
				$("#" + d_divs[i]).show();
			} else {
				if (i < itemNum) {
					$("#" + d_items[i]).css({
						'border-top' : '1px solid lightgrey',
						'border-left' : '1px solid lightgrey',
						'border-bottom' : '1px solid #FF7322',
						'border-right' : '1px solid transparent',
						'color' : 'black'
					});
				} else {
					$("#" + d_items[i]).css({
						'border-top' : '1px solid lightgrey',
						'border-left' : '1px solid transparent',
						'border-right' : '1px solid lightgrey',
						'border-bottom' : '1px solid #FF7322',
						'color' : 'black'
					});
				}
				$("#" + d_divs[i]).hide();
			}
		}
	});//end div_items click;
	
	//슬라이드 페이지버튼
	$('.slider > .page-btns > div').click(function(){
		 let $this = $(this);
		 let index = $this.index();
		 
		 $this.addClass('active');
		 $this.siblings('.active').removeClass('active');
		 
		 let $slider = $this.parent().parent();
		 
		 let $current = $slider.find(' > .slides > div.active');
		 
		 let $post = $slider.find(' > .slides > div').eq(index);
		 
		 $current.removeClass('active');
		 $post.addClass('active');
	});

	//좌/우 버튼 추가 슬라이더
	$('.slider > .side-btns > div').click(function(){
		 let $this = $(this);
		 let $slider = $this.closest('.slider');
		 
		 let index = $this.index();
		 let isLeft = index == 0;
		 
		 let $current = $slider.find(' > .page-btns > div.active');
		 let $post;
		 
		 if ( isLeft ){ $post = $current.prev();  }
		 else { $post = $current.next();};
		 
		 if ( $post.length == 0 ){
		     if ( isLeft ){
		         $post = $slider.find(' > .page-btns > div:last-child');
		     }
		     else {
		         $post = $slider.find(' > .page-btns > div:first-child');
		     }
		 };
		 $post.click();
		});

	// 별점 드래그
	$('.rating input').on('input', function(){
		let val = $('.rating input').val();
		let str = val*20+"%";
		
		$('.rating_star').css("width",str)
		$('.rating_star').css('overflow','hidden');
		$('.rating_txt').html(val*2);
	})
	
	//영화 좋아요버튼
	$('#movielikediv').on('click','#movielike',function(){
		let sessionid = "${userid}";
		if(sessionid != ""){
			$.ajax({
				url:'movielike',
				data: {
					'movieid':${movie.movieid}
				},
				type:'get',
				dataType:'json',
				success:function(res){
					$('#movielikediv').load(location.href+' #movielikediv');
				},
				error:function(request,status,e){
					alert("코드="+request.status+"\n메시지="+request.responseText+"\nerror="+e);
				}
			}); //ajax
		}else{
			alert("로그인 후 좋아요 기능을 이용할 수 있습니다.");
		}
		
	});
	
	//관람평 입력시 길이제한
	$('#txtbox').keyup(function(){
		let txtlen = $(this).val().length;
		
		$('#txtbox').off('click'); 
		$('#txtlen').html("("+txtlen+" / 200)");
		
		if(txtlen>200){
			$(this).val($(this).val().substring(0, 200));
			$('#txtlen').html("(200 / 200)");
		}
	});
	
	$("#txtbox_readonly").click(function(){
		let islogin = confirm("로그인이 필요한 항목입니다. 로그인 창으로 이동하시겠습니까?");
		
		if(islogin){
			location.href = "/scenema/"
		}
	});
	
	//관람평 등록 버튼 클릭
	$('#comment_write').click(function(){
		//관람평 내용 불러오기
		let txtbox = $('#txtbox');
		let review = txtbox.val(); //관람평내용
		
		if(review == ""){
			alert("관람평을 작성해 주세요.");
		}else{
			//텍스트박스 초기화
			txtbox.val("");
			$('#txtlen').html("(0 / 200)");
			
			//MovieComment db저장하기
			$.ajax({
				url:'commentinsert',
				data: {
					'movieid':${movie.movieid},
					'score': $('#score').val()*2,
					'contents':review
				},
				type:'get',
				dataType:'json',
				success:function(res){
					$('#cmt_list').load(location.href+' #cmt_list');
					$('#cmts_cnt').load(location.href+' #cmts_cnt');
					$('#titleBottom').load(location.href+' #titleBottom');
					$('#page_btns_box').load(location.href+' #page_btns_box');
				},
				error:function(request,status,e){
					alert("코드="+request.status+"\n메시지="+request.responseText+"\nerror="+e);
				}
			}); //ajax
		}//else
	});
	
	//관람평 삭제 버튼
	$('#cmt_list').on('click','button[class=delete_btn]',function(){
		if(confirm('해당 관람평을 삭제하시겠습니까? \n삭제 후에는 복구할 수 없습니다.')){
			//MovieComment 삭제하기
			$.ajax({
				url:'commentdelete',
				data: {
					'movieid':${movie.movieid},
					'moviecommentid':$(this).parents(".cmt").attr('id')
				},
				type:'get',
				success:function(res){
					$('#cmt_list').load(location.href+' #cmt_list');
					$('#cmts_cnt').load(location.href+' #cmts_cnt');
					$('#titleBottom').load(location.href+' #titleBottom');
					$('#page_btns_box').load(location.href+' #page_btns_box');
				},
				error:function(request,status,e){
					alert("코드="+request.status+"\n메시지="+request.responseText+"\nerror="+e);
				}
			}); //ajax
		}
	});
	
	//관람평 좋아요 버튼
	$('#cmt_list').on('click','button[class=good_btn]',function(){
		let sessionid = "${userid}";
		if(sessionid != ""){
			$.ajax({
				url:'moviecommentlike',
				data: {
					'moviecommentid':$(this).parents(".cmt").attr('id')
				},
				type:'get',
				dataType:'json',
				success:function(res){
					$('#cmt_list').load(location.href+' #cmt_list');
				},
				error:function(request,status,e){
					alert("코드="+request.status+"\n메시지="+request.responseText+"\nerror="+e);
				}
			}); //ajax
		}else{
			alert("로그인 후 좋아요 기능을 이용할 수 있습니다.");
		}
	});
	
	
	//관람평 페이징 버튼
	//숫자버튼
	$("#page_btns_box").on('click','.pagebtn_num',function(){
		$(this).siblings().css({
			'background-color': 'transparent',
			'border' : '1px solid lightgrey',
			'color' : 'black'
		});
		$(this).css({
			'background-color': '#FF7322',
			'border' : '1px solid #FF7322',
			'color' : 'white'
		});
		
		$.ajax({
			url:'commentpaging',
			data: {
				'page': $(this).html()
			},
			type:'get',
			dataType:'json',
			success:function(res){
				$('#cmt_list').load('/scenema/detailpage?movieid='+${movie.movieid}+'&page='+res.page+' #cmt_list');
			},
			error:function(request,status,e){
				alert("코드="+request.status+"\n메시지="+request.responseText+"\nerror="+e);
			}
		}); //ajax
	});
	
	//첫페이지( << ) 버튼
	$("#page_btns_box").on('click','#pageFirstbtn',function(){
		$.ajax({
			url:'commentpaging',
			data: {
				'page': 1
			},
			type:'get',
			dataType:'json',
			success:function(res){
				$('#cmt_list').load('/scenema/detailpage?movieid='+${movie.movieid}+'&page='+res.page+' #cmt_list');
				$('#page_btns_box').load('/scenema/detailpage?movieid='+${movie.movieid}+'&page='+res.page+' #page_btns_box');
			},
			error:function(request,status,e){
				alert("코드="+request.status+"\n메시지="+request.responseText+"\nerror="+e);
			}
		}); //ajax
	});
	
	//마지막페이지( >> ) 버튼
	$("#page_btns_box").on('click','#pageLastbtn',function(){
		$.ajax({
			url:'commentpaging',
			data: {
				'page': ${maxpage}
			},
			type:'get',
			dataType:'json',
			success:function(res){
				$('#cmt_list').load('/scenema/detailpage?movieid='+${movie.movieid}+'&page='+res.page+' #cmt_list');
				$('#page_btns_box').load('/scenema/detailpage?movieid='+${movie.movieid}+'&page='+res.page+' #page_btns_box');
			},
			error:function(request,status,e){
				alert("코드="+request.status+"\n메시지="+request.responseText+"\nerror="+e);
			}
		}); //ajax
	});

	//다음페이지( > ) 버튼 #pageNextbtn
	$("#page_btns_box").on('click','#pageNextbtn',function(){
		$.ajax({
			url:'commentpagingnext',
			data: {
				'page': $(this).prev().html(),
				'maxpage': ${maxpage}
			},
			type:'get',
			dataType:'json',
			success:function(res){
				$('#cmt_list').load('/scenema/detailpage?movieid='+${movie.movieid}+'&page='+res.startpage+' #cmt_list');
				$('#page_btns_box').load('/scenema/detailpage?movieid='+${movie.movieid}+'&page='+res.startpage+' #page_btns_box');
			},
			error:function(request,status,e){
				alert("코드="+request.status+"\n메시지="+request.responseText+"\nerror="+e);
			}
		}); //ajax
	});
	
	//이전페이지( < ) 버튼 #pagePrevbtn
	$("#page_btns_box").on('click','#pagePrevbtn',function(){
		$.ajax({
			url:'commentpagingprev',
			data: {
				'page': $(this).next().html()
			},
			type:'get',
			dataType:'json',
			success:function(res){
				$('#cmt_list').load('/scenema/detailpage?movieid='+${movie.movieid}+'&page='+res.startpage+' #cmt_list');
				$('#page_btns_box').load('/scenema/detailpage?movieid='+${movie.movieid}+'&page='+res.startpage+' #page_btns_box');
			},
			error:function(request,status,e){
				alert("코드="+request.status+"\n메시지="+request.responseText+"\nerror="+e);
			}
		}); //ajax
	});
	
});//end ready
</script>
<meta charset="UTF-8">
<title>Scenema DetailPage</title>
</head>
<body>
	<%@ include file="Header.jsp" %>
	<% session.setAttribute("currentpage", 1); %>

	<div id='imgback' style="background: linear-gradient(to right, rgba(20, 20, 20, 1) 20%,
		rgba(20, 20, 20, 0.75) 35%, rgba(20, 20, 20, 0.7) 50%,
		rgba(20, 20, 20, 0.75) 65%, rgba(20, 20, 20, 1) 100%),
		url('${stillcuts[0]}'); background-size: cover;" >
		<div id='imgs'>
			<div id="poster" style="width: 300px; height: 450px;">
				<img src="${posters[0]}"
					style="width: 300px; height: 390px; border-radius: 10px;">
				<button>현재 상영 중</button>
			</div>
			<!-- 포스터영역 -->
			<div id="movietitle" style="width: 650px; height: 450px;">
				<div id='titleTop' style="margin-bottom: 210px">
					<h1 style="font-size: 40px; margin-top: 30px; margin-bottom: 5px">${movie.title}</h1>
					<h1 style="font-size: 20px">${movie.titleEng}</h1>
					<div id='movielikediv'>
						<c:if test="${ismovielike==0}">
							<button id='movielike'>♥ ${movie.movielike+movielikecount}</button>
						</c:if>
						<c:if test="${ismovielike!=0}">
							<button id='movielike' style="background-color: white; color: #EA2649">♥ ${movie.movielike+movielikecount}</button>
						</c:if>
					</div>
				</div>
				<!-- 포스터 영역 -->

				<div id='titleBottom'>
					<div style="width: 130px; height: 80px;">
						<h1 style="font-size: 15px; margin-bottom: 5px;">실관람 평점</h1>
						<div style="display: flex; align-items: center; margin: 10px 0px;">
							<img src="resources/detail_imgs/star_orange.png" style="width: 24px; height: 24px;">
							<span style="font-size: 30px; color: #FF7322; margin-left: 5px;">${movieScore}</span>
						</div>
					</div>
					<div style="width: 160px; height: 80px;">
						<h1 style="font-size: 15px; margin-bottom: 5px;">누적 리뷰수</h1>
						<div style="display: flex; align-items: center; margin: 10px 0px;">
							<img src="resources/detail_imgs/customer-review.png" style="width: 24px; height: 24px;">
							<div id="review_cnt" style="font-size: 30px; color: white; margin-left: 10px; width:50px">${commentsCount}</div>
						</div>
					</div>
				</div>
				<!-- 텍스트 영역 -->
			</div>
			<!-- 제목 영역 -->
		</div>
		<!-- 이미지영역 div -->
	</div>
	<!-- 이미지영역 배경 div -->

	<div id='details'>
		<div style='background-color: white; height: 80px'>
			<ul id='detail_list'>
				<li class='detail_item' id='ditem1' value='detail_div1'>영화정보</li>
				<li class='detail_item' id='ditem2' value='detail_div2'>관람평</li>
			</ul>
		</div><!-- list div -->

		<div style='margin-left: 8px;'>
			<div class='detail_divs' id='detail_div1' style='display: block;'>
				<p style='font-size: 18px; margin: 30px auto; line-height: 35px; word-wrap:break-word;'>${movie.story}</p>
				<p style='font-size: 17px; display: inline; line-height: 25px;'>◦ 장르 : ${movie.genre}</p>
				<p style='font-size: 17px; display: inline; line-height: 25px; margin-left: 10px; padding-left: 10px; border-left: 1px solid lightgrey;'>
					개봉 : ${movie.releaseDate}</p>
				<p style='font-size: 17px; display: inline; line-height: 25px; margin-left: 10px; padding-left: 10px; border-left: 1px solid lightgrey;'>
					상영시간 : ${movie.runtime}분</p>
				<p style='font-size: 17px; line-height: 25px; margin: 7px 0px;'>◦ 감독 : ${movie.director}</p>
				<p style='font-size: 17px; line-height: 25px; margin: 7px 0px;'>◦ 등급 : ${movie.rating}</p>

				<div id='videoDiv;' style='margin-top: 40px;'>
					<p style='font-size: 18px; display: inline'>⧉ 트레일러</p>
					<div class="slider" style='margin-top: 15px; height:670px;'>
					    <div class="slides">
					        <div class="active">
					        	<p>트레일러(1/${fn:length(videos)})</p>
					        	<video controls><source src="${videos[0]}" type="video/mp4"></video>
					        </div>
					        <!-- 비디오 슬라이드 반복문 -->
					       	<c:forEach items="${videos}" var="video" varStatus="vs" begin="1">
						        <div> 
						        	<p>트레일러(${vs.index+1}/${fn:length(videos)})</p>
							        <video controls> <source src="${videos[vs.index]}" type="video/mp4"> </video>
						        </div>
					       	</c:forEach>
					    </div><!-- video slides -->
					    <div class="page-btns" style="display :none;">
					        <div class="active"></div>
					        <c:forEach items="${videos}" var="video" varStatus="vs" begin="1">
						        <div></div>
					       	</c:forEach>
					    </div><!-- page-btns -->
					    <div class="side-btns" >
					        <div style="height:53px">
					            <span class="material-symbols-sharp">chevron_left</span>
					        </div>
					        <div style="height:53px">
					            <span class="material-symbols-sharp">chevron_right</span>
					        </div>
					    </div><!-- side-btns -->
					</div> <!-- video slider -->
				</div>
				<div id='imageDiv' style='margin-top: 5px;'>
					<p style='font-size: 18px; display: inline'>⧉ 포스터·스틸컷</p>
					<div class="slider" style='margin-top: 15px; border:1px solid lightgrey;'>
						<div class="slides">
							<div class="active"	style="background-image: url('${posters[0]}'); background-size: contain"></div>
							<!-- 이미지 슬라이드 반복문 -->
							<c:forEach items="${posters}" var="video" varStatus="vs" begin="1">
								<div style="background-image: url('${posters[vs.index]}'); background-size: contain"></div>
							</c:forEach>
						</div>
						<div class="page-btns">
							<div class="active"></div>
							<c:forEach items="${posters}" var="video" varStatus="vs" begin="1">
						        <div></div>
					       	</c:forEach>
						</div>
						<div class="side-btns">
							<div>
								<span class="material-symbols-sharp">chevron_left</span>
							</div>
							<div>
								<span class="material-symbols-sharp">chevron_right</span>
							</div>
						</div>
					</div>
				</div><!-- imgdiv -->
			</div><!-- div1 -->
			
			<div class='detail_divs' id='detail_div2'>
				<p style='font-size: 18px; margin-top: 30px; text-align: center;'>
					평점·관람평 작성</p>
				<!-- rating_box -->	
				<div class="rating_box">
					<div class="rating"> ★★★★★ <span class="rating_star">★★★★★</span>
						<input id='score' type="range"	step="0.5" min="0.5" max="5" value="5">
					</div>
					<div class="rating_txt">10</div>
				</div>
				
				<!-- writing_box -->
				<div class="writing_box">
					<c:if test="${empty userid}">
					<div>
						<textarea id='txtbox_readonly' readonly="readonly" placeholder="회원로그인 후 관람평을 작성할 수 있습니다."></textarea>
						<p id='txtlen'>(0 / 200)</p>
					</div>
					</c:if>
					<c:if test="${!empty userid}">
					<div>
						<textarea id='txtbox' placeholder="평점 및 영화 관람평을 작성해 주세요. 평점은 마우스 드래그 및 클릭을 통해 변경 가능합니다.&#10;권리침해, 욕설 및 특정 대상을 비하하는 내용을 게시할 경우 해당 게시글은 무통보 삭제되며 이용약관 및 법률에 의해 처벌될 수 있습니다."></textarea>
						<p id='txtlen'>(0 / 200)</p>
					</div>
					</c:if>
					<button id='comment_write'> 관람평 작성 </button>
				</div><!-- writing_box -->
				
				<!-- comment_box -->
				<div class="comment_box">
					<p> 
						<span>
							<span style="color:#FF7322;">★</span> 
							<span>관람객 관람평</span>
						</span>
						<span>
							<span style="padding-right:5px" id="cmts_cnt">총 ${commentsCount}건</span>
							<span style="border-left:1px solid lightgrey; padding-left:5px">최신순</span>
						</span>
					</p>
					
					<div id=cmt_list>
						<c:if test="${empty comments}">
							<p style="width:100%; height:100px; line-height: 100px; color: #FF7322; text-align:center; font-size:25px;">
							작성된 관람평이 없습니다. 첫 관람평을 작성해 주세요! </p>
						</c:if>
					
						<c:forEach items="${comments}" var="comment" varStatus="vs">
							<div class="cmt" id='${comment.movieCommentid}'>
								<span>${comment.userid}</span>
								<span><span class="cmt_star1">★★★★★<span class="cmt_star2" style="width:${comment.score*10}%">★★★★★</span></span><span class='cmt_score'>${comment.score}</span></span>
								<span><span>${comment.contents}</span></span>
								<span><span>${comment.createAt}</span></span>
								<c:if test="${comment.userid == userid}"> 
									<span><button class="delete_btn"><span class="material-symbols-sharp">delete</span></button></span>
								</c:if>
								<c:if test="${comment.userid != userid}">
									<c:if test="${comment.hate == 0}">
										<span>
										<button class="good_btn"><span class="material-symbols-sharp">thumb_up</span>
										<br>
										<span class="good_btn_like">${comment.like}</span>
										</button>
										</span>
									</c:if>
									<c:if test="${comment.hate != 0}">
										<span>
										<button class="good_btn" style="color:#FF7322">
										<span class="material-symbols-sharp" style="font-variation-settings:'FILL' 1, 'wght' 400,'GRAD' 0,'opsz' 40 ">thumb_up</span>
										<br>
										<span class="good_btn_like">${comment.like}</span>
										</button>
										</span>
									</c:if>
								</c:if>
							</div>
						</c:forEach>
					</div><!-- cmt_list -->
				
				</div><!-- comment_box -->
				
				<div id="page_btns_box">
					<button class='pagebtn' id='pageFirstbtn'><span class="material-symbols-outlined">keyboard_double_arrow_left</span></button>
					<button class='pagebtn' id='pagePrevbtn'><span class="material-symbols-outlined">keyboard_arrow_left</span></button>
					<c:forEach begin="${currentpage}" end="${currentpage+9>maxpage?maxpage:currentpage+9}" varStatus="vs">
						<c:if test="${vs.index==currentpage}">
							<button class='pagebtn_num' id='pagebtn${vs.index}' style="background-color: #FF7322; border:1px solid #FF7322; color: white;">${vs.index}</button>
						</c:if>
						<c:if test="${vs.index!=currentpage}">
							<button class='pagebtn_num' id='pagebtn${vs.index}'>${vs.index}</button>
						</c:if>
					</c:forEach>
					<button class='pagebtn' id='pageNextbtn'><span class="material-symbols-outlined">keyboard_arrow_right</span></button>
					<button class='pagebtn' id='pageLastbtn'><span class="material-symbols-outlined">keyboard_double_arrow_right</span></button>
				</div>
			</div>	<!-- div2 -->
		</div><!-- div1 / 2 영역 -->
	</div><!-- 세부영역 -->

	<%@ include file="Footer.jsp" %>
</body>
</html>