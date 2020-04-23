<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<style type="text/css">
.popover.primary {
    border-color:#337ab7;
}
.popover.primary>.arrow {
    border-top-color:#337ab7;
}
.popover.primary>.popover-title {
    color:#fff;
    background-color:#337ab7;
    border-color:#337ab7;
}
.popover.success {
    border-color:#d6e9c6;
}
.popover.success>.arrow {
    border-top-color:#d6e9c6;
}
.popover.success>.popover-title {
    color:#3c763d;
    background-color:#dff0d8;
    border-color:#d6e9c6;
}
.popover.info {
    border-color:#bce8f1;
}
.popover.info>.arrow {
    border-top-color:#bce8f1;
}
.popover.info>.popover-title {
    color:#31708f;
    background-color:#d9edf7;
    border-color:#bce8f1;
}
.popover.warning {
    border-color:#faebcc;
}
.popover.warning>.arrow {
    border-top-color:#faebcc;
}
.popover.warning>.popover-title {
    color:#8a6d3b;
    background-color:#fcf8e3;
    border-color:#faebcc;
}
.popover.danger {
    border-color:#ebccd1;
}
.popover.danger>.arrow {
    border-top-color:#ebccd1;
}
.popover.danger>.popover-title {
    color:#a94442;
    background-color:#f2dede;
    border-color:#ebccd1;
}

</style>
<meta charset="UTF-8">
 <%@include file="/inc/common_header.jsp" %>
 <title>클럽등록</title>
</head>

<body>
<%@include file="/inc/top_menu.jsp" %>


<hr>
<input type="hidden" id="checkLogin" value="${sessionScope.USER_INFO.userID}">
<div class="container bootstrap snippet">
       <form class="form" action="clubRegist.lol" method="post" class="form-horizontal"  enctype="multipart/form-data" id="myform" >
    <div class="row">
  		<div class="col-sm-10"><h2>클럽 등록</h2></div>
    </div>
  		<hr>
  		<br>
    <div class="row">
  		<div class="col-sm-3"><!--left col-->
              
	
      <div class="text-center">
      
      <img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png" alt="사진을 등록해주세요." class="img-thumbnail">
        <h6>사진을 등록해주세요.</h6>
        <input type="file" class="text-center center-block file-upload" name="clubImage">
      </div>
      
      
      <br>

               
<!--           <div class="panel panel-default">
            <div class="panel-heading">Website <i class="fa fa-link fa-1x"></i></div>
            <div class="panel-body"><a href="http://bootnipets.com">bootnipets.com</a></div>
          </div> -->

		<div class="card border-secondary mb-3" style="max-width: 18rem;">
		  <div class="card-header text-center">클럽 작성 요령</div>
		  <div class="card-body text-success">
		    <h5 class="card-title">※ 작성시 유의 사항</h5>
		    <p class="card-text"> ● 작성시 클럽 소개를 잘 작성해 주세요. <br> ● 지역과 모임시간은 명확하게 입력해주세요. <br> ● 클럽 사진은 꼭! 등록해주세요.</p>
		  </div>
		</div>


               
        </div><!--/col-3-->
    	<div class="col-sm-9">
            <ul class="nav nav-tabs">
            <li class="nav-item">
   				 <a class="nav-link active" href="#">Home</a>
  			</li>
             </ul>

              
          <div class="tab-content">
            <div class="tab-pane active" id="home">
                <hr>
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                              <label for="bkClubName"><h4>클럽명</h4></label>
                              <input class="form-control" id="bkClubName" type="text" value="" placeholder="클럽명" name="bkClubName" required="required">
                          </div>
                      </div>
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                            <label for=bkMemId><h4>클럽장 ID</h4></label>
                              <input class="form-control" id="bkMemId" type="text" value="${sessionScope.USER_INFO.userID}" readonly="readonly" name="bkMemId">
                          </div>
                      </div>
          
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                              <label for="bkLocation"><h4>지역</h4></label>
                              <input class="form-control" id="bkLocation" type="text" value="" placeholder="모임희망지역" name="bkLocation" required="required">
                          </div>
                      </div>
          
                      <div class="form-group">
                          <div class="col-xs-6">
                             <label for="bkAge"><h4>연령</h4></label>
                              <select class="form-control" name="bkAge" id="bkAge" required="required">
                              	<option value="">-- 연령을 선택하세요 --</option>
                              	<option value="10대">--    10대    --</option>
                              	<option value="20대 초반">-- 20대 초반  --</option>
                              	<option value="20대 후반">-- 20대 후반  --</option>
                              	<option value="30대 초반">-- 30대 초반  --</option>
                              	<option value="40대">--    40대    --</option>
                              	<option value="50대">--    50대    --</option>
                              	<option value="60대 이상">-- 60대 이상  --</option>
                              </select>
                          </div>
                      </div>
                      <div class="form-group">
                          
                          <div class="col-xs-6">
                              <label for="bkLimit"><h4>회원 수</h4></label>
                             <select class="form-control" name="bkLimit" id="bkLimit" required="required">
                              	<option value="">-- 가입가능 회원 수를 선택해주세요. --</option>
                              	<option value="5">--    5명    --</option>
                              	<option value="10">-- 10명  --</option>
                              	<option value="15">-- 15명  --</option>
                              	<option value="20">-- 20명  --</option>
                              	<option value="25">--    25명    --</option>
                              	<option value="30">--    30명    --</option>
                              </select>
                          </div>
                      </div>
                      <div class="form-group">
                          <div class="col-xs-6">
                              <label for="bkTime"><h4>모임 시간 및 장소</h4></label>
                             <input class="form-control" id="bkTime" type="text" value="" placeholder="클럽모임시간&장소" name="bkTime" required="required">
                          </div>
                      </div>
                      <div class="form-group">
                          <div class="col-xs-6">
                              <label for="bkTheme"><h4>클럽 설명</h4></label>
                              <textarea class="form-control" rows="5" id="bkTheme" name="bkTheme" placeholder="만드는 클럽에 대해 간략히 소개해주세요." required="required"></textarea>
                          </div>
                      </div>
<!--                       <div class="form-group">
                          
                          <div class="col-xs-6">
                            <label for="password2"><h4>Verify</h4></label>
                              <input type="password" class="form-control" name="password2" id="password2" placeholder="password2" title="enter your password2.">
                          </div>
                      </div> -->
                      <div class="form-group">
                           <div class="col-xs-12">
                                <br>
                              	<button class="btn btn-success pull-right" type="submit"><i class="fas fa-check-circle"></i> 만들기!!</button>
                            </div>
                      </div>
              
              
             </div><!--/tab-pane-->
             
             
               
              </div><!--/tab-pane-->
          </div><!--/tab-content-->

        </div><!--/col-9-->
              	</form>
    </div><!--/row-->


<hr>


<%--  <div class="container">
	<div class="col-md-12">
	<div class="page-header">
		<h1>클럽등록</h1>
	</div>
	<input type="hidden" id="checkLogin" value="${sessionScope.USER_INFO.userID}">
	<form action="clubRegist.lol" method="post" class="form-horizontal" id="myform" onsubmit="return signup();">
		<!-- <div class="form-group">
			<label class="col-sm-3 control-label" for="memRank">회원 타입 선택</label>
				<div class="col-sm-6">
					<select class="form-control" id="memRank" name="memRank">
						<option value="">-- 선택하세요--</option>
						<option value="회원">회원</option>
						<option value="관리자">관리자</option>
					</select>
				</div>
		</div> -->
		<div class="form-group">
			<label class="col-sm-3 control-label" for="bkClubName">클럽명</label>
				<div class="col-sm-6">
					<input class="form-control" id="bkClubName" type="text" value="" placeholder="클럽명" name="bkClubName">
					<p class="help-block">필수항목입니다.<span class="text-danger" id="idhelp"></span></p>
				</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="bkMemId">클럽장 ID</label>
				<div class="col-sm-6">
					<input class="form-control" id="bkMemId" type="text" value="${sessionScope.USER_INFO.userID}" readonly="readonly" name="bkMemId">
					<p class="help-block"><span class="text-danger" id="idhelp"></span></p>
				</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="bkLocation">지역</label>
				<div class="col-sm-6">
					<input class="form-control" id="bkLocation" type="text" value="" placeholder="모임희망지역" name="bkLocation">
					<p class="help-block"></p>
				</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="bkAge">연령</label>
				<div class="col-sm-6">
					<input class="form-control" id="bkAge" type="text" value="" placeholder="클럽연령" name="bkAge">
					<p class="help-block"></p>
				</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="bkLimit">회원수</label>
				<div class="col-sm-6">
					<input class="form-control" id="bkLimit" type="text" value="" placeholder="클럽회원수" name="bkLimit">
					<p class="help-block">숫자만 입력 가능합니다.</p>
				</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="bkTime">모임시간</label>
				<div class="col-sm-6">
					<input class="form-control" id="bkTime" type="text" value="" placeholder="클럽모임시간" name="bkTime">
					<p class="help-block"></p>
				</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="bkTheme">클럽설명</label>
				<div class="col-sm-6">
					<input class="form-control" id="bkTheme" type="text" value="" placeholder="클럽설명" name="bkTheme">
					<p class="help-block">필수항목입니다.</p>
				</div>
		</div>
		<div class="form-group">
			 <div class="col-sm-12 text-center">
				<input type="submit" class="btn btn-success" value="클럽등록">
			  </div>
		</div>
	</form>
	</div>
</div> --%>

<%-- <script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/bootstrap3/js/bootstrap.min.js'/>"></script> --%>
<%@include file="/inc/footer.jsp"%>
<script src="<c:url value='/js/top_menu.js'/>"></script>
<script src="<c:url value='/js/clubForm.js'/>"></script>
</body>
</html>
