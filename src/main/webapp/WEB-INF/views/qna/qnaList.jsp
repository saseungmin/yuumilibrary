<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%@include file="/inc/common_header.jsp"%>
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet">
<title>문의게시판</title>
<style type="text/css">

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
	<div class="page-header">
		<div class="row">
			<h1 style="margin-top: 20px;">문의게시판</h1>
		</div>
	</div>

	<div class="col-sm-12 text-right" style="margin-bottom: 5px">
		<c:if test="${not empty sessionScope.USER_INFO}">
			<a href="qnaForm.lol" class="btn btn-sm warning"><i class="fa fa-plus"></i> &nbsp;문의하기</a>
		</c:if>
		<c:if test="${empty sessionScope.USER_INFO}">
			<a href="<%=request.getContextPath()%>/login/login.lol">로그인</a>하면 문의할 수 있습니다.
		</c:if>
	</div>

	<table class="grid table table-striped table-hover">
		<colgroup>
			<col width="5%" />
			<col width="5%" />
			<col width="5%" />
			<col width="20%" />
			<col width="5%" />
			<col width="5%" />
		</colgroup>
		<thead class="thead-dark">
		<tr>
			<th>문의번호</th>
			<th>ID</th>
			<th>회원명</th>
			<th>제목</th>
			<th>등록일</th>
			<th>조회수</th>
		</tr>
		</thead>
		<c:if test="${not empty list}">
			<c:forEach items="${list}" var="vo" varStatus="st">
				<c:choose>
					<c:when test="${sessionScope.USER_INFO.userID eq vo.qbMemId}">
						<tr data-target="${vo.qbNum}">
							<td>${vo.qbNum}</td>
							<c:if test="${sessionScope.USER_INFO.userRole eq '관리자'}">
								<td><a href="<%=request.getContextPath()%>/member/memberView.lol?memId=${vo.qbMemId}">${vo.qbMemId}</a></td>
							</c:if>
							<c:if
								test="${sessionScope.USER_INFO.userRole eq '회원'}">
								<td>${vo.qbMemId}</td>
							</c:if>
							<!-- 끝 -->
							<td>${vo.qbWriter}</td>

							<td data-target="${vo.qbMemId}"><a href="#"
								class="qnaClick">${vo.qbTitle}</a></td>

							<td>${vo.qbRegDate}</td>
							<td>${vo.qbHit}</td>
						</tr>
					</c:when>
					<c:otherwise>
						<tr data-target="${vo.qbNum}">
							<td>${vo.qbNum}</td>
							<!-- 이프문으로 감싸서 관리자일때 a태그사용 -->
							<c:if test="${sessionScope.USER_INFO.userRole eq '관리자'}">
								<td><a href="<%=request.getContextPath()%>/member/memberView.lol?memId=${vo.qbMemId}">${vo.qbMemId}</a></td>
							</c:if>
							<c:if
								test="${empty sessionScope.USER_INFO || sessionScope.USER_INFO.userRole eq '회원'}">
								<td>${vo.qbMemId}</td>
							</c:if>
							<td>${vo.qbWriter}<input name="checkInput" type="hidden"
								value="${vo.qbMemId}" data-target="${vo.qbMemId}" /></td>

							<td data-target="${vo.qbMemId}"><a href="#"
								class="qnaClick">${vo.qbTitle} &nbsp;</a><i class="fas fa-lock"></i></td>

							<td>${vo.qbRegDate}</td>
							<td>${vo.qbHit}</td>
						</tr>
					</c:otherwise>

				</c:choose>
			</c:forEach>
		</c:if>




		<c:if test="${empty list}">
			<tr>
				<td colspan="6" style="text-align: center;">아직 등록된 글이 없습니다..</td>
			</tr>
		</c:if>
	</table>
<!-- 페이징 -->
	<nav aria-label="Page navigation example">
	  <ul class="pagination justify-content-center">
		  <c:if test="${searchVO.curPage > searchVO.pageSize}">
		    <li class="page-item disabled">
		      <a class="page-link" href="qnaList.lol?curPage=${searchVO.lastPage - searchVO.pageSize}" aria-label="Previous">
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
		    <li class="page-item"><a class="page-link" href="qnaList.lol?curPage=${i}" data-page="${i}">${i}</a></li>
	    </c:if>
	    </c:forEach>  
	    <c:if test="${searchVO.lastPage != searchVO.totalPageCount}">
		    <li class="page-item">
		      <a class="page-link" href="qnaList.lol?curPage=${searchVO.lastPage+1}" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		        <span class="sr-only">Next</span>
		      </a>
		    </li>
		</c:if>
	  </ul>
	</nav>
	<hr>

	<input value="${sessionScope.USER_INFO.userID}" type="hidden"
		id="sessionId">
	<input value="${sessionScope.USER_INFO.userRole}" type="hidden"
		id="sessionRole">
</div>
<hr>


<%@include file="/inc/footer.jsp"%>
<script src="<c:url value='/js/top_menu.js'/>"></script>
<script src="<c:url value='/js/qnaList.js?dummi=2'/>"></script>

<script type="text/javascript">
</script>
</body>
</html>






