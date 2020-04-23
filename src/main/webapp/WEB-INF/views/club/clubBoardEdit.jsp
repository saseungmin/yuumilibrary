<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%@include file="/inc/common_header.jsp"%>
<link href="<c:url value='/css/freeList.css'/>" rel="stylesheet">
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet">
<title>게시글 수정</title>
<script
	src="https://cdn.ckeditor.com/ckeditor5/16.0.0/classic/ckeditor.js"></script>
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
			<h1>글 수정</h1>
		</div>
		<form action="clubBoardModify.lol" method="post" onsubmit="editform()"
			enctype="multipart/form-data" name="myform">
			<div>
				<input type="hidden" name="dup_key" value="${dup_key}" class="form-control"> <input
					type="hidden" name="cbBoClubNum" value="${board.cbBoClubNum}" class="form-control">
				<input type="hidden" name="cbBoMemId" value="${board.cbBoMemId}" class="form-control">
				<input type="hidden" name="cbBoNum" value="${board.cbBoNum}" class="form-control">
				<%-- <input type="hidden" name="cbBoNotice" value="${board.cbBoNotice}"> --%>
				<table class="grid table table-striped table-bordered">
					<colgroup>
						<col width="20%" />
						<col />
					</colgroup>
					<thead class="thead-dark">
					<tr>
						<th style="vertical-align: middle;">제목</th>
						<td><input type="text" name="cbBoTitle" class="form-control"
							value="${board.cbBoTitle}" required="required"></td>
					</tr>
					<tr>
						<th style="vertical-align: middle;">작성자</th>
						<td><input type="text" name="cbBoWriter"
							value="${board.cbBoWriter}" class="form-control"
							required="required" readonly="readonly"></td>
					</tr>

					<tr>
						<th style="vertical-align: middle;">내용</th>
						<td><textarea rows="3" id="idContent" name="cbBoContent"
								class="form-control">${board.cbBoContent}</textarea></td>
					</tr>
					<tr>
						<th>첨부 파일</th>
						<td><c:forEach var="f" items="${board.attaches}"
								varStatus="st">
								<div class="form-check" id="idFiles">
									<div>
										# 파일 ${st.count} ${f.ATCH_ORIGINAL_NAME} 
										Size : ${f.ATCH_FILE_SIZE}
										<span style="color: #e44b4b;">
										<i class="fas fa-trash"></i>
										</span>&nbsp;<input
											class="form-check-input" type="checkbox" value="${f.ATCH_NO}"
											name="delAtchNos">
									</div>
								</div>
							</c:forEach></td>
					</tr>



					<tr>
						<td colspan="2">
							<div class="pull-left">
								<form action="clubMainView.lol" name="myform" method="post">
									<input type="hidden" value="${board.cbBoClubNum}" name="bkNum">
									<button type="submit" class="btn btn-xs blue" ><i class="fa fa-list"></i>목록</button>
								</form>
							</div>
							<div class="pull-right">
								<button type="submit" class="btn btn-xs green"><i class="fa fa-plus"></i>수정하기</button>
								<button type="submit" class="btn  btn-xs red" style="margin-left: 10px"
									onclick="javascript: form.action='clubBoardDelete.lol';"><i class="fa fa-times"></i>삭제하기</button>
							</div>
						</td>
					</tr>
					<!-- <tr>
						<th>첨부파일
							<button type="button" id="id_btn_new_file">추가</button>
						</th>
						<td class="file_area"></td>
					</tr> -->
					</thead>
				</table>
			</div>
		</form>
	</div>
	<%@include file="/inc/footer.jsp"%>
	<script src="<c:url value='/js/top_menu.js'/>"></script>
	<script src="${pageContext.request.contextPath}/js/ckeditor.js"></script>
	<script type="text/javascript">
	function editform() {
		var my_form_action = $('form[name="myform"]').attr('action')
		if(my_form_action == 'clubBoardDelete.lol'){
			$('input:checkbox[name="delAtchNos"]').attr("checked", true);
			console.log(my_form_action);
		}
	}
	</script>
	<script
		src="https://cdn.ckeditor.com/ckeditor5/16.0.0/classic/ckeditor.js"></script>
</body>
</html>
