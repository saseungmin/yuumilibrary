<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%@include file="/inc/common_header.jsp" %>
<link href="<c:url value='/css/freeList.css'/>" rel="stylesheet">
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet">

<title>게시글 목록</title>

	
	<style type="text/css">
    .pagination>li>a { border-radius: 50% !important;margin: 0 5px;}

.page-item.active .page-link{
    background-color: #79d799;
    border-color: #79d799;
}

.page-link{
	color: #79d799;
}
	
  	table.grid th {text-align:center;}
  	
  	    .myfreeChat{
      position: fixed;
      right:20px; 
      bottom: 150px;
      z-index: 1;
    }
    
      img{ 
      width:50px;
      height:50px;
      }
      
      .popup-messages .session-img{
			border: 1px solid #fff;
		    border-radius: 50%;
		    float: left;
		    height: 30px;
		    margin: -10px 0 0;
		    width: 30px;
		}
      
      
      .notice{
      color: #dc3545;
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
<%@include file="/inc/top_menu.jsp" %>

<div class="myfreeChat">
	<a href="#" id="addClass">
		<img src="<c:url value='/image/freeChat.png'/>" alt="My Image">
	</a>
</div>	
<div class="container">
	<div class="row page-header">
		<h1 style="margin-top: 20px;">자유 게시판</h1>
	</div>
	<!--  검색 폼 -->
	<div class="panel panel-default ">
	<div class="panel-body">
	   <form name="frm_search" action="freeList.lol" method="post" class="form-horizontal">
		  <input type="hidden" name="curPage" value="${searchVO.curPage }">
		  <input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage }">
		  <div class="jumbotron">
		  <div class="row">
		  <div class="col-sm-1" style="margin-right: 40px;"></div> 
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
	
	<!--  목록 폼 -->
	<div class="row"> 
		<div class="col-sm-3 form-inline " style="margin-bottom: 10px; text-align:left ">
			전체 ${searchVO.totalRowCount} 건 
			<select id="id_rowSizePerPage" name="rowSizePerPage" class="form-control-sm" style="margin-left: 10px;">
				<option value="10" ${10 eq searchVO.rowSizePerPage ? 'selected="selected"' : ''}>10</option>
				<option value="20" ${20 eq searchVO.rowSizePerPage ? 'selected="selected"' : ''}>20</option>
				<option value="30" ${30 eq searchVO.rowSizePerPage ? 'selected="selected"' : ''}>30</option>
				<option value="50" ${50 eq searchVO.rowSizePerPage ? 'selected="selected"' : ''}>50</option>
			</select>
		</div>
		<div class="col-sm-7"></div>
 		<div class="col-sm-2" style="margin-bottom:5px; text-align:right ">
		<c:if test="${not empty sessionScope.USER_INFO.userID}">
			<a href="<%=request.getContextPath()%>/free/freeForm.lol" class="btn btn-sm warning"><i class="fa fa-plus"></i>&nbsp;&nbsp;글쓰기</a>
		</c:if>
		<c:if test="${empty sessionScope.USER_INFO}">
			<a href="<%=request.getContextPath()%>/login/login.lol" class="btn btn-sm warning"><i class="fa fa-plus"></i>&nbsp;&nbsp;글쓰기</a>
		</c:if>
	</div> 
	 </div> 
	
<form name="frm_free_list">
	<table class="grid table table-striped table-hover">
	<colgroup>
		<col width="10%" />
		<col width="15%" />
		<col />
		<col width="10%" />
		<col width="15%" />
		<col width="10%" />
	</colgroup>
	<thead class="thead-dark">
	<tr>
		<th>글번호</th>
		<th>분류</th>
		<th>제목</th>
		<th>작성자</th>
		<th>등록일</th>
		<th>조회수</th>
	</tr>
	</thead>
	<c:forEach items="${list}" var="vo" varStatus="st">
	<c:choose>	
		<c:when test="${vo.boCategory eq 'BC01'}">
	<tr class="text-center table-danger">
		<td class="notice">공지</td>
		<td>${vo.boCategoryNm}</td>
		<td class="text-left"  >
			<a href="freeView.lol?boNum=${vo.boNum}&boNotice=${vo.boNotice}">
				${vo.boTitle}
			</a>
		</td>
		<td>${vo.boMemId}</td>
		<td>${vo.boRegDate}</td>
		<td>${vo.boHit}</td>
	</tr>
		</c:when>
		<c:otherwise>
			<tr class="text-center">
		<td>${vo.boNum}</td>
		<td>${vo.boCategoryNm}</td>
		<td class="text-left">
			<a href="freeView.lol?boNum=${vo.boNum}&boNotice=${vo.boNotice}">
				${vo.boTitle}
			</a>
		</td>
		<td>${vo.boMemId}</td>
		<td>${vo.boRegDate}</td>
		<td>${vo.boHit}</td>
	</tr>
		
		</c:otherwise>
	</c:choose>
	
	</c:forEach>
	</table>
</form>
</div>
	<!-- 페이징 -->
	<nav aria-label="Page navigation example">
	  <ul class="pagination justify-content-center">
		  <c:if test="${searchVO.curPage > searchVO.pageSize}">
		    <li class="page-item disabled">
		      <a class="page-link" href="freeList.lol?curPage=${searchVO.lastPage - searchVO.pageSize}" aria-label="Previous">
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
		    <li class="page-item"><a class="page-link" href="freeList.lol?curPage=${i}" data-page="${i}">${i}</a></li>
	    </c:if>
	    </c:forEach>  
	    <c:if test="${searchVO.lastPage != searchVO.totalPageCount}">
		    <li class="page-item">
		      <a class="page-link" href="freeList.lol?curPage=${searchVO.lastPage+1}" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		        <span class="sr-only">Next</span>
		      </a>
		    </li>
		</c:if>
	  </ul>
	</nav>
	
	
	
	<hr>
	
	
	
	
<div class="popup-box chat-popup" id="qnimate">
 	<div class="popup-head">
	<div class="popup-head-left pull-left"><img src="<c:url value='/image/freeChat.png'/>" alt="My Image"> 자유 채팅방</div>
		<div class="popup-head-right pull-right">
			<button data-widget="remove" id="removeClass" class="chat-header-button pull-right" type="button"><i class="fas fa-times"></i></button>
        </div>
  	</div>
  	
  	<!-- chat message main -->
	<div class="popup-messages" style="height: 290px;" id="topmainM">		
	 	<div class="direct-chat-messages" id="mainMessage">			
<%-- 		<div class="chat-box-single-line">
						<abbr class="timestamp">October 8th, 2015</abbr>
			</div>				
			<!-- Message. Default to the left -->
            <div class="direct-chat-msg doted-border">
                    <div class="direct-chat-info clearfix">
                      <span class="direct-chat-name pull-left">Yummi</span>
                    </div>
                    <!-- /.direct-chat-info -->
                    <img alt="message user image" src="<c:url value='/image/chatbot.png'/>" class="direct-chat-img"><!-- /.direct-chat-img -->
                    <div class="direct-chat-text">
                      		안녕하세요?
                    </div>
			  	<div class="direct-chat-info clearfix">
                      <span class="direct-chat-timestamp pull-right">3.36 PM</span>
                </div>
				<div class="direct-chat-info clearfix">
					<span class="direct-chat-img-reply-small pull-left"></span>
					<span class="direct-chat-reply-name">Singh</span>
				</div>
                    <!-- /.direct-chat-text -->
             </div>
                  <!-- /.direct-chat-msg -->			
			<div class="chat-box-single-line">
				<abbr class="timestamp">October 9th, 2015</abbr>
			</div>	
			<!-- Message. Default to the left -->
                  <div class="direct-chat-msg doted-border">
                    <div class="direct-chat-info clearfix">
                      <span class="direct-chat-name pull-left">Yummi</span>
                    </div>
                    <!-- /.direct-chat-info -->
                    <img alt="iamgurdeeposahan" src="<c:url value='/image/chatbot.png'/>" class="direct-chat-img"><!-- /.direct-chat-img -->
                    <div class="direct-chat-text">
                      Hey bro, how’s everything going ?
                    </div>
			  <div class="direct-chat-info clearfix">
                      <span class="direct-chat-timestamp pull-right">3.36 PM</span>
              </div>
				<div class="direct-chat-info clearfix">
				  <img alt="iamgurdeeposahan" src="<c:url value='/image/chatbot.png'/>" class="direct-chat-img big-round">
				<span class="direct-chat-reply-name">Singh</span>
				</div>
                    <!-- /.direct-chat-text -->
                  </div>
                  <!-- /.direct-chat-msg -->  --%>
                </div>	
	</div>
	<div class="popup-messages-footer">
			<textarea id="status_message" placeholder="궁금한 사항을 입력하세요!" rows="10" cols="30" name="message"></textarea>
			<button type="button" class="btn btn-light" style="margin-bottom:20px;" id="chatButton"><i class="fas fa-paper-plane"></i></button>
	</div>
</div>
	<input type="hidden" value="${sessionScope.USER_INFO.userID}" id="chatUserId"/>

<%@include file="/inc/footer.jsp" %>
<script src="<c:url value='/js/top_menu.js'/>" ></script>
<script src="<c:url value='/js/sockjs.js'/>"></script>
<script src="<c:url value='/js/freeList.js'/>"></script>

<!-- <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
<!-- <script src="https://unpkg.com/bootstrap-table/dist/bootstrap-table.min.js"></script> -->


	<script type="text/javascript">
	// 함수 연결 방법 2가지
	// 1. 해당 엘리먼트에서 이벤트(click, change, submit)에서 함수 직접 call
	// 2. 해당 엘리먼트에 이벤트리스너를 설정
	
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
