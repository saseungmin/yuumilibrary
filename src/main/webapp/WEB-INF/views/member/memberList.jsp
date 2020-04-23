<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%@include file="/inc/common_header.jsp" %>

<link href="<c:url value='/css/btn.css'/>" rel="stylesheet">
<meta charset="UTF-8"> 	
<head>
<title>회원목록</title>
<style type="text/css">
  	table.grid th {text-align:center;}

  .jumbotron{
    
      border-radius: 0rem;
  	border: 1px solid darkgrey;
    	margin-top : 15px;
    	padding: 2rem 1rem;
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
</head>
<body>
	<%@include file="/inc/top_menu.jsp"%>
	<div class="container">
		<div class="row page-header">
			<h1 style="margin-top: 20px;">회원 관리</h1>
		</div>
		<div class="panel panel-default">
			<div class="panel-body">
				<form name="frm_search" action="memberList.lol" method="post" class="form-horizontal">
					<input type="hidden" name="curPage" value="${searchVO.curPage }">
					<input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage }">
					<div class="jumbotron">
					<div class="row">
					<div class="col-sm-1" style="margin-right: 110px"></div>
						<div class="col-sm-2">
							<select id="id_searchType" name="searchType" class="form-control">
								<option value="I"
									${"I" eq searchVO.searchType ? 'selected="selected"' : ''}>ID</option>
								<option value="Z"
									${"Z" == searchVO.searchType ? 'selected="selected"' : ''}>회원명</option>
							</select>
						</div>
						<div class="col-sm-4">
							<input type="text" name="searchWord"
								class="form-control" value="${searchVO.searchWord}"
								placeholder="검색어">
						</div>
						<div class="col-sm-2 ">
							<button type="submit" class="btn btn-primary btn-xs blue">
								<i class="fa fa-search"></i> &nbsp;&nbsp;검 색	</button>
						</div>
					</div>
					</div>
				</form>
			</div>
		</div>
		
		<div class="row">
		<div class="col-sm-3  form-inline" style="margin-bottom: 10px; text-align:left">
			전체 ${searchVO.totalRowCount} 건 
			<select id="id_rowSizePerPage" name="rowSizePerPage" class="form-control">
				<option value="10" ${10 eq searchVO.rowSizePerPage ? 'selected="selected"' : ''}>10</option>
				<option value="20" ${20 eq searchVO.rowSizePerPage ? 'selected="selected"' : ''}>20</option>
				<option value="30" ${30 eq searchVO.rowSizePerPage ? 'selected="selected"' : ''}>30</option>
				<option value="50" ${50 eq searchVO.rowSizePerPage ? 'selected="selected"' : ''}>50</option>
			</select>
		</div>
		</div>

		<table class="grid table table-striped table-hover">
			<colgroup>
				<col width="5%" />
				<col width="5%" />
				<col width="5%" />
				<col width="20%" />
				<col width="5%" />
				<%-- 		<col width="5%" /> --%>
				<col width="5%" />
			</colgroup>
			<thead class="thead-dark">
			<tr>
				<th>NO</th>
				<th>ID</th>
				<th>회원명</th>
				<th>주소</th>
				<th>선호장르</th>
				<th>등급</th>
			</tr>
			</thead>
			<c:forEach items="${list}" var="vo" varStatus="st">
				<tr class="active">
					<td>${st.count}</td>
					<td><a style="color: blue" href="memberView.lol?memId=${vo.memId}">${vo.memId}</a></td>
					<td>${vo.memName}</td>
					<td>${vo.memAdd1}${vo.memAdd2}</td>
					<td>${vo.memPrefNm}</td>
					<td>${vo.memRank}</td>
				</tr>
			</c:forEach>
		</table>
		
		<form name="formExcel" method="post" action="getExcelMemberList.lol">
			<a href="#" class="btn btn-sm green" onclick="javascript:formExcel.submit();"><i class="far fa-file-excel"></i>엑셀로 가져오기</a>	
		</form>

		
			<nav aria-label="Page navigation example">
				  <ul class="pagination justify-content-center">
					  <c:if test="${searchVO.curPage > searchVO.pageSize}">
					    <li class="page-item disabled">
					      <a class="page-link" href="memberList.lol?curPage=${searchVO.lastPage - searchVO.pageSize}" aria-label="Previous">
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
					    <li class="page-item"><a class="page-link" href="memberList.lol?curPage=${i}" data-page="${i}">${i}</a></li>
				    </c:if>
				    </c:forEach>  
				    <c:if test="${searchVO.lastPage != searchVO.totalPageCount}">
					    <li class="page-item">
					      <a class="page-link" href="memberList.lol?curPage=${searchVO.lastPage+1}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					        <span class="sr-only">Next</span>
					      </a>
					    </li>
					</c:if>
				  </ul>
				</nav>
			</div>
				<hr>

			
			
	<%@include file="/inc/footer.jsp"%>
	<script type="text/javascript">
	function fn_goPage(e) {
		e.preventDefault();
		console.log("fn_goPage Call", this.dataset.page );
	
		var f = document.forms["frm_search"];
		f.curPage.value = this.dataset.page;
		f.submit();
	}
	
	function fn_frm_search_submit() {
		var f = document.forms["frm_search"];
		f.curPage.value = 1;
		console.log("fn_frm_search_submit Call", f.curPage.value);
		f.submit();
	}
	
	function fn_rowSizePerPage_change() {
		var f = document.forms["frm_search"];
		f.curPage.value = 1;
		f.rowSizePerPage.value = this.value;
		console.log("fn_rowSizePerPage_change Call","curPage", f.curPage.value, "rowSizePerPage", f.rowSizePerPage.value);
		f.submit();
	}
	
	window.onload = function() {
		document.forms["frm_search"].addEventListener("submit",fn_frm_search_submit);
		document.getElementById("id_rowSizePerPage").addEventListener("change", fn_rowSizePerPage_change);
		document.querySelectorAll(".pagination li a[data-page]").forEach(obj => { obj.addEventListener("click", fn_goPage) } );
	}
	</script>
	<script src="<c:url value='/js/memberForm.js'/>"></script>
	<script src="<c:url value='/js/top_menu.js'/>"></script>
</body>

</html>





