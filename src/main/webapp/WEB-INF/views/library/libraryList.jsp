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
<title>대전 도서관 목록</title>
</head>
<body>
	<%@include file="/inc/top_menu.jsp"%>

	<div class="container">
		<div class="left">
			<h1 style="">대전 지역 도서관 목록</h1>
			<hr class="boardtitle">
		</div>
		<div class="row">
			<div class="pull-right">
				<div>
					<span id="total" class="glyphicon glyphicon-list"></span>
				</div>
			</div>

			<div id="map" style="width: 500px; height: 400px;"></div>



			<div style="float: left; width: 40%; margin-left: 50px; margin-top: 30px">
				<table id="mytable" class="table table-hover table-striped"	style="text-align: center; border: 1px solid;">
					<thead class="thead-dark">
						<tr>
							<th scope="col"	style="text-align: center;">도서관 이름</th>
							<!-- <th scope="col"
								style="background-color: #eeeeee; text-align: center;">주소</th> -->
							<!-- 							<th scope="col"
								style="background-color: #eeeeee; text-align: center;">전화번호</th> -->
							<!-- <th scope="col"
								style="background-color: #eeeeee; text-align: center;">운영시간</th> -->
							<th scope="col"	style="text-align: center;">홈페이지</th>
							<th scope="col"	style="text-align: center;">전화번호</th>
						</tr>
					</thead>
					<tbody class="mybody">
						<c:forEach items="${list}" var="vo" varStatus="status">
							<tr class="text-center">
								<form>
									<td class="active"><a style="color: blue" name="searchWord" value="${searchVO.searchWord}"
										href="libraryList.lol?libCode=${vo.libCode}&curPage=${searchVO.curPage}&searchWord=${searchVO.searchWord}">${vo.libName}</a></td>
										<input type="hidden" id="libUrl" value="${vo.libUrl}">
									<td  class="active"><a style="color: blue" href="${vo.libUrl}" target="_blank">홈페이지 바로가기</a></td>
									<td  class="active">${vo.libTel}</td>
								</form>
							</tr>
						</c:forEach>
					</tbody>
				</table>


				<form>
					<div style="margin: 0 auto;">
						<input type="hidden" value="${detail.libCode}" name="libCode">
					
						<input type="text" name="searchWord" class="form-control input-sm"
							value="${searchVO.searchWord}" placeholder="검색어" style="display: inline-block; width: 80%;">
						
						 <button type="submit" class="btn btn-primary btn-xs blue" style="display: inline-block;">
							<span class="fa fa-search"></span> 검 색
						 </button>
					</div>
				</form>
				
				
				<div style="text-align: center;">

				</div>
			</div>

			<br>


			<hr class="boardtitle">
			<hr>
			
		</div>
		<br>

		<nav aria-label="Page navigation example">
	  		<ul class="pagination justify-content-center">
				<!-- 이전 페이지  -->
				<c:if test="${searchVO.firstPage > 1}">
					 <li class="page-item disabled">
					 	<a class="page-link" href="libraryList.lol?curPage=${searchVO.lastPage - searchVO.pageSize}&libcode=${detail.libCode}" aria-label="Previous">
						<span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span>
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
						<li class="page-item"><a class="page-link" href="libraryList.lol?curPage=${i}&libcode=${detail.libCode}" data-page="${i}">${i}</a>
					</c:if>
				</c:forEach>
				
				<!-- 다음 페이지  -->
				<c:if test="${searchVO.lastPage < searchVO.totalPageCount}">
					<li class="page-item"><a class="page-link" href="libraryList.lol?curPage=${searchVO.lastPage+1}&libcode=${detail.libCode}" aria-label="Next">
							<span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span>
						</a>
					</li>
				</c:if>
			</ul>
		</nav>


	</div>  <!--container  -->
<hr>


	<%@include file="/inc/footer.jsp"%>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4290105fb11c5287ec4cb13e18464873"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script>
		var lat = "<c:out value='${detail.libLatitude}'/>";
		var lng = "<c:out value='${detail.libLongitude}'/>";

		if (lat == "" || lng == "") {
			lat = 36.3019
			lng = 127.348812
		}

		var container = document.getElementById('map');
		var options = {
			center : new kakao.maps.LatLng(lat, lng),
			level : 3
		};

		var map = new kakao.maps.Map(container, options); //맵 생성

		// 마커가 표시될 위치입니다 
		var markerPosition = new kakao.maps.LatLng(lat, lng);

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			position : markerPosition
		});
		
		var mapTypeControl = new kakao.maps.MapTypeControl();
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		
		
		marker.setMap(map);

	
	</script>
</body>


</html>