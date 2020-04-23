<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <%@include file="/inc/common_header.jsp" %>
 	<link href="<c:url value='/css/login.css'/>" rel="stylesheet">
 
</head>
<body>
 <%@include file="/inc/top_menu.jsp" %>

 			<section class="login-block">
				<div class="container">
					<div class="row" id="loginrow">
						<div class="col-md-4 login-sec">
							<h2 class="text-center">Login Now</h2>
							<form class="login-form" action="<%=request.getContextPath()%>/login/login.lol" method="post" onsubmit="return logincheck();">
								<div class="form-group" >
									<label for="memId" class="text-uppercase">Username</label>
									<input type="text" class="form-control" name="memId" id="memId" placeholder="사용자 아이디">

								</div>
								<div class="form-group">
									<label for="memPass" class="text-uppercase">Password</label>
									<input type="password" class="form-control" id="memPass" name="memPass" placeholder="비밀번호">
								</div>


								<div class="form-check">
									<label class="form-check-label"> <input type="checkbox"
										class="form-check-input"  name="idRemember" id="idRemember"><small>Remember Me</small>
									</label>
									<button type="submit" class="btn btn-login float-right">Submit</button>
								</div>
								<p class="text-muted small" style="margin-top: 5px;"> 
									<i class="fas fa-check"></i>아직 회원이 아니십니까? <a href="<%=request.getContextPath() %>/member/memberForm.lol">회원가입</a>
								</p>
							</form>
							<div class="copy-text">
								Created with <i class="fa fa-heart"></i> by <a
									href="#">4MI</a>
							</div>
						</div>
						<div class="col-md-8 banner-sec">
							<div id="carouselExampleIndicators" class="carousel slide"
								data-ride="carousel">
								<ol class="carousel-indicators">
									<li data-target="#carouselExampleIndicators" data-slide-to="0"
										class="active"></li>
									<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
									<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
								</ol>
								<div class="carousel-inner" role="listbox">
									<div class="carousel-item active">
										<img class="d-block img-fluid"
											src="https://static.pexels.com/photos/33972/pexels-photo.jpg"
											alt="First slide">
										<div class="carousel-caption d-none d-md-block">
											<div class="banner-text">
												<h2>This is Heaven</h2>
												<p>Lorem ipsum dolor sit amet, consectetur adipiscing
													elit, sed do eiusmod tempor incididunt ut labore et dolore
													magna aliqua. Ut enim ad minim veniam, quis nostrud
													exercitation</p>
											</div>
										</div>
									</div>
									<div class="carousel-item">
										<img class="d-block img-fluid"
											src="https://images.pexels.com/photos/7097/people-coffee-tea-meeting.jpg"
											alt="First slide">
										<div class="carousel-caption d-none d-md-block">
											<div class="banner-text">
												<h2>This is Heaven</h2>
												<p>Lorem ipsum dolor sit amet, consectetur adipiscing
													elit, sed do eiusmod tempor incididunt ut labore et dolore
													magna aliqua. Ut enim ad minim veniam, quis nostrud
													exercitation</p>
											</div>
										</div>
									</div>
									<div class="carousel-item">
										<img class="d-block img-fluid"
											src="https://images.pexels.com/photos/872957/pexels-photo-872957.jpeg"
											alt="First slide">
										<div class="carousel-caption d-none d-md-block">
											<div class="banner-text">
												<h2>This is Heaven</h2>
												<p>Lorem ipsum dolor sit amet, consectetur adipiscing
													elit, sed do eiusmod tempor incididunt ut labore et dolore
													magna aliqua.</p>
											</div>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>
			</section>
	<%@include file="/inc/footer.jsp" %>
			<c:choose>
				<c:when test="${!message.result and message.error eq 'pass'}">
					<script type="text/javascript">
						swal({
			                 text: "비밀번호가 다릅니다.",
			                 icon: "error",
			                 button: "닫기"
			             });
					</script>
				</c:when>
				<c:when test="${!message.result and message.error eq 'membernull'}">
					<script type="text/javascript">
						swal({
			                 text: "아이디를 확인해 주세요.",
			                 icon: "error",
			                 button: "닫기"
			             });
					</script>
				</c:when>
			</c:choose>
	<script src="<c:url value='/js/cookie_box.js'/>"></script>
 	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	 <script src="https://kit.fontawesome.com/4a2ee2359f.js" crossorigin="anonymous"></script>
	 <script type="text/javascript">
	   function logincheck(){
	       
	        var memId=document.getElementById("memId");
	    	var memPass=document.getElementById("memPass");
	    	
	    	 if(memId.value==""){
	             swal({
	                 text: "아이디를 입력하세요.",
	                 icon: "warning",
	                 button: "닫기"
	             });        
	             return false;
	         }else if(memPass.value==""){
	             swal({
	                 text: "비밀번호를 입력하세요.",
	                 icon: "warning",
	                 button: "닫기"
	             });        
	             return false;
	         }
	   }
	 
	 
	 </script>
	 
	 


</body>
</html>