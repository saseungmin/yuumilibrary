<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%@include file="/inc/common_header.jsp"%>
<link href="<c:url value='/css/freeList.css'/>" rel="stylesheet">
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet">   
<title>게시글 등록</title>
<script src="https://cdn.ckeditor.com/ckeditor5/16.0.0/classic/ckeditor.js"></script>
<style type="text/css">
	.ck-editor__editable {
    	min-height: 400px;
	}
	table.grid th {
	text-align: center;
}
</style>
</head>

<body>
<%@include file="/inc/top_menu.jsp" %>

<div class="container">
	<div class="page-header">
		<h1>글 등록</h1>
	</div>
	<form action="freeRegist.lol" method="post" enctype="multipart/form-data">
	<div>
		<input type="hidden" name="dup_key" value="${dup_key}">
		<table class="grid table table-striped table-bordered">
			<colgroup>
				<col width="20%" />
				<col />
			</colgroup>
			<thead class="thead-dark">
			<tr>
				<th style="vertical-align: middle;">제목</th>
				<td><input type="text" name="boTitle" value="" class="form-control" required="required"></td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">작성자</th>
				<td><input type="text" name="boMemId" value="${sessionScope.USER_INFO.userID}" class="form-control" required="required" readonly="readonly"></td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">분류</th>
				<td>
					<select name="boCategory" class="form-control" required="required" >
						<option value="">-- 선택하세요 --</option>
						<c:if test="${sessionScope.USER_INFO.userRole eq '관리자'}">
							<c:forEach items="${catList}" var="vo">
								<option value="${vo.commCd}">${vo.commNm}</option>
							</c:forEach>
						</c:if>
						<c:if test="${sessionScope.USER_INFO.userRole eq '회원'}">
							<option value="BC02">책 이야기</option>
							<option value="BC03">사는 이야기</option>
							<option value="BC04">마음의 소리</option>
						</c:if>
					</select>	
				</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">내용</th>
				<td>
					<textarea rows="3" id="idContent" name="boContent" class="form-control"></textarea>
				</td>
			</tr>
			<tr>
				<th>첨부파일
					<button type="button" class="btn btn-primary btn-xs dark" id="id_btn_new_file"> <i class="fas fa-file-upload"></i> 추가</button>
				</th>
				<td class="file_area">
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					<div class="pull-left">
						<a href="freeList.lol" class="btn btn-primary btn-xs blue"><i class="fa fa-list"></i>목록으로</a>
					</div>
					<div class="pull-right">
					<button type="submit" class="btn btn-primary btn-xs green"><i class="fa fa-plus"></i>저장하기</button>
				</div>
				</td>
			</tr>
			</thead>
				</table>
	</div>
	</form>
</div>
<%@include file="/inc/footer.jsp" %>
<script src="<c:url value='/js/top_menu.js'/>"></script>
<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
<script type="text/javascript">

	$('#id_btn_new_file')
			.click(
					function() {
						$('.file_area').append('<div class="form-inline">'
										+ '<input type="file" name="boFiles" class="form-control">'
										+ ' <button type="button" class="btn btn-danger btn btn-sm"><i class="far fa-trash-alt"></i></button>'
										+ '</div>');
					});
	$('.file_area').on('click', '.btn-danger', function() {
		$(this).closest('div').remove();
	});
</script>
</body>
</html>
