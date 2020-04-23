<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%@include file="/inc/common_header.jsp"%>

<link href="<c:url value='/css/btn.css'/>" rel="stylesheet">
<meta charset="UTF-8">
<title>도서정보</title>
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
      
#carouselExampleIndicators{
	margin-bottom: 30px;
}      
#carousel-row{
	margin-right: 7px;
    margin-left: 7px;
}

.card-body{
	background-color: aliceblue;
}

.carousel-indicators{
	bottom: -27px;
}
.carousel-indicators li {
	background-color : #adb5bd;
}

#id_rowSizePerPage{
	margin-left: 10px;
}

      img{ 
      height:220px;
      }

</style>
</head>
<body>
<%@include file="/inc/top_menu.jsp" %>
<div class="container">
	<div class="row page-header">
		<h1 style="margin-top: 20px;">도서목록</h1>
	</div>
		<div class="panel panel-default">
		<div class="panel-body">
		   <form name="frm_search" action="bookList.lol" method="post" class="form-horizontal">
			   <input type="hidden" name="curPage" value="${searchVO.curPage }">
				 <input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage }">
		  		<div class="jumbotron">
		  		<div class="row">
			    <div class="col-sm-1" style="margin-right: 110px;"></div>
			    <div class="col-sm-2">
			    <select id="id_searchType" name="searchType" class="form-control">
			    	<option value="N" ${"N" eq searchVO.searchType ? 'selected="selected"' : ''}>도서명</option>
						<option value="A" ${"A" == searchVO.searchType ? 'selected="selected"' : ''}>작가</option>
						<option value="C" ${searchVO.searchType.equals("C") ? 'selected="selected"' : ''}>출판사</option>
			    </select>
			    </div>
			    <div class="col-sm-4">
			      <input type="text" name="searchWord" class="form-control" value="${searchVO.searchWord}" placeholder="검색어">
			    </div>
			    
				  <div class="col-sm-2">
				  <button type="submit" class="btn btn-primary btn-xs blue">
						<i class="fa fa-search"></i>검 색
					</button>
				  </div>
				  </div>
			  </div>
		  </form>
	  </div>
	</div>
	
	<div>
		<h3>이주의 대전 인기 도서</h3>
	</div>
	
	
	
	
         <nav>
             <div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
             	 <a class="nav-item nav-link active" id="nav-total-tab" data-toggle="tab" href="#nav-total" role="tab" aria-controls="nav-total" aria-selected="true">전 체</a>
                 <a class="nav-item nav-link" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="false">문 학</a>
                 <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">역 사</a>
                 <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">예 술</a>
             </div>
         </nav>
	<div class="tab-content" id="nav-tabContent">
	<div class="tab-pane fade show active" id="nav-total" role="tabpanel" aria-labelledby="nav-total-tab">
	<div id="total" class="carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
    <li data-target="#total" data-slide-to="0" class="active"></li>
    <li data-target="#total" data-slide-to="1"></li>
    <li data-target="#total" data-slide-to="2"></li>
  </ol>
  <!-- 인기 대출 전체 -->
  <div class="carousel-inner">
	      <div class="carousel-item active">
	    	<div class="row" id="carousel-row">
			  <c:forEach items="${total}" var="rank" varStatus="st" begin="0" end="3">
				     <div class="col-md-3">
				     <c:choose>
					     <c:when test="${empty rank.bookImageUrl}">
					     	<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     		<img class="card-img-top" src="/image/emptybook.jpeg" alt="${rank.bookIsbn}">
					     	</a>
						 </c:when>
						<c:otherwise>
				          <a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     		<img class="card-img-top" src="${rank.bookImageUrl}" alt="${rank.bookIsbn}">
					     	</a>
						</c:otherwise>				     
				     </c:choose>
				          <div class="card-body" style="overflow : hidden;">
				          	<div style="height: 100px; overflow : hidden;">
					            <c:choose>
	              						<c:when test="${fn:length(rank.bookName) > 20}">
	              							<h4 class="card-title">${rank.bookNo}위. ${fn:substring(rank.bookName,0,20)}…</h4>
	              						</c:when>
	              						<c:otherwise>
											<h4 class="card-title">${rank.bookNo}위. ${rank.bookName}</h4>
	              						</c:otherwise>
	              				</c:choose>
				          	</div>	
				          	<div style="height: 50px;">
				            <p class="card-text">${rank.bookAuthors} | ${rank.bookPublisher} </p>
				            </div>
				        </div>
				      </div>
			  </c:forEach>    
	    	</div>
	    </div> 
        <div class="carousel-item">
        	<div class="row" id="carousel-row">
        	  <c:forEach items="${total}" var="rank" varStatus="st" begin="4" end="7">
					     <div class="col-md-3">
					          <c:choose>
							     <c:when test="${empty rank.bookImageUrl}">
							     	<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     				<img class="card-img-top" src="/image/emptybook.jpeg" alt="${rank.bookIsbn}">
					     			</a>
								 </c:when>
								<c:otherwise>
						          <a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     		<img class="card-img-top" src="${rank.bookImageUrl}" alt="${rank.bookIsbn}">
					     	</a>
								</c:otherwise>				     
						     </c:choose>    
					          <div class="card-body" style="overflow : hidden;">
	          					<div style="height: 100px; overflow : hidden;">	      
					            <c:choose>
	              						<c:when test="${fn:length(rank.bookName) > 20}">
	              							<h4 class="card-title">${rank.bookNo}위. ${fn:substring(rank.bookName,0,20)}…</h4>
	              						</c:when>
	              						<c:otherwise>
											<h4 class="card-title">${rank.bookNo}위. ${rank.bookName}</h4>
	              						</c:otherwise>
	              				</c:choose>
					            </div>
					            <div style="height: 50px;">
	           						<p class="card-text">${rank.bookAuthors} | ${rank.bookPublisher} </p>
					            </div>
					        </div>
					      </div>
				</c:forEach> 
			</div>
		</div>    				  
        <div class="carousel-item">
        	<div class="row" id="carousel-row">
			    <c:forEach items="${total}" var="rank" varStatus="st" begin="8">
				     <div class="col-md-3">     
					     <c:choose>
						     <c:when test="${empty rank.bookImageUrl}">
						     	<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     			<img class="card-img-top" src="/image/emptybook.jpeg" alt="${rank.bookIsbn}">
					     		</a>
							 </c:when>
							<c:otherwise>
					          <a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     		<img class="card-img-top" src="${rank.bookImageUrl}" alt="${rank.bookIsbn}">
					     	</a>
							</c:otherwise>				     
					     </c:choose>
				          <div class="card-body" style="overflow : hidden;">
          					<div style="height: 100px; overflow : hidden;">	      
					            <c:choose>
	              						<c:when test="${fn:length(rank.bookName) > 20}">
	              							<h4 class="card-title">${rank.bookNo}위. ${fn:substring(rank.bookName,0,20)}…</h4>
	              						</c:when>
	              						<c:otherwise>
											<h4 class="card-title">${rank.bookNo}위. ${rank.bookName}</h4>
	              						</c:otherwise>
	              				</c:choose>
				            </div>
				            <div style="height: 50px;">
           						<p class="card-text">${rank.bookAuthors} | ${rank.bookPublisher} </p>
				            </div>
				        </div>
				      </div>
			  </c:forEach> 
			</div>
		</div>    
  </div>
</div>
</div>

<!-- 인기 대출 문학 -->
<div class="tab-pane fade" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
	<div id="novel" class="carousel slide" data-ride="carousel">
	  <ol class="carousel-indicators">
	    <li data-target="#novel" data-slide-to="0" class="active"></li>
	    <li data-target="#novel" data-slide-to="1"></li>
	    <li data-target="#novel" data-slide-to="2"></li>
	  </ol>
  <div class="carousel-inner">
    <div class="carousel-item active">
    	<div class="row" id="carousel-row">
		  <c:forEach items="${novel}" var="rank" varStatus="st" begin="0" end="3">
			     <div class="col-md-3">
			         <c:choose>
					     <c:when test="${empty rank.bookImageUrl}">
					     		<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     			<img class="card-img-top" src="/image/emptybook.jpeg" alt="${rank.bookIsbn}">
					     		</a>
						 </c:when>
						<c:otherwise>
							<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     		<img class="card-img-top" src="${rank.bookImageUrl}" alt="${rank.bookIsbn}">
					     	</a>
						</c:otherwise>				     
				     </c:choose>
			          <div class="card-body" style="overflow : hidden;">
			          	<div style="height: 100px; overflow : hidden;">	          	
					            <c:choose>
	              						<c:when test="${fn:length(rank.bookName) > 20}">
	              							<h4 class="card-title">${rank.bookNo}위. ${fn:substring(rank.bookName,0,20)}…</h4>
	              						</c:when>
	              						<c:otherwise>
											<h4 class="card-title">${rank.bookNo}위. ${rank.bookName}</h4>
	              						</c:otherwise>
	              				</c:choose>
			          	</div>	
			          	<div style="height: 50px;">
			            <p class="card-text">${rank.bookAuthors} | ${rank.bookPublisher} </p>
			            </div>
			        </div>
			      </div>
		  </c:forEach>     
    	</div>
    </div>
    
    <div class="carousel-item">
       	<div class="row" id="carousel-row">
		    <c:forEach items="${novel}" var="rank" varStatus="st" begin="4" end="7">
			     <div class="col-md-3">
				          <c:choose>
						     <c:when test="${empty rank.bookImageUrl}">
					     		<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     			<img class="card-img-top" src="/image/emptybook.jpeg" alt="${rank.bookIsbn}">
					     		</a>							 </c:when>
							<c:otherwise>
							<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     		<img class="card-img-top" src="${rank.bookImageUrl}" alt="${rank.bookIsbn}">
					     	</a>							
					     	</c:otherwise>				     
					     </c:choose>
			          <div class="card-body" style="overflow : hidden;">
         					<div style="height: 100px; overflow : hidden;">	      
					            <c:choose>
	              						<c:when test="${fn:length(rank.bookName) > 20}">
	              							<h4 class="card-title">${rank.bookNo}위. ${fn:substring(rank.bookName,0,20)}…</h4>
	              						</c:when>
	              						<c:otherwise>
											<h4 class="card-title">${rank.bookNo}위. ${rank.bookName}</h4>
	              						</c:otherwise>
	              				</c:choose>
			            </div>
			            <div style="height: 50px;">
          						<p class="card-text">${rank.bookAuthors} | ${rank.bookPublisher} </p>
			            </div>
			        </div>
			      </div>
		  </c:forEach> 
   		</div>   
    </div>
    
    <div class="carousel-item">
       	<div class="row" id="carousel-row">
		    <c:forEach items="${novel}" var="rank" varStatus="st" begin="8" >
			     <div class="col-md-3">
			          <c:choose>
					     <c:when test="${empty rank.bookImageUrl}">
					     		<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     			<img class="card-img-top" src="/image/emptybook.jpeg" alt="${rank.bookIsbn}">
					     		</a>						 
					     </c:when>
						<c:otherwise>
							<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     		<img class="card-img-top" src="${rank.bookImageUrl}" alt="${rank.bookIsbn}">
					     	</a>
					     </c:otherwise>				     
				     </c:choose>
			          <div class="card-body" style="overflow : hidden;">
         					<div style="height: 100px; overflow : hidden;">	      
					            <c:choose>
	              						<c:when test="${fn:length(rank.bookName) > 20}">
	              							<h4 class="card-title">${rank.bookNo}위. ${fn:substring(rank.bookName,0,20)}…</h4>
	              						</c:when>
	              						<c:otherwise>
											<h4 class="card-title">${rank.bookNo}위. ${rank.bookName}</h4>
	              						</c:otherwise>
	              				</c:choose>
			            </div>
			            <div style="height: 50px;">
          						<p class="card-text">${rank.bookAuthors} | ${rank.bookPublisher} </p>
			            </div>
			        </div>
			      </div>
		  </c:forEach> 
   		</div>   
    </div>
  </div>
</div>
</div>

<!-- 인기 대출 역사 -->
<div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
	<div id="history" class="carousel slide" data-ride="carousel">
	  <ol class="carousel-indicators">
	    <li data-target="#history" data-slide-to="0" class="active"></li>
	    <li data-target="#history" data-slide-to="1"></li>
	    <li data-target="#history" data-slide-to="2"></li>
	  </ol>
  <div class="carousel-inner">
    <div class="carousel-item active">
    	<div class="row" id="carousel-row">
		  <c:forEach items="${history}" var="rank" varStatus="st" begin="0" end="3">
			     <div class="col-md-3">
			         <c:choose>
					     <c:when test="${empty rank.bookImageUrl}">
					     		<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     			<img class="card-img-top" src="/image/emptybook.jpeg" alt="${rank.bookIsbn}">
					     		</a>							 </c:when>
						<c:otherwise>
				          	<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     		<img class="card-img-top" src="${rank.bookImageUrl}" alt="${rank.bookIsbn}">
					     	</a>
						</c:otherwise>				     
				     </c:choose>
			          <div class="card-body" style="overflow : hidden;">
			          	<div style="height: 100px; overflow : hidden;">	          	
					            <c:choose>
	              						<c:when test="${fn:length(rank.bookName) > 20}">
	              							<h4 class="card-title">${rank.bookNo}위. ${fn:substring(rank.bookName,0,20)}…</h4>
	              						</c:when>
	              						<c:otherwise>
											<h4 class="card-title">${rank.bookNo}위. ${rank.bookName}</h4>
	              						</c:otherwise>
	              				</c:choose>
			          	</div>	
			          	<div style="height: 50px;">
			            <p class="card-text">${rank.bookAuthors} | ${rank.bookPublisher} </p>
			            </div>
			        </div>
			      </div>
		  </c:forEach>     
    	</div>
    </div>
    
    <div class="carousel-item">
       	<div class="row" id="carousel-row">
		    <c:forEach items="${history}" var="rank" varStatus="st" begin="4" end="7">
			     <div class="col-md-3">
			        <c:choose>
					     <c:when test="${empty rank.bookImageUrl}">
					     		<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     			<img class="card-img-top" src="/image/emptybook.jpeg" alt="${rank.bookIsbn}">
					     		</a>							 </c:when>
						<c:otherwise>
				          	<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     		<img class="card-img-top" src="${rank.bookImageUrl}" alt="${rank.bookIsbn}">
					     	</a>
						</c:otherwise>				     
				     </c:choose>
			          <div class="card-body" style="overflow : hidden;">
         					<div style="height: 100px; overflow : hidden;">	      
					            <c:choose>
	              						<c:when test="${fn:length(rank.bookName) > 20}">
	              							<h4 class="card-title">${rank.bookNo}위. ${fn:substring(rank.bookName,0,20)}…</h4>
	              						</c:when>
	              						<c:otherwise>
											<h4 class="card-title">${rank.bookNo}위. ${rank.bookName}</h4>
	              						</c:otherwise>
	              				</c:choose>
			            </div>
			            <div style="height: 50px;">
          						<p class="card-text">${rank.bookAuthors} | ${rank.bookPublisher} </p>
			            </div>
			        </div>
			      </div>
		  </c:forEach> 
   		</div>   
    </div>
    
    <div class="carousel-item">
       	<div class="row" id="carousel-row">
		    <c:forEach items="${history}" var="rank" varStatus="st" begin="8" >
			     <div class="col-md-3">
			          <c:choose>
					     <c:when test="${empty rank.bookImageUrl}">
					     		<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     			<img class="card-img-top" src="/image/emptybook.jpeg" alt="${rank.bookIsbn}">
					     		</a>							 </c:when>
						<c:otherwise>
				          	<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     		<img class="card-img-top" src="${rank.bookImageUrl}" alt="${rank.bookIsbn}">
					     	</a>
						</c:otherwise>				     
				     </c:choose>
			          <div class="card-body" style="overflow : hidden;">
         					<div style="height: 100px; overflow : hidden;">	      
					            <c:choose>
	              						<c:when test="${fn:length(rank.bookName) > 20}">
	              							<h4 class="card-title">${rank.bookNo}위. ${fn:substring(rank.bookName,0,20)}…</h4>
	              						</c:when>
	              						<c:otherwise>
											<h4 class="card-title">${rank.bookNo}위. ${rank.bookName}</h4>
	              						</c:otherwise>
	              				</c:choose>
			            </div>
			            <div style="height: 50px;">
          						<p class="card-text">${rank.bookAuthors} | ${rank.bookPublisher} </p>
			            </div>
			        </div>
			      </div>
		  </c:forEach> 
   		</div>   
    </div>
  </div>
</div>
</div>




	<div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
	<div id="art" class="carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
    <li data-target="#art" data-slide-to="0" class="active"></li>
    <li data-target="#art" data-slide-to="1"></li>
    <li data-target="#art" data-slide-to="2"></li>
  </ol>
  <div class="carousel-inner">
    <div class="carousel-item active">
    	<div class="row" id="carousel-row">
		  <c:forEach items="${art}" var="rank" varStatus="st" begin="0" end="3">
			     <div class="col-md-3">
			          <c:choose>
					     <c:when test="${empty rank.bookImageUrl}">
					     		<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     			<img class="card-img-top" src="/image/emptybook.jpeg" alt="${rank.bookIsbn}">
					     		</a>	
					     </c:when>
						<c:otherwise>
				          	<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     		<img class="card-img-top" src="${rank.bookImageUrl}" alt="${rank.bookIsbn}">
					     	</a>
						</c:otherwise>				     
				     </c:choose>
			          <div class="card-body" style="overflow : hidden;">
			          	<div style="height: 100px; overflow : hidden;">	          	
					            <c:choose>
	              						<c:when test="${fn:length(rank.bookName) > 20}">
	              							<h4 class="card-title">${rank.bookNo}위. ${fn:substring(rank.bookName,0,20)}…</h4>
	              						</c:when>
	              						<c:otherwise>
											<h4 class="card-title">${rank.bookNo}위. ${rank.bookName}</h4>
	              						</c:otherwise>
	              				</c:choose>
			          	</div>	
			          	<div style="height: 50px;">
			            <p class="card-text">${rank.bookAuthors} | ${rank.bookPublisher} </p>
			            </div>
			        </div>
			      </div>
		  </c:forEach>     
    	</div>
    </div>
    <div class="carousel-item">
        <div class="row" id="carousel-row">
		  <c:forEach items="${art}" var="rank" varStatus="st" begin="4" end="7">
			     <div class="col-md-3">
			         <c:choose>
					     <c:when test="${empty rank.bookImageUrl}">
					     		<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     			<img class="card-img-top" src="/image/emptybook.jpeg" alt="${rank.bookIsbn}">
					     		</a>							 
					     </c:when>
						<c:otherwise>
				          	<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     		<img class="card-img-top" src="${rank.bookImageUrl}" alt="${rank.bookIsbn}">
					     	</a>
						</c:otherwise>				     
				     </c:choose>
			          <div class="card-body" style="overflow : hidden;">
			          	<div style="height: 100px; overflow : hidden;">	          	
					            <c:choose>
	              						<c:when test="${fn:length(rank.bookName) > 20}">
	              							<h4 class="card-title">${rank.bookNo}위. ${fn:substring(rank.bookName,0,20)}…</h4>
	              						</c:when>
	              						<c:otherwise>
											<h4 class="card-title">${rank.bookNo}위. ${rank.bookName}</h4>
	              						</c:otherwise>
	              				</c:choose>
			          	</div>	
			          	<div style="height: 50px;">
			            <p class="card-text">${rank.bookAuthors} | ${rank.bookPublisher} </p>
			            </div>
			        </div>
			      </div>
		  </c:forEach>   
    	</div> 
    </div>
    
    <div class="carousel-item">
        <div class="row" id="carousel-row">
		  <c:forEach items="${art}" var="rank" varStatus="st" begin="8">
			     <div class="col-md-3">
			          <c:choose>
					     <c:when test="${empty rank.bookImageUrl}">
					     		<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     			<img class="card-img-top" src="/image/emptybook.jpeg" alt="${rank.bookIsbn}">
					     		</a>							 
					     </c:when>
						<c:otherwise>
				          	<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
					     		<img class="card-img-top" src="${rank.bookImageUrl}" alt="${rank.bookIsbn}">
					     	</a>
						</c:otherwise>				     
				     </c:choose>
			          <div class="card-body" style="overflow : hidden;">
			          	<div style="height: 100px; overflow : hidden;">	          	
					            <c:choose>
	              						<c:when test="${fn:length(rank.bookName) > 20}">
	              							<h4 class="card-title">${rank.bookNo}위. ${fn:substring(rank.bookName,0,20)}…</h4>
	              						</c:when>
	              						<c:otherwise>
											<h4 class="card-title">${rank.bookNo}위. ${rank.bookName}</h4>
	              						</c:otherwise>
	              				</c:choose>
			          	</div>	
			          	<div style="height: 50px;">
			            <p class="card-text">${rank.bookAuthors} | ${rank.bookPublisher} </p>
			            </div>
			        </div>
			      </div>
		  </c:forEach>   
    	</div> 
    </div>
  </div>
</div>
</div>
	</div>
	
	
	
	
	
	
	
	
	
	
	
		<div class="row" style="margin-top: 40px;">
		<div class="col-sm-3  form-inline" style="margin-bottom: 10px;  text-align:left ">
			전체 ${searchVO.totalRowCount} 건 
			<select id="id_rowSizePerPage" name="rowSizePerPage" class="form-control-sm">
				<option value="10" ${10 eq searchVO.rowSizePerPage ? 'selected="selected"' : ''}>10</option>
				<option value="20" ${20 eq searchVO.rowSizePerPage ? 'selected="selected"' : ''}>20</option>
				<option value="30" ${30 eq searchVO.rowSizePerPage ? 'selected="selected"' : ''}>30</option>
				<option value="50" ${50 eq searchVO.rowSizePerPage ? 'selected="selected"' : ''}>50</option>
			</select>
		</div>
	</div>	
	
	
		
	<table class="grid table table-striped table-hover">
	<colgroup>
		<col width="10%" />
		<col width="30%" />
		<col width="5%" />
		<col width="5%" />
		<col width="5%" />
		<col width="8%" />
	</colgroup>
	<thead  class="thead-dark">
	<tr>
		<th>도서번호</th>
		<th>도서명</th>
		<th>작가</th>
		<th>출판사</th>
		<th>출판연도</th>
		<th>도서대출 수</th>
	</tr>
	</thead>
	<c:forEach items="${list}" var="vo" varStatus="st">
	<tr class="text-center active">
		<td>${vo.bookIsbn}</td>
		<td class="text-left"><a style="color: black;font-weight: bold;" href="bookView.lol?bookIsbn=${vo.bookIsbn}&bookName=${vo.bookName}&bookAuthors=${vo.bookAuthors}">${vo.bookName}</a></td>
		<td>${vo.bookAuthors}</td>
		<td>${vo.bookPublisher}</td>
		<td>${vo.bookPublicationYear}</td>
		<td>${vo.bookLoanCnt} / ${vo.bookCount}
		<c:if test="${vo.bookLoanCnt eq vo.bookCount}">
		<a style="color: red;">대출불가</a>
		</c:if>
		<c:if test="${vo.bookLoanCnt ne vo.bookCount}">
		<a style="color: green;">대출가능</a>
		</c:if>
		</td>
		<%-- <td>${vo.bookCount}</td> --%>
	</tr>
	</c:forEach>
	</table>

<!-- 페이징 -->	
			<nav aria-label="Page navigation example">
				  <ul class="pagination justify-content-center">
					  <c:if test="${searchVO.curPage > searchVO.pageSize}">
					    <li class="page-item disabled">
					      <a class="page-link" href="bookList.lol?curPage=${searchVO.lastPage - searchVO.pageSize}" aria-label="Previous">
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
					    <li class="page-item"><a class="page-link" href="bookList.lol?curPage=${i}" data-page="${i}">${i}</a></li>
				    </c:if>
				    </c:forEach>  
				    <c:if test="${searchVO.lastPage != searchVO.totalPageCount}">
					    <li class="page-item">
					      <a class="page-link" href="bookList.lol?curPage=${searchVO.lastPage+1}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					        <span class="sr-only">Next</span>
					      </a>
					    </li>
					</c:if>
				  </ul>
				</nav>
			<hr>
		</div>

<%@include file="/inc/footer.jsp"%>
<script src="<c:url value='/js/top_menu.js'/>"></script>

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