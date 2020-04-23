<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@include file="/inc/common_header.jsp"%>
<title>클럽상세정보</title>
</head>

<body>
<%@include file="/inc/top_menu.jsp"%>
<div class="container">
	<div>
		<h1>클럽상세보기</h1>
	</div>
	<table class="grid table table-striped table-bordered table-hover">
		<colgroup>
			<col width="20%" />
			<col />
		</colgroup>
		<tr>
			<th>클럽번호</th>
			<td>${clubVO.bkNum}</td>
		</tr>
		<tr>
			<th>클럽명</th>
			<td>${clubVO.bkClubName}</td>
		</tr>
		<tr>
			<th>클럽장</th>
			<td>${clubVO.bkMemId}</td>
		</tr>
		<tr>
			<th>지역</th>
			<td>${clubVO.bkLocation}</td>
		</tr>
		<tr>
			<th>연령</th>
			<td>${clubVO.bkAge}</td>
		</tr>
		<tr>
			<th>회원수</th>
			<td>${clubVO.bkMemCnt} / ${clubVO.bkLimit}</td>
		</tr>
		<tr>
			<th>모임시간</th>
			<td>${clubVO.bkTime}</td>
		</tr>
		<tr>
			<th>클럽설명</th>
			<td>${clubVO.bkTheme}</td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="pull-left">
					<a href="clubList.lol" class="btn btn-sm btn-default">목록</a>
				</div>
				<c:if test="${sessionScope.USER_INFO.userID eq clubVO.bkMemId || sessionScope.USER_INFO.userRole eq '관리자'}">
					<div class="pull-right">
						<a href="clubEdit.lol?bkNum=${clubVO.bkNum}" class="btn btn-sm btn-success">
						정보수정</a>
					</div>
					<form action="clubMemberList.lol" method="post">
					<div class="pull-right">
						<%-- <a href="clubMemberList.lol?bkClubName=${clubVO.bkClubName}" class="btn btn-sm btn-success">
						클럽회원관리</a> --%>
						<input type="hidden" name="cmNum" value="${clubVO.bkNum}">
						<input type="hidden" name="cmClubName" value="${clubVO.bkClubName}">
						<%-- <input type="text" name="cbName" value="${clubVO.bkClubName}"> --%>
						<button type="submit" class="btn btn-sm btn-success">클럽회원관리</button>
					</div>
					</form>
				</c:if>
				<form name="formName" action="clubMemberRegist.lol" method="post">
				<c:if test="${not empty sessionScope.USER_INFO && clubVO.bkMemCnt < clubVO.bkLimit && sessionScope.USER_INFO.userID ne clubVO.bkMemId}">
					<div class="pull-right">
						<input type="hidden" name="bkNum" value="${clubVO.bkNum}">
						<input type="hidden" name="bkClubName" value="${clubVO.bkClubName}">
						<input type="hidden" name="bkMemId" value="${sessionScope.USER_INFO.userID}">
						<button type="submit" id="btn_join" class="btn btn-sm btn-success">가입하기</button>
					</div>
				</c:if>
				</form>
			</td>
		</tr>
	</table>
</div>

<%@include file="/inc/footer.jsp"%>
<script src="<c:url value='/js/top_menu.js'/>"></script>
<script type="text/javascript">

$("#btn_join").click(function(e) {
	e.preventDefault();
	f = document.forms.formName
	params = $(f).serialize();
	
	console.log(params);
	
	$.ajax({
		 type : "POST"
		,url : "<c:url value='/club/clubMemberRegist.lol'/>"
		,dataType : "Json"
		,data : params
		,success : function(data) {
			console.log(data);
			if(data.result){
				swal({
	                 title: data.message,
	                 icon: "success",
	                 button: "닫기"
	             }).then(function(){
	            	 location.href = "clubList.lol";
	            			 })	
			}else{
				swal({
	                 text: data.message,
	                 icon: "error",
	                 button: "닫기"
	             });
				return false;
			}
			
		},error : function(req, st, err) {
			console.log(req);
		}
	});
});

</script>
</body>
</html>
