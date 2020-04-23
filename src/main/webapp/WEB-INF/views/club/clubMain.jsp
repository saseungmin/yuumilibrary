<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/inc/common_header.jsp"%>
<link href="<c:url value='/css/index.css'/>" rel="stylesheet">
<link href="<c:url value='/css/btn.css?dummi=1'/>" rel="stylesheet">
<link href="<c:url value='/css/clubMain.css?dummi=1'/>" rel="stylesheet">

<style type="text/css">
.card-img-top {
    width: 100%;
    height: 15vw;
    object-fit: cover;
}
.col-md-4{

    margin-bottom: 40px;
}
.jumbotron{
	margin-bottom: 0rem;
}
.pagination>li>a { border-radius: 50% !important;margin: 0 5px;}

.page-item.active .page-link{
    background-color: #79d799;
    border-color: #79d799;
}

.page-link{
	color: #79d799;
}

</style>
<title>유미 라이브러리 클럽</title>
</head>
<body>
	<%@include file="/inc/top_menu.jsp"%>
	
	
	
	

		<div class="container-fluid" id="banner-container-fluid" style="display: inline-block; background-image: url('<%=request.getContextPath()%>/image/clubMainBGI.jpg');">
			<div class="container">
				<div class="jumbotron">
				  <h1 class="leader">독서클럽에 참가해보세요!!</h1>
 					  <p><br><h5>※ 주변 지역의 독서클럽에 가입신청을 하거나 직접 클럽을 개설할 수 있습니다!!</h5></p><br>- 서로 마음에 드는 책을
				추천하거나 추천을 받아보세요!! 또는 토익, 공시모임 등 <br>다양한 주제에 맞게 뜻이 맞는 사람들과 함께 할 수 있습니다.<br>- 지금 바로 참여 가능합니다!
				  <p class="lead" style="margin-top: 40px;">
					<c:if test="${not empty sessionScope.USER_INFO.userID}">
						 <a href="<%=request.getContextPath()%>/club/clubForm.lol" class="btn btn-lg dark"><i class="far fa-hand-point-right"></i>클럽 생성하기</a>
					</c:if>
					<c:if test="${empty sessionScope.USER_INFO.userID}">
						<a href="#" id="clubCheck" class="btn btn-lg dark"><i class="far fa-hand-point-right"></i>클럽 생성하기</a>
					</c:if>			  
				  </p>
				</div>
		
			</div>
		</div>


	
	
	
	
	
	<!-- Page Content -->
	<div class="container">

 		<!-- Jumbotron Header -->
<%-- 		<header class="jumbotron my-4" style="background-image: url('<%=request.getContextPath()%>/image/clubMainBGI.jpg');">
			<h4 class="display-3" style="color: white;">독서클럽에 참가해보세요!!</h4>
			<p class="lead" style="color: white;">
				주변 지역의 독서클럽에 가입신청을 하거나 직접 클럽을 개설할 수 있습니다!!<br> 서로 마음에 드는 책을
				추천하거나 추천을 받아보세요!! 또는 토익, 공시모임 등 <br>다양한 주제에 맞게 뜻이 맞는 사람들과 함께 할 수 있습니다.
			</p>
			<c:if test="${not empty sessionScope.USER_INFO.userID}">
				<a href="<%=request.getContextPath()%>/club/clubForm.lol"
					class="btn btn-primary btn-lg">클럽 생성하기</a>
			</c:if>
			<c:if test="${empty sessionScope.USER_INFO.userID}">
				<a href="#" id="clubCheck"
					class="btn btn-primary btn-lg">클럽 생성하기</a>
			</c:if>
		</header>  --%>
		
<!-- 		<div class="col-sm-3  form-inline" style="margin-bottom: 10px"> -->
<%-- 			전체 ${searchVO.totalRowCount} 건  --%>
<!-- 			<select id="id_rowSizePerPage" name="rowSizePerPage" class="form-control input-sm"> -->
<%-- 				<option value="8" ${8 eq searchVO.rowSizePerPage ? 'selected="selected"' : ''}>8</option> --%>
<%-- 				<option value="16" ${16 eq searchVO.rowSizePerPage ? 'selected="selected"' : ''}>16</option> --%>
<!-- 			</select> -->
<!-- 		</div> -->
		
<!-- 		<div class="card text-white bg-secondary my-1 py-1 text-center">
			<div class="card-body">
				<p class="text-white m-0">
				<h4>밑에는 내클럽 보기??? 아니면 추천?? 클럽은 가입신청 후 클럽장 컨펌필요</h4>
				</p>
			</div>
		</div> -->
		
		<div class="container" style="margin-top:30px;">
	<div class="row justify-content-center">
                        <div class="col-12 col-md-10 col-lg-8">
                            <form class="card card-sm" method="post" action="/club/clubMain.lol">
                                <div class="card-body row no-gutters align-items-center" style="padding: 1rem;">
                                    <div class="col-auto">
                                        <i class="fas fa-search text-body"></i>
                                    </div>
                                    <!--end of col-->
                                    <div class="col">
                                        <input class="form-control form-control form-control-borderless" type="search" name="searchWord" placeholder="클럽이름을 검색해보세요!">
                                    </div>
                                    <!--end of col-->
                                    <div class="col-auto">
                                        <button class="btn btn-xs green" type="submit"><i class="fas fa-search"></i>클럽 검색</button>
                                    </div>
                                    <!--end of col-->
                                </div>
                            </form>
                        </div>
                        <!--end of col-->
                    </div>
		</div>
		
		
	<!-- 	<form method="post" action="/club/clubMain.lol">
			<div class="searchBar" style="margin: 0 auto; text-align: center; padding-top: auto;">
				<input type="text" class="form-control" name="searchWord"  placeholder="클럽이름을 검색해보세요!" style="margin-bottom: 20px; width: 30%; margin: 0 auto; display: inline; height: 40px;">
				<input type="submit" class="btn btn-primary" style="margin-bottom: 20px; margin: 0 auto; display: inline; height: 40px;" value="검색">
			</div>
		</form> -->
		
		
<div style="display: grid;">
<section class="details-card">
<hr>
    <div class="container">
        <div class="row">
        <c:forEach items="${list}" var="i" end="8">
            <div class="col-md-4 col-sm-6">
                <div class="card-content">
                    <div class="card-img">
                     <c:choose>
						<c:when test="${empty i.bkImageurl}">
							<img class="card-img-top" src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png" alt="사진을 등록해주세요.">
						</c:when>
						<c:otherwise>
							<img class="card-img-top" src="<%=request.getContextPath()%>/image/clubProfileImg/${i.bkImageurl}" alt="${i.bkClubName}">
						</c:otherwise>
					</c:choose>
                        <span><h4>Heading</h4></span>
                    </div>
                    <div class="card-desc">
                        <h3>${i.bkClubName}</h3>
                        <p>${i.bkTheme}</p>
                           <form action="clubMainView.lol" id="myform" method="post">
							<input type="hidden" name="bkNum" value="${i.bkNum}">
							<input type="hidden" name="cmMemId" value="${sessionScope.USER_INFO.userID}">
<!-- 								<a href="#" class="btn btn-primary" -->
<%-- 									onclick="javascript:document.getElementById('myform').submit();">${i.bkClubName} 바로가기</a> --%>
								<button type="submit" class="btn-card">바로가기</button>
							</form>
                    </div>
                </div>
            </div>
            </c:forEach>

        </div>
    </div>
    <hr>
</section>	
</div>	
		
		
		
		
		
<%-- 		<div class="row text-center">
		<input type="hidden" id="checkLogin" value="${sessionScope.USER_INFO.userID}">
			<c:forEach items="${list}" var="i" end="7">
				<!-- Page Features foreach로 4번 돌리기-->
				<div class="col-lg-3 col-md-6 mb-4">
					<div class="card h-100">
					<c:choose>
						<c:when test="${empty i.bkImageurl}">
							<img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png" alt="사진을 등록해주세요.">
						</c:when>
						<c:otherwise>
							<img class="card-img-top" src="/image/clubProfileImg/${i.bkImageurl}" alt="${i.bkClubName}">
						</c:otherwise>
					</c:choose>
						<div class="card-body">
							<h4 class="card-title">${i.bkClubName}</h4>
							<p class="card-text">${i.bkTheme}</p>
						</div>
						<div class="card-footer">
							<form action="clubMainView.lol" id="myform" method="post">
							<input type="hidden" name="bkNum" value="${i.bkNum}">
							<input type="hidden" name="cmMemId" value="${sessionScope.USER_INFO.userID}">
<!-- 								<a href="#" class="btn btn-primary" -->
									onclick="javascript:document.getElementById('myform').submit();">${i.bkClubName} 바로가기</a>
								<button type="submit" class="btn btn-primary">${i.bkClubName} 바로가기</button>
							</form>
						</div>
					</div>
				</div>
			</c:forEach>
		</div> --%>
<div>		
	<nav aria-label="Page navigation example" style="margin: 20px;">
	  <ul class="pagination justify-content-center">
		  <c:if test="${searchVO.curPage > searchVO.pageSize}">
		    <li class="page-item disabled">
		      <a class="page-link" href="clubMain.lol?curPage=${searchVO.lastPage - searchVO.pageSize}" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		        <span class="sr-only">Previous</span>
		      </a>
		    </li>
		   </c:if>
	    <c:forEach var="i" begin="${searchVO.firstPage}" end="${searchVO.lastPage}">
	    <c:if test="${searchVO.curPage eq i}">
		    <li class="page-item active"><a class="page-link" href="#">${i}</a></li>  
	    </c:if>
	    <c:if test="${searchVO.curPage ne i}">
		    <li class="page-item"><a class="page-link" href="clubMain.lol?curPage=${i}" data-page="${i}">${i}</a></li>
	    </c:if>
	    </c:forEach>  
	    <c:if test="${searchVO.lastPage != searchVO.totalPageCount}">
		    <li class="page-item">
		      <a class="page-link" href="clubMain.lol?curPage=${searchVO.lastPage+1}" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		        <span class="sr-only">Next</span>
		      </a>
		    </li>
		</c:if>
	  </ul>
	</nav>
</div>	
	
	
	
	
	
	</div>
	<hr>
	
	<!-- /.container -->
	<%@include file="/inc/footer.jsp"%>
	<script type="text/javascript">
	$("#clubCheck").on("click",function(){
			swal({
				text: "로그인이 필요합니다",
				icon: "warning",
				confirmButtononText: "확인"
				}).then(function(){
					location.href = "/login/login.lol";
				})
		
	})
	
	
	
	</script>
</body>
</html>