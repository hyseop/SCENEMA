# SCENEMA
</br>

### 1. 주제
> 영화 커뮤니티
> 
> 영화 정보 조회 및 리뷰, 평점 등 공유

</br>

### 2. 제작 기간
> 프론트: 23.05.04 ~ 05.09
> 
> 백: 23.05.31 ~ 06.05

</br>

### 3. 참여 인원
> 팀장: 김OO
> 
> 팀원: 황윤섭, 채OO, 안OO, 서OO

</br>

### 4. 기술 및 도구
> Java 11, JSP, Spring, Maven, MySQL, MyBatis, eclipse STS3

</br>

### 5. ERD 설계
![](https://github.com/hyseop/SCENEMA/blob/master/SCENEMA%20ERD.png)

</br>

### 6. 담당 파트 기능
> 로그인, 회원가입 등 회원 관련
> 
> > MyBatis Mapper  
> > 🔗[1](https://github.com/hyseop/SCENEMA/blob/master/src/main/java/common/login-mapping.xml), [2](https://github.com/hyseop/SCENEMA/blob/master/src/main/java/common/user-mapping.xml)
> >
> > Spring MVC  
> > 🔗[1](https://github.com/hyseop/SCENEMA/blob/master/src/main/java/controller/LoginController.java), [2](https://github.com/hyseop/SCENEMA/blob/master/src/main/java/controller/MyInfoController.java), [3](https://github.com/hyseop/SCENEMA/blob/master/src/main/java/controller/SignUpController.java), [4](https://github.com/hyseop/SCENEMA/blob/master/src/main/java/dao/LoginDAO.java), [5](https://github.com/hyseop/SCENEMA/blob/master/src/main/java/dao/SignUpDAO.java), [6](https://github.com/hyseop/SCENEMA/blob/master/src/main/java/dto/SignUpDTO.java), [7](https://github.com/hyseop/SCENEMA/blob/master/src/main/java/dto/UserDTO.java), [8](https://github.com/hyseop/SCENEMA/blob/master/src/main/java/service/LoginService.java), [9](https://github.com/hyseop/SCENEMA/blob/master/src/main/java/service/SignUpService.java), [10](https://github.com/hyseop/SCENEMA/blob/master/src/main/java/service/SignUpServiceImpl.java)
> > 
> > JSP, jQuery Ajax/JavaScript  
> > 🔗[1](https://github.com/hyseop/SCENEMA/blob/master/src/main/webapp/WEB-INF/views/MyInfo.jsp), [2](https://github.com/hyseop/SCENEMA/blob/master/src/main/webapp/WEB-INF/views/MyInfoUpdate.jsp), [3](https://github.com/hyseop/SCENEMA/blob/master/src/main/webapp/WEB-INF/views/SignUpForm.jsp), [4](https://github.com/hyseop/SCENEMA/blob/master/src/main/webapp/WEB-INF/views/login.jsp)

</br>

### 7. 회고
> 엉망진창의 나와, 검색 및 수업 예제로 이루어진, 미완성의, 나의 것이 아닌, 첫 프로젝트
>
> > 👎
> > 
> > 기간 및 학습 기술에 비해 가득했던 욕심
> >  
> > 전체 흐름을 놓치고 코드에 끌려다니기 바빴음
> > 
> > 늦은 회고 작성과 늦은 코드 리뷰에 대한 아쉬움
> > 
> > 👍
> > 
> > 서툴고 고된 첫 작업이었지만 작동하는 모습에 느꼈던 성취감
> > 
> > 일부 전공자 팀원들 덕분에 접하게 되었던 여러 툴들 (Git, Figma, ERD) // Git 수업은 미니 프로젝트 종료 후 진행됨
