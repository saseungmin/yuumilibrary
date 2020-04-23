<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

<!DOCTYPE html>
<html>
<head>
<%@include file="/inc/common_header.jsp"%>
<link href="<c:url value='/css/bookView.css'/>" rel="stylesheet">	
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet">	
<meta charset="UTF-8">
<title>도서상세정보</title>
<style type="text/css">

 #carouselExampleIndicators{
	margin-bottom: 30px;
}      
#carousel-row{
	margin-right: 7px;
    margin-left: 7px;
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
      height:200px;
      } 

</style>


</head>
<body>
	<%@include file="/inc/top_menu.jsp"%>
	<div class="container">
		
		
 <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <div class="card mb-10">
          <div class="card-header">
            <nav class="header-navigation">
              <a href="<%=request.getContextPath() %>/book/bookList.lol" class="btn btn-xs dark"><i class="fas fa-list"></i>목록으로</a>
            </nav>
          </div>
          <div class="card-body store-body">
            <div class="product-info">
              <div class="product-gallery">
                <div class="product-gallery-featured">
                <c:choose>
                	<c:when test="${empty apibook.bookImageURL}">
                		<img src="/image/emptybook.jpeg">
                	</c:when>
                	<c:otherwise>
                		<img src="${apibook.bookImageURL}">
                	</c:otherwise>
                </c:choose>

                </div>
              </div>
              <div class="product-seller-recommended">
                <h3 class="mb-5">추천 도서</h3>
    
<div class="tab-pane fade show active" id="nav-total" role="tabpanel" aria-labelledby="nav-total-tab">
	<div id="total" class="carousel slide" data-ride="carousel" style="margin-bottom: 40px;">
  <ol class="carousel-indicators">
    <li data-target="#total" data-slide-to="0" class="active"></li>
    <li data-target="#total" data-slide-to="1"></li>
    <li data-target="#total" data-slide-to="2"></li>
  </ol>
  <!-- 인기 대출 전체 -->
  <div class="carousel-inner">
	      <div class="carousel-item active">
	    	<div class="row" id="carousel-row">
			  <c:forEach items="${recommend}" var="rank" varStatus="st" begin="0" end="3">
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
	              						<c:when test="${fn:length(rank.bookName) > 15}">
	              							<h5 class="card-title"> ${fn:substring(rank.bookName,0,15)}…</h5>
	              						</c:when>
	              						<c:otherwise>
											<h5 class="card-title"> ${rank.bookName}</h5>
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
        	  <c:forEach items="${recommend}" var="rank" varStatus="st" begin="4" end="7">
					     <div class="col-md-3">
					          <c:choose>
							     <c:when test="${empty rank.bookImageUrl}">
							     	<a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
							     		<img class="card-img-top" src="/image/emptybook.jpeg" alt="${rank.bookIsbn}">
							     	</a>								 </c:when>
								<c:otherwise>
						          <a href="bookView.lol?bookIsbn=${rank.bookIsbn}&bookName=${rank.bookName}&bookAuthors=${rank.bookAuthors}">
						          	<img class="card-img-top" src="${rank.bookImageUrl}" alt="${rank.bookIsbn}">
						          </a>								
				          </c:otherwise>				     
						     </c:choose>    
					          <div class="card-body" style="overflow : hidden;">
	          					<div style="height: 100px; overflow : hidden;">	      
					            <c:choose>
	              						<c:when test="${fn:length(rank.bookName) > 15}">
	              							<h5 class="card-title"> ${fn:substring(rank.bookName,0,15)}…</h5>
	              						</c:when>
	              						<c:otherwise>
											<h5 class="card-title"> ${rank.bookName}</h5>
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
			    <c:forEach items="${recommend}" var="rank" varStatus="st" begin="8">
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
	              						<c:when test="${fn:length(rank.bookName) > 15}">
	              							<h5 class="card-title"> ${fn:substring(rank.bookName,0,15)}…</h5>
	              						</c:when>
	              						<c:otherwise>
											<h5 class="card-title"> ${rank.bookName}</h5>
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

                <!-- /.recommended-items-->
                <div class="product-description mb-5">
                  <h2 class="mb-5">소개</h2>
                  <dl class="row mb-5">
                    <dt class="col-sm-3">ISBN13</dt>
                    <dd class="col-sm-9">${apibook.isbn13}</dd>
                    <dt class="col-sm-3">책 이름</dt>
                    <dd class="col-sm-9">${apibook.bookname}</dd>
                    <dt class="col-sm-3">저자명</dt>
                    <dd class="col-sm-9">${apibook.authors}</dd>
                    <dt class="col-sm-3">출판사</dt>
                    <dd class="col-sm-9">${apibook.publisher}</dd>
                    <dt class="col-sm-3">class_no</dt>
                    <dd class="col-sm-9">${apibook.class_no}</dd>
                    <dt class="col-sm-3">출판 날짜</dt>
                    <dd class="col-sm-9">${apibook.publication_date}</dd>
                  </dl>
                  <h2 class="mb-5">줄거리</h2>
                  <p>${apibook.description}</p>
                </div>
              </div>
            </div>
            <div class="product-payment-details">
              <p class="last-sold text-muted"><small>isbn13 : ${apibook.isbn13}</small></p>
              <h2 class="product-title mb-2">${apibook.bookname}</h2>
              		<form name="formName" action="<c:url value='/book/bookLoan.lol'/>" method="post" onclick="return false;">
						<input type="hidden" name="bookIsbn" id="bookIsbn" value="${apibook.isbn13}"> 
						<input type="hidden" name="bookName" id="bookName" value="${book.bookName}"> 	
						<input type="hidden" name="bookAuthors" id="bookAuthors" value="${book.bookAuthors}"> 	
						<input type="hidden" name="loaMemId" id="loaMemId" value="${sessionScope.USER_INFO.userID}">
 						<c:choose>
							<c:when test="${not empty sessionScope.USER_INFO and book.bookCount ne book.bookLoanCnt}">
								<div class="alert alert-primary" role="alert" style="margin-top:50px;">		
								<p>총 ${book.bookCount}권/${book.bookLoanCnt} 대출 중 <br> <h4>대출가능</h4></p>
								</div>
								<button type="button" id="loan_button" class="btn btn-primary btn-lg btn-block blue" ><i class="fas fa-book-open"></i>대출하기</button>
							
							</c:when>
							<c:otherwise>
								<div class="alert alert-danger" role="alert" style="margin-top:50px;">
								  <p>총 ${book.bookCount}권/${book.bookLoanCnt} 대출 중 <br> 
								  		<h4>대출불가</h4>
								  	<c:if test="${empty sessionScope.USER_INFO}">
								  		<p>- 로그인 후 이용하세요.</p>
								  	</c:if>
								  		
								  </p>
								</div>								
							</c:otherwise>
						</c:choose>
					</form>        
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
		
		
		
		
		
		
		
<%-- 		<h4>정보</h4>
		<div class="col-sm-2 col-sm-offset-10 text-right" style="margin-bottom:5px;">
		<form name="formName" action="<c:url value='/book/bookLoan.lol'/>" method="post" onclick="return false;">
	<input type="hidden" name="bookIsbn" id="bookIsbn" value="${apibook.isbn13}"> 
	<input type="hidden" name="bookName" id="bookName" value="${book.bookName}"> 	
	<input type="hidden" name="bookAuthors" id="bookAuthors" value="${book.bookAuthors}"> 	
	<input type="hidden" name="loaMemId" id="loaMemId" value="${sessionScope.USER_INFO.userID}"> 
		<a href="<%=request.getContextPath()%>/book/bookLoan.lol" class="btn  btn-warning"><i class="fa fa-plus"></i>&nbsp;&nbsp;대출하기</a>
		<c:if test="${not empty sessionScope.USER_INFO and book.bookCount ne book.bookLoanCnt}">
		<button type="button" id="loan_button" class="btn btn-sm btn-success pull-right" ><i class="fas fa-user-edit"></i>&nbsp;대출하기</button>
		</c:if>
		</form>
		</div>
		ISBN13 : ${apibook.isbn13}<br>
		책이름 : ${apibook.bookname}<br>		
		<img src="${apibook.bookImageURL}"><br>
		저자명 : ${apibook.authors}<br>
		출판사 : ${apibook.publisher}<br>
		-------------------------<br>
		<h3>책 소개</h3>${apibook.description} <br> --%>
		
	</div>
	<hr>
	<%@include file="/inc/footer.jsp"%>

<script type="text/javascript">

$("#loan_button").click(function(e) {
	e.preventDefault();
	f = document.forms.formName
	params = $(f).serialize();
	
	console.log(params);
	
	$.ajax({
		 type : "POST"
		,url : "<c:url value='/book/bookLoan.lol'/>"
		,dataType : "Json"
		,data : params
		,success : function(data) {
			console.log(data);
			if(data.result){
				swal({
	                 title: data.message,
	                 icon: "success",
	                 button: "닫기"
	             }).then(function(){
	            	 location.href = "loanList.lol?memId="+data.user;
	            			 })	
			}else{
				swal({
	                 text: data.message,
	                 icon: "error",
	                 button: "닫기"
	             });
				return false;
			}
			
		},error : function(req, st, err) {
			console.log(req);
		}
	});
	
});

//# sourceURL=pen.js


/*  function book_loan() { 
	 
		swal({
						title : "대출 확인되었습니다.",
            text: "대출한 도서 : ${book.bookName}",
            icon: "success",
            button: "확인"
        }).then(function(){
        		return true;
        }) */
	 
	
/*  swal ( " 정말입니까? " , { 
		  dangerMode : true, 
		  buttons: "닫기" ,
		} ) ;
	return false;  */

/* 	swal("Are you sure you want to do this?", {
		  buttons: ["Oh noez!", true],
		});
	return true; */
	 

 
</script>


</body>
</html>