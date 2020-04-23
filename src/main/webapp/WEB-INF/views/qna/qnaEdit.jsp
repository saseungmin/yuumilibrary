<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%@include file="/inc/common_header.jsp"%>
<link href="<c:url value='/css/freeList.css'/>" rel="stylesheet">
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet">
<title>글 수정</title>
<script
	src="https://cdn.ckeditor.com/ckeditor5/16.0.0/classic/ckeditor.js">
</script>

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
	<%@include file="/inc/top_menu.jsp"%>

	<div class="container">
		<div class="page-header">
			<h1 style="margin-top: 20px;">글 수정</h1>
		</div>
		
		<form action="qnaModify.lol" method="post">
			<div>
				<input type="hidden" name="qbNum" value="${qna.qbNum}">
				
				<table class="grid table table-striped table-bordered">
					<colgroup>
						<col width="20%">
						<col/>
					</colgroup>
					<thead class="thead-dark">
					<tr>
						<th style="vertical-align: middle;">제목</th>
						<td><input type="text" name="qbTitle" class="form-control"
									value="${qna.qbTitle}" required="required"></td>
					</tr>
					<tr>
						<th style="vertical-align: middle;">작성자</th>
						<td><input type="text" name="qbWriter" class="form-control"
									value="${qna.qbWriter}" readonly="readonly"></td>
					</tr>
					<tr>
						<th style="vertical-align: middle;">내용</th>
						<td><textarea rows="3" id="idContent" name="qbContent"
									class="form-control">${qna.qbContent}</textarea></td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="pull-left">
								<a href="qnaList.lol" class="btn btn-primary btn-xs blue"><i class="fa fa-list"></i>목록으로</a>
							</div>
							<div class="pull-right">
								<button type="submit" class="btn btn-primary btn-xs red" style="margin-left: 10px"
										onclick="javascript: form.action='qnaDelete.lol'"><i class="fa fa-times"></i>
										삭제하기
								</button>
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
		
		
	</div> <!-- container -->






	<%-- 	<form:form action="qnaModify.lol" commandName="qna" name="formName">
		<form:hidden path="qbWriter" />
		
		<form:input path="qbNum" />
		<form:errors path="qbNum" />

		<form:input path="qbTitle" />

		<form:textarea path="qbContent" />

		<input type="submit" value="수정하기">
		<input type="submit"
			onclick="del()" value="삭제하기">
		
	${qna.qbTitle}
	content = ${qna.qbContent}
	</form:form> --%>
	<%@include file="/inc/footer.jsp"%>
	<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
	<script src="<c:url value='/js/top_menu.js'/>"></script>
</body>
</html>