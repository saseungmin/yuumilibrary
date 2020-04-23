<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<div class="small-top">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 date-sec">
        		<div id="Date"></div>
     		</div>
            <div class="col-lg-3 offset-lg-5">
		        <div class="social-icon"> <a target="_blank" href="#"><i class="fab fa-facebook-f"></i></a> 
		        						  <a target="_blank" href="#"><i class="fab fa-twitter"></i></a> 
		        						  <a target="_blank" href="#"><i class="fab fa-google-plus-g"></i></a> 
		        						  <a target="_blank" href="#"><i class="fab fa-git"></i></a> 
		        						  <a target="_blank" href="#"><i class="fab fa-youtube"></i></a> 
		        </div>
      		</div>
        </div>
    </div>
</div>


  <div class="top-head left">
    <div class="container">
      <div class="row">
        <div class="col-md-6 col-lg-4">
                <h1><a href="/" id="title">Yuumi Library</a><small>도서 검색 시스템</small></h1>
        </div>
        <div class="col-md-6 col-lg-3 ml-auto admin-bar hidden-sm-down">
	          <nav class="nav nav-inline"> 
             	<c:if test="${empty sessionScope.USER_INFO}">
                	<a href="<%=request.getContextPath() %>/login/login.lol" class="nav-link"><i class="fas fa-sign-in-alt"></i>로그인</a>
              		<a href="<%=request.getContextPath()%>/member/memberForm.lol" class="nav-link"><i class="fas fa-user-plus"></i>회원가입</a> 
                </c:if>
                

                <c:if test="${not empty sessionScope.USER_INFO}">
                 	<a href="<%=request.getContextPath()%>/member/memberView.lol?memId=${sessionScope.USER_INFO.userID}" class="nav-link" aria-haspopup="true"  aria-expanded="false"><i class="fa fa-cog fa-spin fa-fw" aria-hidden="true"> </i>${sessionScope.USER_INFO.userID}님</a>
	   	            <a href="<%=request.getContextPath()%>/login/logout.lol"  class="nav-link"><i class="fa fa-sign-out" aria-hidden="true"> </i>&nbsp;로그아웃</a>
                </c:if>
                
	          </nav>
         </div>
       </div>
     </div>
  </div>
  
  <!--  탑 메뉴 -->
	<section class="top-nav">
	    <nav class="navbar navbar-expand-lg py-0">
	        <div class="container">
	    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	    <div class="collapse navbar-collapse" id="exCollapsingNavbar2">
	        <ul class="nav navbar-nav ">
		      <li class="nav-item"> <a class="nav-link" href="/library/libraryList.lol">도서관 정보</a> </li>
		      <li class="nav-item"> <a class="nav-link" href="<%=request.getContextPath()%>/book/bookList.lol">도서 검색</a> </li>
		      <li class="nav-item"> <a class="nav-link" href="<%=request.getContextPath()%>/club/clubMain.lol">독서 클럽</a> </li>
		      <li class="nav-item dropdown">
		        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          	게시판
		        </a>
		        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
		          <a class="dropdown-item" href="<%=request.getContextPath()%>/free/freeList.lol">자유 게시판</a>
		          <a class="dropdown-item" href="<%=request.getContextPath()%>/qna/qnaList.lol">Q&amp;A</a>
<%-- 		          <div class="dropdown-divider"></div>
		          <a class="dropdown-item" href="<%=request.getContextPath()%>/club/clubBoardList.lol?cbBoClubNum=77">임시클럽게시판(클럽넘버77)</a>
		          <a class="dropdown-item" href="<%=request.getContextPath()%>/club/clubBoardList.lol?cbBoClubNum=33">도다른클럽게시판(클럽넘버33)</a>
		          <a class="dropdown-item" href="<%=request.getContextPath()%>/club/clubMain.lol">(개발중)클럽메인</a>
		          <a class="dropdown-item" href="<%=request.getContextPath()%>/club/clubSmallMain.lol">(개발중)클럽세부메인</a>
		        </div> --%>
		      </li>
		      
		      <c:if test="${not empty sessionScope.USER_INFO}">
		      	  <li class="nav-item"> <a class="nav-link" href="<%=request.getContextPath()%>/book/loanList.lol?memId=${sessionScope.USER_INFO.userID}">My도서</a> </li>
		      </c:if>
		      
 		      <c:if test="${sessionScope.USER_INFO.userRole.equals('관리자')}">
	 		      <li><a class="nav-link" href="<%=request.getContextPath()%>/book/allLoanList.lol">전체회원대출현황</a></li>
			      <li class="nav-item"> <a class="nav-link" href="<%=request.getContextPath()%>/member/memberList.lol">회원관리</a> </li>
			      <%-- <li class="nav-item"> <a class="nav-link" href="<%=request.getContextPath()%>/club/clubList.lol">전체클럽목록</a> </li> --%>
		      </c:if>	
      		</ul>
      		

	      
	    </div>
	  </div>
	      </nav>
	      
	</section>