<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
  <head>
  	<%@include file="/inc/common_header.jsp" %>
  	<link href="<c:url value='/css/memberView.css'/>" rel="stylesheet">	
  	<title>내 정보</title>
  </head>
<body>
		<%@include file="/inc/top_menu.jsp" %>
	<div class="container portfolio">
		<div class="text-left">
			<h1 class="title">내 정보</h1>
			<hr>
		</div>
	
		<div class="row">
			<div class="col-md-12" id="myp">
				<div class="heading">
					<img src="https://image.ibb.co/cbCMvA/logo.png" />
				</div>
			</div>
		</div>
		<div class="bio-info">
			<div class="row">
				<div class="col-md-6">
					<div class="row">
						<div class="col-md-12">
						<div class="d-flex justify-content-center h-100">
							<div class="image_outer_container">
										<div class="green_icon"></div>
										<div class="image_inner_container">
											<c:choose>
												<c:when test="${empty mem.memImg}">
													<img src="<%=request.getContextPath()%>/image/profileimg.jpeg" id="user_image">
												</c:when>
												<c:otherwise>
													<img src="<%=request.getContextPath()%>/image/userProfileImg/${mem.memImg}" id="user_image">
												</c:otherwise>
											</c:choose>
										</div>
							</div>
						</div>
						<!-- onchange="$('#upload-file-info').html(this.files[0].name)" -->
						<c:if test="${sessionScope.USER_INFO.userID eq mem.memId}">
							<div class="file-upload-div">
								<label class="btn btn-sm btn-secondary pull-left" for="my-file-selector" id="fileUploadLabel">
								    <input id="my-file-selector" type="file" style="display:none" name="file">
							    	사진 선택
								</label>
								<span class='label label-info pull-left' id="upload-file-info"></span>
							</div>
						</c:if>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="bio-content">
						<h1 style="margin-bottom: 20px;">${mem.memId}</h1>
						<h6>회원명 : ${mem.memName}</h6>
						<h6>선호도서 장르 : ${mem.memPrefNm}</h6>
						<h6>등급 : ${mem.memRank}</h6>
						<h6>주소 : (${mem.memZip}) ${mem.memAdd1} ${mem.memAdd2}</h6>
						<h6>생일 : ${mem.memBir}</h6>
						<h6>전화번호 : ${mem.memHp}</h6>
						<h6>메일 : ${mem.memMail}</h6>
						<c:if test="${sessionScope.USER_INFO.userRole.equals('관리자')}">
							<a href="memberList.lol" class="btn btn-sm btn-primary" style="margin-top: 20px;">
								<i class="fas fa-list-ul"></i> 회원 목록
							</a>
							<%-- <a class="btn btn-sm btn-primary" href="<%=request.getContextPath()%>/book/allLoanList.lol" style="margin-top: 20px;"><i class="fas fa-list-ul"></i>전체회원대출현황</a> --%>
						</c:if> 
						<c:if test="${sessionScope.USER_INFO.userID eq mem.memId}">
							<a href="memberEdit.lol?memId=${mem.memId}" class="btn btn-sm btn-warning pull-right" style="margin-top: 20px;">
								<i class="fas fa-edit"></i> 정보 수정
							</a>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>

<hr>


<%@include file="/inc/footer.jsp" %>
			<c:choose>
				<c:when test="${!message.result and message.error eq 'diff'}">
					<script type="text/javascript">
						swal({
			                 text: "회원 본인이 아닙니다.",
			                 icon: "error",
			                 button: "닫기"
			             });
					</script>
				</c:when>
			</c:choose>
<script src="<c:url value='/js/top_menu.js'/>"></script>
<script src="<c:url value='/js/memberView.js'/>"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</body>
</html>

