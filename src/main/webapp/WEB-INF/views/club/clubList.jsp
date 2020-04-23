<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
 <%@include file="/inc/common_header.jsp" %>
 <link href="<c:url value='/css/clubList.css'/>" rel="stylesheet">
<title>클럽목록</title>
<style type="text/css">
	#table-head{
		text-align: center;
	}
</style>
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet"> 
</head>

<body>
<%@include file="/inc/top_menu.jsp" %>

<div class="container mt-7">
 <h2 class="mb-5">클럽 목록</h2>
      <div class="row">
        <div class="col">
          <div class="card shadow">
            <div class="card-header border-0">
            	<div class="row">
            		<div class="col-sm-11">
		 				<h3 class="mb-0">클럽 목록</h3>
		 			</div>
					<c:if test="${not empty sessionScope.USER_INFO}">
		              <h4><a href="clubForm.lol"  class="btn btn-success btn-sm pull-right">클럽등록</a> </h4>
		              </c:if>   
		 		</div>
            </div>
            <div class="table-responsive">
              <table class="table align-items-center table-flush">
                <thead class="thead-light">
                  <tr>
                    <th scope="col">클럽명</th>
                    <th scope="col">지역</th>
                    <th scope="col">연령</th>
                    <th scope="col">Users</th>
                    <th scope="col">회원수</th>
                    <th scope="col"></th>
                  </tr>
                </thead>
                <tbody>
                <c:forEach items="${list}" var="cb" varStatus="st">
                	<tr>
	                	 <th scope="row">
	                      <div class="media align-items-center">
	                        <a href="#" class="avatar rounded-circle mr-3">
	                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/bootstrap.jpg">
	                        </a>
	                        <div class="media-body">
	                          <span class="mb-0 text-sm">${cb.bkClubName}</span>
	                        </div>
	                      </div>
	                    </th>
		                <td>
	                      ${cb.bkLocation}
	                    </td>
		                 <td>
		                      <span class="badge badge-dot mr-4">
		                        	<i class="bg-success"></i> ${cb.bkAge}
		                      </span>
	                    </td>
	                    
		                <td>
	                      <div class="avatar-group">                   
	                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Ryan Tompson">
	                          <img alt="Image placeholder" src="/image/profileimg.jpeg" class="rounded-circle">
	                        </a>
	                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Romina Hadid">
	                          <img alt="Image placeholder" src="/image/profileimg.jpeg" class="rounded-circle">
	                        </a>
	                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Alexander Smith">
	                          <img alt="Image placeholder" src="/image/profileimg.jpeg" class="rounded-circle">
	                        </a>
	                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Jessica Doe">
	                          <img alt="Image placeholder" src="/image/profileimg.jpeg" class="rounded-circle">
	                        </a>
	                      </div>
	                    </td>
	                  <td>
                      <div class="d-flex align-items-center">
                        <span class="mr-2">${cb.bkMemCnt} / ${cb.bkLimit}</span>
                        <div>
                          <div class="progress">
                            <div class="progress-bar bg-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;"></div>
                          </div>
                        </div>
                      </div>
                    </td>
	                <td class="text-right">
                      <div class="dropdown">
                        <a class="btn btn-sm btn-icon-only text-light" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                          <i class="fas fa-ellipsis-v"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
                          <a class="dropdown-item" href="clubView.lol?bkClubName=${cb.bkClubName}">클럽 상세보기</a>
                          <a class="dropdown-item" href="#">${cb.bkMemCnt} / ${cb.bkLimit}</a>
                          <a class="dropdown-item" href="#">Something else here</a>
                        </div>
                      </div>
                    </td>
                	</tr>
                </c:forEach>
                
                
                
                
                
                
                
                  <tr>
                    <th scope="row">
                      <div class="media align-items-center">
                        <a href="#" class="avatar rounded-circle mr-3">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/bootstrap.jpg">
                        </a>
                        <div class="media-body">
                          <span class="mb-0 text-sm">Argon Design System</span>
                        </div>
                      </div>
                    </th>
                    <td>
                      $2,500 USD
                    </td>
                    <td>
                      <span class="badge badge-dot mr-4">
                        <i class="bg-warning"></i> pending
                      </span>
                    </td>
                    <td>
                      <div class="avatar-group">                   
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Ryan Tompson">
                          <img alt="Image placeholder" src="/image/profileimg.jpeg" class="rounded-circle">
                        </a>
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Romina Hadid">
                          <img alt="Image placeholder" src="/image/profileimg.jpeg" class="rounded-circle">
                        </a>
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Alexander Smith">
                          <img alt="Image placeholder" src="/image/profileimg.jpeg" class="rounded-circle">
                        </a>
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Jessica Doe">
                          <img alt="Image placeholder" src="/image/profileimg.jpeg" class="rounded-circle">
                        </a>
                      </div>
                    </td>
                    
                     <td>
                      <div class="d-flex align-items-center">
                        <span class="mr-2">100%</span>
                        <div>
                          <div class="progress">
                            <div class="progress-bar bg-success" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%;"></div>
                          </div>
                        </div>
                      </div>
                    </td>
                    
                    <td class="text-right">
                      <div class="dropdown">
                        <a class="btn btn-sm btn-icon-only text-light" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                          <i class="fas fa-ellipsis-v"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
                          <a class="dropdown-item" href="clubView.lol?bkClubName=${cb.bkClubName}">Action</a>
                          <a class="dropdown-item" href="#">Another action</a>
                          <a class="dropdown-item" href="#">Something else here</a>
                        </div>
                      </div>
                    </td>
                    
                  </tr>

                  
                  
                  <tr>
                    <th scope="row">
                      <div class="media align-items-center">
                        <a href="#" class="avatar rounded-circle mr-3">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/angular.jpg">
                        </a>
                        <div class="media-body">
                          <span class="mb-0 text-sm">Angular Now UI Kit PRO</span>
                        </div>
                      </div>
                    </th>
                    <td>
                      $1,800 USD
                    </td>
                    <td>
                      <span class="badge badge-dot">
                        <i class="bg-success"></i> completed
                      </span>
                    </td>
                    <td>
                      <div class="avatar-group">
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Ryan Tompson">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/team-1-800x800.jpg" class="rounded-circle">
                        </a>
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Romina Hadid">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/team-2-800x800.jpg" class="rounded-circle">
                        </a>
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Alexander Smith">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/team-3-800x800.jpg" class="rounded-circle">
                        </a>
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Jessica Doe">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/team-4-800x800.jpg" class="rounded-circle">
                        </a>
                      </div>
                    </td>
                    <td>
                      <div class="d-flex align-items-center">
                        <span class="mr-2">100%</span>
                        <div>
                          <div class="progress">
                            <div class="progress-bar bg-success" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%;"></div>
                          </div>
                        </div>
                      </div>
                    </td>
                    <td class="text-right">
                      <div class="dropdown">
                        <a class="btn btn-sm btn-icon-only text-light" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                          <i class="fas fa-ellipsis-v"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
                          <a class="dropdown-item" href="#">Action</a>
                          <a class="dropdown-item" href="#">Another action</a>
                          <a class="dropdown-item" href="#">Something else here</a>
                        </div>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <th scope="row">
                      <div class="media align-items-center">
                        <a href="#" class="avatar rounded-circle mr-3">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/sketch.jpg">
                        </a>
                        <div class="media-body">
                          <span class="mb-0 text-sm">Black Dashboard</span>
                        </div>
                      </div>
                    </th>
                    <td>
                      $3,150 USD
                    </td>
                    <td>
                      <span class="badge badge-dot mr-4">
                        <i class="bg-danger"></i> delayed
                      </span>
                    </td>
                    <td>
                      <div class="avatar-group">
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Ryan Tompson">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/team-1-800x800.jpg" class="rounded-circle">
                        </a>
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Romina Hadid">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/team-2-800x800.jpg" class="rounded-circle">
                        </a>
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Alexander Smith">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/team-3-800x800.jpg" class="rounded-circle">
                        </a>
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Jessica Doe">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/team-4-800x800.jpg" class="rounded-circle">
                        </a>
                      </div>
                    </td>
                    <td>
                      <div class="d-flex align-items-center">
                        <span class="mr-2">72%</span>
                        <div>
                          <div class="progress">
                            <div class="progress-bar bg-danger" role="progressbar" aria-valuenow="72" aria-valuemin="0" aria-valuemax="100" style="width: 72%;"></div>
                          </div>
                        </div>
                      </div>
                    </td>
                    <td class="text-right">
                      <div class="dropdown">
                        <a class="btn btn-sm btn-icon-only text-light" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                          <i class="fas fa-ellipsis-v"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
                          <a class="dropdown-item" href="#">Action</a>
                          <a class="dropdown-item" href="#">Another action</a>
                          <a class="dropdown-item" href="#">Something else here</a>
                        </div>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <th scope="row">
                      <div class="media align-items-center">
                        <a href="#" class="avatar rounded-circle mr-3">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/react.jpg">
                        </a>
                        <div class="media-body">
                          <span class="mb-0 text-sm">React Material Dashboard</span>
                        </div>
                      </div>
                    </th>
                    <td>
                      $4,400 USD
                    </td>
                    <td>
                      <span class="badge badge-dot">
                        <i class="bg-info"></i> on schedule
                      </span>
                    </td>
                    <td>
                      <div class="avatar-group">
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Ryan Tompson">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/team-1-800x800.jpg" class="rounded-circle">
                        </a>
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Romina Hadid">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/team-2-800x800.jpg" class="rounded-circle">
                        </a>
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Alexander Smith">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/team-3-800x800.jpg" class="rounded-circle">
                        </a>
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Jessica Doe">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/team-4-800x800.jpg" class="rounded-circle">
                        </a>
                      </div>
                    </td>
                    <td>
                      <div class="d-flex align-items-center">
                        <span class="mr-2">90%</span>
                        <div>
                          <div class="progress">
                            <div class="progress-bar bg-info" role="progressbar" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100" style="width: 90%;"></div>
                          </div>
                        </div>
                      </div>
                    </td>
                    <td class="text-right">
                      <div class="dropdown">
                        <a class="btn btn-sm btn-icon-only text-light" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                          <i class="fas fa-ellipsis-v"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
                          <a class="dropdown-item" href="#">Action</a>
                          <a class="dropdown-item" href="#">Another action</a>
                          <a class="dropdown-item" href="#">Something else here</a>
                        </div>
                      </div>
                    </td>
                  </tr>
                  <tr>
                    <th scope="row">
                      <div class="media align-items-center">
                        <a href="#" class="avatar rounded-circle mr-3">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/vue.jpg">
                        </a>
                        <div class="media-body">
                          <span class="mb-0 text-sm">Vue Paper UI Kit PRO</span>
                        </div>
                      </div>
                    </th>
                    <td>
                      $2,200 USD
                    </td>
                    <td>
                      <span class="badge badge-dot mr-4">
                        <i class="bg-success"></i> completed
                      </span>
                    </td>
                    <td>
                      <div class="avatar-group">
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Ryan Tompson">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/team-1-800x800.jpg" class="rounded-circle">
                        </a>
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Romina Hadid">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/team-2-800x800.jpg" class="rounded-circle">
                        </a>
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Alexander Smith">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/team-3-800x800.jpg" class="rounded-circle">
                        </a>
                        <a href="#" class="avatar avatar-sm" data-toggle="tooltip" data-original-title="Jessica Doe">
                          <img alt="Image placeholder" src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/img/theme/team-4-800x800.jpg" class="rounded-circle">
                        </a>
                      </div>
                    </td>
                    <td>
                      <div class="d-flex align-items-center">
                        <span class="mr-2">100%</span>
                        <div>
                          <div class="progress">
                            <div class="progress-bar bg-success" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%;"></div>
                          </div>
                        </div>
                      </div>
                    </td>
                    <td class="text-right">
                      <div class="dropdown">
                        <a class="btn btn-sm btn-icon-only text-light" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                          <i class="fas fa-ellipsis-v"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
                          <a class="dropdown-item" href="#">Action</a>
                          <a class="dropdown-item" href="#">Another action</a>
                          <a class="dropdown-item" href="#">Something else here</a>
                        </div>
                      </div>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
            <div class="card-footer py-4">
				<nav aria-label="Page navigation example">
				  <ul class="pagination justify-content-center">
					  <c:if test="${searchVO.firstPage > 1}">
					    <li class="page-item disabled">
					      <a class="page-link" href="clubList.lol?curPage=${searchVO.firstPage - 1}" aria-label="Previous">
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
					    <li class="page-item"><a class="page-link" href="clubList.lol?curPage=${i}" data-page="${i}">${i}</a></li>
				    </c:if>
				    </c:forEach>  
				    <c:if test="${searchVO.lastPage < searchVO.totalPageCount}">
					    <li class="page-item">
					      <a class="page-link" href="clubList.lol?curPage=${searchVO.lastPage + 1}" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					        <span class="sr-only">Next</span>
					      </a>
					    </li>
					</c:if>
				  </ul>
				</nav>
            </div>
          </div>
        </div>
      </div>
</div>






















<%-- <div class="container">
	<div class="row page-header">
		<h2>클럽 목록</h2>
	</div>
	<hr>
	<div class="page-header">
		<div class="panel panel-default">
			<!-- 검색폼 -->
		</div>
	</div>
	<div class="col-sm-2 col-sm-offset-7 text-right"
		style="margin-bottom: 5px">
		<c:if test="${not empty sessionScope.USER_INFO}">
			<i class="fa fa-plus"></i>
			<a href="clubForm.lol" class="btn btn-primary btn-sm">클럽등록</a>
		</c:if>
	</div>
	<table class="grid table table-striped table-bordered table-hover">
		<colgroup>
			<col width="5%" />
			<col width="20%" />
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
			<col width="5%" />
		</colgroup>
		<tr>
			<th>번호</th>
			<th>클럽명</th>
			<th>클럽장</th>
			<th>지역</th>
			<th>연령</th>
			<th>회원수</th>
		</tr>
		
		<c:forEach items="${list}" var="cb" varStatus="st">
			<tr>
				<td>${st.count}</td>				
				<td>${cb.bkNum}</td>
				<td><a href="clubView.lol?bkNum=${cb.bkNum}">${cb.bkClubName}</a></td>
				<td>${cb.bkMemId}</td>
				<td>${cb.bkLocation}</td>
				<td>${cb.bkAge}</td>
				<td>${cb.bkMemCnt} / ${cb.bkLimit}</td>
			</tr>
		</c:forEach>
	</table>
<<<<<<< .mine
	






<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
	  <c:if test="${searchVO.firstPage > 1}">
	    <li class="page-item disabled">
	      <a class="page-link" href="clubList.lol?curPage=${searchVO.firstPage - 1}" aria-label="Previous">
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
	    <li class="page-item"><a class="page-link" href="clubList.lol?curPage=${i}" data-page="${i}">${i}</a></li>
    </c:if>
    </c:forEach>  
    <c:if test="${searchVO.lastPage < searchVO.totalPageCount}">
	    <li class="page-item">
	      <a class="page-link" href="clubList.lol?curPage=${searchVO.lastPage + 1}" aria-label="Next">
	        <span aria-hidden="true">&raquo;</span>
	        <span class="sr-only">Next</span>
	      </a>
	    </li>
	</c:if>
  </ul>
</nav> --%>
	
	
	
<%-- 	<nav class="text-center">
=======
	
	
	<nav class="text-center">
>>>>>>> .r303
		<ul class="pagination">
    	<!-- 이전 페이지  -->
    	<c:if test="${searchVO.firstPage > 1}">
		<li class="disabled">
      		<a href="clubList.lol?curPage=${searchVO.firstPage - 1}" aria-label="Previous">
        	<span aria-hidden="true">&laquo;</span>
      		</a>
	    </li>
	    </c:if>
	    <!-- 페이징  -->
		<c:forEach var="i" begin="${searchVO.firstPage}" end="${searchVO.lastPage}">
		<c:if test="${searchVO.curPage eq i}">
			<li class="active"><a href="#">${i}</a>
		</c:if>
		<c:if test="${searchVO.curPage ne i}">
			<li>
				<a href="clubList.lol?curPage=${i}" data-page="${i}">${i}</a>
		</c:if>
		</c:forEach>
    	<!-- 다음 페이지  -->
		<c:if test="${searchVO.lastPage < searchVO.totalPageCount}">
			<li>
      			<a href="clubList.lol?curPage=${searchVO.lastPage + 1}" aria-label="Next">
        		<span aria-hidden="true">&raquo;</span>
      			</a>
    		</li>
		</c:if>
		</ul>
	</nav> --%>
<!-- </div> -->
	<hr>
<%@include file="/inc/footer.jsp" %>
<script src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/vendor/jquery/dist/jquery.min.js"></script>
  <script src="https://raw.githack.com/creativetimofficial/argon-dashboard/master/assets/vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<script src="<c:url value='/js/top_menu.js'/>"></script>
</body>
</html>
