<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%@include file="/inc/common_header.jsp" %>

<link href="<c:url value='/css/btn.css'/>" rel="stylesheet">
<meta charset="UTF-8">
<title>클럽게시판</title>
<style type="text/css">
	table.grid th {text-align:center;}
  	
  	    .myfreeChat{
      position: fixed;
      right:20px; 
      bottom: 150px;
      z-index: 1;
    }
    
    .jumbotron{
      
        border-radius: 0rem;
    	border: 1px solid darkgrey;
      	margin-top : 15px;
      	padding: 2rem 1rem;
      }
</style>
</head>
<body>
	<%@include file="/inc/top_menu.jsp"%>
	<div class="container">
		<div class="row page-header">
			<h1 style="margin-top: 20px;">클럽 게시판</h1>
		</div>
		<!--  검색 폼 -->
		<div class="panel panel-default ">
		<div class="panel-body">
		   <form name="frm_search" action="freeList.lol" method="post" class="form-horizontal">
			  <input type="hidden" name="curPage" value="${searchVO.curPage }">
			  <input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage }">
			  <div class="jumbotron">
			  <div class="row">
			  <div class="col-sm-1" style="margin-right: 30px;"></div> 
			    <div class="col-sm-2">
			    <select id="id_searchType" name="searchType" class="form-control">
			    	<option value="T" ${"T" eq searchVO.searchType ? 'selected="selected"' : ''}>제목</option>
					<option value="W" ${"W" == searchVO.searchType ? 'selected="selected"' : ''}>작성자</option>
					<option value="C" ${searchVO.searchType.equals("C") ? 'selected="selected"' : ''}>내용</option>
			    </select>
			    </div>
			    <div class="col-sm-4">
			      <input type="text" name="searchWord" class="form-control" value="${searchVO.searchWord}" placeholder="검색어">
			    </div>
			    
			    <div class="col-sm-2">
			    <select id="id_searchCategory" name="searchCategory" class="form-control">
			    	<option value="">-- 분 류 --</option>
							<c:forEach items="${catList}" var="vo">
								<option value="${vo.commCd}" ${vo.commCd eq searchVO.searchCategory ? 'selected="selected"' : ''}>${vo.commNm}</option>
							</c:forEach>
			    </select>
			    </div>
			    <div class="col-sm-2">
	 			  <button type="submit" class="btn btn-primary btn-xs blue">
						<span class="fa fa-search"></span> 검 색
					</button>
				 </div>
			  </div>
			  </div>
		  </form>
		  </div>
		</div>
		<!-- 검색폼끝 -->
		<div class="row">
			<div class="col-sm-10"></div>
			<div class="col-sm-2" style="margin-bottom:5px; text-align:right ">
			<c:if test="${sessionScope.USER_INFO ne null}">
				<form action="clubBoardForm.lol" method="post">
					<input type="hidden" name="cbBoClubNum" value="${clubNum}">
					<button type="submit" class="btn btn-sm warning">
						<i class="fa fa-search"></i> &nbsp;&nbsp;글쓰기
					</button>
				</form>
			</c:if>
			</div>
		</div>


		<table class="grid table table-striped table-hover">
			<colgroup>
				<col width="10%" />
				<col  />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
			</colgroup>
			<thead class="thead-dark">
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>등록일</th>
				<th>조회수</th>
			</tr>
			</thead>
			<c:forEach items="${list}" var="vo" varStatus="st">
				<tr class="text-center">
					<c:if test="${searchVO.totalRowCount ne 0}">
						<td>${vo.cbBoNum}</td>
						<td class="text-center"><a
							href="clubBoardView.lol?cbBoClubNum=${vo.cbBoClubNum}&cbBoNum=${vo.cbBoNum}&notice=${vo.cbBoNotice}">
								${vo.cbBoTitle} </a></td>
						<td>${vo.cbBoWriter}</td>
						<td>${vo.cbBoRegDate}</td>
						<td>${vo.cbBoHit}</td>
					</c:if>
					
					<c:if test="${searchVO.totalRowCount == 0}">
						<td colspan="5">글이 없습니다.. ${searchVO.totalRowCount}</td>
					</c:if>
				</tr>
			</c:forEach>
		</table>


		<!-- 페이징 -->
		<nav aria-label="Page navigation example">
	  		<ul class="pagination justify-content-center">
				<!-- 이전 페이지  -->
				<c:if test="${searchVO.firstPage > 1}">
					 <li class="page-item disabled">
					 	<a class="page-link" href="clubBoardList.lol?curPage=${searchVO.firstPage - 1}&cbBoClubNum=${clubNum.cbBoClubNum}"
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
						<li class="page-item"><a class="page-link" href="clubBoardList.lol?curPage=${i}&cbBoClubNum=${clubNum}"
								data-page="${i}">${i}</a>
					</c:if>
				</c:forEach>
				<!-- 다음 페이지  -->
				<c:if test="${searchVO.lastPage < searchVO.totalPageCount}">
					<li class="page-item"><a class="page-link" href="clubBoardList.lol?curPage=${searchVO.lastPage + 1}&cbBoClubNum=${clubNum}"
							aria-label="Next">
							<span aria-hidden="true">&raquo;</span>
		        			<span class="sr-only">Next</span>
						</a>
					</li>
				</c:if>
			</ul>
		</nav>
		<%-- <!-- 페이징 -->
		<nav aria-label="Page navigation example">
		  <ul class="pagination justify-content-center">
			  <c:if test="${searchVO.curPage > searchVO.pageSize}">
			    <li class="page-item disabled">
			      <a class="page-link" href="clubBoardList.lol?curPage=${searchVO.lastPage - searchVO.pageSize}" aria-label="Previous">
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
			    <li class="page-item"><a class="page-link" href="clubBoardList.lol?curPage=${i}" data-page="${i}">${i}</a></li>
		    </c:if>
		    </c:forEach>  
		    <c:if test="${searchVO.lastPage != searchVO.totalPageCount}">
			    <li class="page-item">
			      <a class="page-link" href="clubBoardList.lol?curPage=${searchVO.lastPage+1}" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			        <span class="sr-only">Next</span>
			      </a>
			    </li>
			</c:if>
		  </ul>
		</nav> --%>
		
		
		
		<hr>
	</div>
	<%@include file="/inc/footer.jsp"%>
	<script src="<c:url value='/js/top_menu.js'/>" ></script>
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
</body>
</html>