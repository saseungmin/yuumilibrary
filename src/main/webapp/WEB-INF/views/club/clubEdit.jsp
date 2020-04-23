<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@include file="/inc/common_header.jsp" %>
<link href="<c:url value='/bootstrap3/css/bootstrap.min.css'/>" rel="stylesheet">
<title>클럽정보수정</title>
</head>

<body>
<%@include file="/inc/top_menu.jsp" %>
<div class="container">
	<div class="col-md-12">
	<div class="page-header">
		<h1>클럽정보수정</h1>
	</div>
	<form  method="post" class="form-horizontal" id="myform">
		<input type="hidden" name="bkNum" value="${vo.bkNum}">
		<div class="form-group">
			<label class="col-sm-3 control-label" for="bkClubName">클럽명</label>
				<div class="col-sm-6">
					<input class="form-control" id="bkClubName" type="text" value="${vo.bkClubName}" placeholder="클럽명" name="bkClubName">
				</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="bkMemId">클럽장 ID</label>
				<div class="col-sm-6">
					<input class="form-control" id="bkMemId" type="text" value="${vo.bkMemId}" name="bkMemId">
					<p class="help-block"><span class="text-danger" id="idhelp"></span></p>
				</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="bkLocation">지역</label>
				<div class="col-sm-6">
					<input class="form-control" id="bkLocation" type="text" value="${vo.bkLocation}" placeholder="모임희망지역" name="bkLocation">
				</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="bkAge">연령</label>
				<div class="col-sm-6">
					<input class="form-control" id="bkAge" type="text" value="${vo.bkAge}" placeholder="클럽연령" name="bkAge">
				</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="bkLimit">회원수</label>
				<div class="col-sm-6">
					<input class="form-control" id="bkLimit" type="text" value="${vo.bkLimit}" placeholder="클럽회원수" name="bkLimit">
					<p class="help-block">숫자만 입력 가능합니다.</p>
				</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="bkTime">모임시간</label>
				<div class="col-sm-6">
					<input class="form-control" id="bkTime" type="text" value="${vo.bkTime}" placeholder="클럽모임시간" name="bkTime">
				</div>
		</div>
		<div class="form-group">
			<label class="col-sm-3 control-label" for="bkTheme">클럽설명</label>
				<div class="col-sm-6">
					<input class="form-control" id="bkTheme" type="text" value="${vo.bkTheme}" placeholder="클럽설명" name="bkTheme">
					<p class="help-block">필수항목입니다.</p>
				</div>
		</div>
		<div class="form-group">
			 <div class="col-sm-12 text-center">
				<input type="submit" class="btn btn-success" value="클럽수정" formaction="clubModify.lol">
				<input type="submit" class="btn btn-warning" value="클럽삭제" formaction="clubDelete.lol">
			  </div>
		</div>
	</form>
	</div>	
</div>
<%@include file="/inc/footer.jsp"%>
<script src="<c:url value='/js/top_menu.js'/>"></script>
</body>
</html>
