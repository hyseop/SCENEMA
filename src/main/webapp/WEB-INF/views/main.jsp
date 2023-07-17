<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>SCENEMA</title>
<link rel="stylesheet" href="resources/css/mainpage.css">
<script src="resources/js/jquery-3.6.4.min.js"></script>
<script>
        // 전역 변수 선언
        var slideIndex = 1;
        var timer;

        // 페이지 로드 시 함수 실행
        window.onload = function() {
            showSlides(slideIndex);
         // 5초마다 자동으로 슬라이드 이동
            timer = setInterval(function() {plusSlides(1)}, 5000); 
        }

        // 현재 슬라이드에서 +/- n 슬라이드로 이동하는 함수
        function plusSlides(n) {
            showSlides(slideIndex += n);
        }

        // 현재 슬라이드에서 특정 슬라이드로 이동하는 함수
        function currentSlide(n) {
            showSlides(slideIndex = n);
        }

        // 슬라이드를 보여주는 함수
        function showSlides(n) {
            var i;
            var slides = document.getElementsByClassName("mySlides");
            var dots = document.getElementsByClassName("dot");
            if (n > slides.length) {slideIndex = 1}
            if (n < 1) {slideIndex = slides.length}
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            for (i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace(" active", "");
            }
            slides[slideIndex-1].style.display = "block";
            dots[slideIndex-1].className += " active";
        }

        // 마우스가 슬라이드 위에 있을 때 타이머 멈추기
        function pauseTimer() {
            clearInterval(timer);
        }

        // 마우스가 슬라이드 밖으로 나갈 때 타이머 다시 시작
        function resumeTimer() {
            timer = setInterval(function() {
                plusSlides(1)
            }, 5000); // 5초마다 자동으로 슬라이드 이동
        }
</script>
</head>
<body>
	<%@ include file="Header.jsp"%>

	<div class="slideshow-container">
		<div class="mySlides fade">
			<img src="resources/pic/movie1.png" style="width: 100%">
			<div class="text">가디언즈 오브 갤럭시 vol3</div>
		</div>

		<div class="mySlides fade">
			<img src="resources/pic/movie2.png" style="width: 100%">
			<div class="text">슈퍼 마리오 브라더스</div>
		</div>

		<div class="mySlides fade">
			<img src="resources/pic/movie3.png" style="width: 100%">
			<div class="text">극장판 짱구는 못말려: 동물소환 닌자 배꼽수비대</div>
		</div>

		<a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a class="next"
			onclick="plusSlides(1)">&#10095;</a>
	</div>

	<div class="products">
		<p id="boxtitle" style="border-width:0px; margin:15px auto; margin-top:30px; font-size: 40px;">
			일일 박스오피스 <span style="color:#FF7322;">Top10</span></p>
		<p>*전일 기준</p>
		<div class='products_box'>
			<c:forEach items="${boxofficelist}" var="list" varStatus="vs" end="4" >
				<div class="image-container">
					<p class="rank">${vs.index+1}<p>
					<a href="detailpage?movieid=${boxofficelist[vs.index].movieid}"> 
						<span><img src="${boxofficelist[vs.index].posterurl}"></span>
					</a>
					<p class="title" style="word-break:break-all">${boxofficelist[vs.index].title}<p>
				</div>
			</c:forEach>
		</div>
		<div class='products_box'>
			<c:forEach items="${boxofficelist}" var="list" varStatus="vs" begin="5" >
				<div class="image-container">
					<p class="rank">${vs.index+1}<p>
					<a href="detailpage?movieid=${boxofficelist[vs.index].movieid}"> 
						<span><img src="${boxofficelist[vs.index].posterurl}"></span>
					</a>
					<p class="title" style="word-break:break-all">${boxofficelist[vs.index].title}<p>
				</div>
			</c:forEach>
		</div>
	</div>
	<%@ include file="Footer.jsp"%>
</body>
</html>

