<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<link href="<c:url value='/bootstrap3/css/bootstrap.min.css'/>"
	rel="stylesheet">
<head>
<%@include file="/inc/common_header.jsp"%>

<title>해당클럽 멤버목록</title>
</head>

<body>
	<%@include file="/inc/top_menu.jsp"%>
	<div class="container">
		<div class="row">
			<h3>클럽 멤버목록</h3>
		</div>
		<form action="clubMemberConfirm.lol" name="myform" method="post">
			<table class="grid table table-striped table-bordered table-hover">
				<colgroup>
					<col width="5%" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
					<col width="5%" />
				</colgroup>
				<tr>
					<th>번호</th>
					<th>회원아이디</th>
					<th>회원명</th>
					<th>나이</th>
					<th>승인관리</th>
				</tr>
				<c:forEach items="${list}" var="cm" varStatus="st">
					<tr>
						
						<td>${st.count}</td>
						<td data-num="${cm.cmNum}">${cm.cmMemId}</td>
						<td>${cm.cmMemName}</td>
						<td>${cm.cmMemBir}</td>
						<c:if test="${cm.cmConfirmYn eq 'N'}">
							<input type="hidden" name="cmMemId" value="${cm.cmMemId}">
							<input type="hidden" name="cmNum" value="${cm.cmNum}">
							<input type="hidden" name="cmClubName" value="${cm.cmClubName}">
							<td><a name="id_regist" href="#" class="btn btn-success">승인</a></td>
						</c:if>

						<c:if test="${cm.cmConfirmYn eq 'Y'}">
							<input type="hidden" name="cmMemId" value="${cm.cmMemId}">
							<input type="hidden" name="cmNum" value="${cm.cmNum}">
							<input type="hidden" name="cmClubName" value="${cm.cmClubName}">
							<td><a name="id_withdraw" href="#" class="btn btn-danger">탈퇴</a></td>
							
						</c:if>
					</tr>
				</c:forEach>
						<c:if test="${count == 0}">
							<td colspan="5" style="text-align: center;"><p>회원이 없습니다....</p></td>
						</c:if>
			</table>
		</form>
	</div>
	<%@include file="/inc/footer.jsp"%>
	<script src="<c:url value='/js/top_menu.js'/>"></script>
	<script type="text/javascript">
	
	$("a[name=id_regist]").click(function(e) {
		e.preventDefault();
		
		var cmMemId=$(this).closest("tr").children("input[name=cmMemId]").val();
		var cmNum=$(this).closest("tr").children("input[name=cmNum]").val();
		var cmClubName=$(this).closest("tr").children("input[name=cmClubName]").val();
		
		params = {"cmMemId" : cmMemId ,
					"cmNum" : cmNum , 
					"cmClubName":cmClubName}
		
			$.ajax({
				type : "POST",
				url : "<c:url value='/club/clubMemberConfirm.lol'/>",
				dataType : "Json",
				data : params,
				success : function(data) {
					console.log(data);
					if (data.result) {
						swal({
							title : data.message,
							icon : "success",
							button : "닫기"
						}).then(function() {
							location.reload();
						})
					} else {
						swal({
							text : data.message,
							icon : "error",
							button : "닫기"
						});
						return false;
					}

				},
				error : function(req, st, err) {
					console.log(req);
				}
			});

		});

		$("a[name=id_withdraw]").click(function(e) {
			e.preventDefault();
		
			var cmMemId=$(this).closest("tr").children("input[name=cmMemId]").val();
			var cmNum=$(this).closest("tr").children("input[name=cmNum]").val();
			var cmClubName=$(this).closest("tr").children("input[name=cmClubName]").val();
			
			params = {"cmMemId" : cmMemId ,
					"cmNum" : cmNum , 
					"cmClubName":cmClubName}

			$.ajax({
				type : "POST",
				url : "<c:url value='/club/clubMemberDelete.lol'/>",
				dataType : "Json",
				data : params,
				success : function(data) {
					console.log(data);
					if (data.result) {
						swal({
							title : data.message,
							icon : "success",
							button : "닫기"
						}).then(function() {
							location.reload();
						})
					} else {
						swal({
							text : data.message,
							icon : "error",
							button : "닫기"
						});
						return false;
					}

				},
				error : function(req, st, err) {
					console.log(req);
				}
			});

		});
	</script>
</body>
</html>
