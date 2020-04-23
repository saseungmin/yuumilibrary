<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%@include file="/inc/common_header.jsp" %>

<link href="<c:url value='/css/btn.css'/>" rel="stylesheet">
<meta charset="UTF-8">
<head>
<meta charset="UTF-8">
<title>전체 대출현황</title>
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
			<h1 style="margin-top: 20px">전체 대출목록</h1>
		</div>
		<div class="panel panel-default">
			<div class="panel-body">
				<form name="frm_search" action="allLoanList.lol" method="post"
					class="form-horizontal">
					<input type="hidden" name="curPage" value="${searchVO.curPage }">
					<input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage }">
					<div class="jumbotron">
					<div class="row">
					<div class="col-sm-1" style="margin-right: 110px;"></div>
						<div class="col-sm-2">
							<select id="id_searchType" name="searchType" class="form-control">
								<option value="B"
									${"B" eq searchVO.searchType ? 'selected="selected"' : ''}>도서명</option>
								<option value="U"
									${"U" == searchVO.searchType ? 'selected="selected"' : ''}>대출인</option>
							</select>
						</div>
						<div class="col-sm-4">
							<input type="text" name="searchWord"
								class="form-control input-sm" value="${searchVO.searchWord}"
								placeholder="검색어">
						</div>
						<div class="col-sm-2 ">
							<button type="submit" class="btn btn-primary btn-xs blue ">
								<i class="fa fa-search"></i> &nbsp;&nbsp;검 색
							</button>
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

		<form name="forNmae" action="returnBook.lol" method="post">
			<input type="hidden" name="loaMemId" id="loaMemId"
				value="${sessionScope.USER_INFO.userID}">
			<table class="grid table table-striped table-hover">
				<colgroup>
					<col />
					<col />
					<col />
					<col />
					<col />
					<col />
				</colgroup>
				<thead class="thead-dark">
				<tr>
					<th>도서번호</th>
					<th>도서명</th>
					<th>대출인</th>
					<th>대출일</th>
					<th>반납일</th>
					<th>반납여부</th>
				</tr>
				<c:forEach items="${loanList}" var="vo">
					<tr class="text-center active">
						<td><a style="color: blue" href="bookView.lol?bookIsbn=${vo.loaIsbn}&bookName=${vo.loaBookName}&bookAuthors=${vo.loaBookAuthors}">${vo.loaIsbn}</a></td>
						<td class="text-left">${vo.loaBookName}</td>
						<td class="text-left">${vo.loaMemId}</td>
						<td>${vo.loaLoanDate}</td>
						<td>${vo.loaReturnDate}</td>
						<c:if test="${vo.loaReturnYN.equals('N')}">
							<td><a href="returnBook.lol?bookIsbn=${vo.loaIsbn}&bookName=${vo.loaBookName}&bookAuthors=${vo.loaBookAuthors}&loaMemId=${sessionScope.USER_INFO.userID}"><i
									class="fas fa-user-edit"></i>&nbsp;미반납</a></td>
						</c:if>
						<c:if test="${vo.loaReturnYN.equals('Y')}">
							<td><i class="fas fa-user-edit"></i>&nbsp;반납완료</td>
						</c:if>
					</tr>
				</c:forEach>
				</thead>
			</table>
		</form>
		
		<a href="getExcel.lol" class="btn btn-sm green"><i class="far fa-file-excel"></i>엑셀로 가져오기</a>
		
		<!-- 페이징 -->
		<nav aria-label="Page navigation example">
	  		<ul class="pagination justify-content-center">
				<!-- 이전 페이지  -->
				<c:if test="${searchVO.firstPage > 1}">
					 <li class="page-item disabled">
					 	<a class="page-link" href="allLoanList.lol?curPage=${searchVO.firstPage - 1}&cbBoClubNum=${clubNum.cbBoClubNum}"
						aria-label="Previous">
						<span aria-hidden="true">&laquo;</span>
		        		<span class="sr-only">Previous</span>
						</a>
					</li>
				</c:if>
				<!-- 페이징  -->
				<c:forEach var="i" begin="${searchVO.firstPage}"
					end="${searchVO.lastPage}">
					<c:if test="${searchVO.curPage eq i}">
						<li class="page-item active"><a class="page-link" href="#">${i}</a>
					</c:if>
					<c:if test="${searchVO.curPage ne i}">
						<li class="page-item"><a class="page-link" href="allLoanList.lol?curPage=${i}&cbBoClubNum=${clubNum}"
								data-page="${i}">${i}</a>
					</c:if>
				</c:forEach>
				<!-- 다음 페이지  -->
				<c:if test="${searchVO.lastPage < searchVO.totalPageCount}">
					<li class="page-item"><a class="page-link" href="allLoanList.lol?curPage=${searchVO.lastPage + 1}&cbBoClubNum=${clubNum}"
							aria-label="Next">
							<span aria-hidden="true">&raquo;</span>
		        			<span class="sr-only">Next</span>
						</a>
					</li>
				</c:if>
			</ul>
		</nav>
	</div> <!--container  -->
<hr>
	<%@include file="/inc/footer.jsp"%>
</body>


<script type="text/javascript">

 	
 	
/* 	 swal({
	     title: "Deleted!",
	     text: "Your row has been deleted.",
	     type: "success",
	     timer: 3000
	     });	
 	return false;
 */
}
 
</script>
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
</html>