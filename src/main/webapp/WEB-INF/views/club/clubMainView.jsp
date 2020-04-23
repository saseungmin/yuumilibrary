<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@include file="/inc/common_header.jsp"%>
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet">
<title>클럽상세</title>
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
	<!-- Page Content -->
	<div class="container">
	<input type="hidden" name="chatUserId" value="${club.bkNum}">
		<!-- Heading Row -->
		<div class="row align-items-center my-5">
			<div class="col-lg-7">
				<c:choose>
					<c:when test="${empty club.bkImageurl}">
						<img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png"
							alt="사진을 등록해주세요.">
					</c:when>
					<c:otherwise>
						<img class="card-img-top"
							src="/image/clubProfileImg/${club.bkImageurl}" alt="">
					</c:otherwise>
				</c:choose>
			</div>
			<!-- /.col-lg-8 -->
			<div class="col-lg-5">
				<input type="hidden" id="checkLogin"
					value="${sessionScope.USER_INFO.userID}"> <br>
				<h1 class="font-weight-light">${club.bkClubName}</h1>
				<p>${club.bkTheme}</p>
				<p>${club.bkTime}</p>
				<form name="formName" action="clubMemberRegist.lol" method="post">
					<c:if
						test="${not empty sessionScope.USER_INFO && club.bkMemCnt < club.bkLimit && sessionScope.USER_INFO.userID ne club.bkMemId && mem <= 0}">
						<div>
							<input type="hidden" name="bkNum" value="${club.bkNum}">
							<input type="hidden" name="bkClubName" value="${club.bkClubName}">
							<input type="hidden" name="bkMemId"
								value="${sessionScope.USER_INFO.userID}">
							<button type="submit" id="btn_join" class="btn dark"><i class="far fa-hand-point-right"></i>가입신청하기</button>
						</div>
					</c:if>
				</form>
				<form action="clubMemberDelete.lol" name="formNm" method="post">
					<c:if test="${not empty sessionScope.USER_INFO.userID && mem > 0 && club.bkClubName}">
						<div>
							<input type="hidden" name="cmNum" value="${club.bkNum}">
							<input type="hidden" name="cmClubName" value="${club.bkClubName}">
							<input type="hidden" name="cmMemId"
								value="${sessionScope.USER_INFO.userID}">
							<button type="submit" id="btn_delete" class="btn red"><i class="fa fa-times"></i>클럽탈퇴하기</button>
						</div>
					</c:if>
				</form>
				<input type="hidden" id="checkLogin"
					value="${sessionScope.USER_INFO.userID}">
				<c:if test="${empty sessionScope.USER_INFO.userID}">
					<button type="button" onclick="javascript:logincheck()"
						class="btn btn dark"><i class="far fa-hand-point-right"></i>가입신청하기</button>
				</c:if>
				<c:if
					test="${sessionScope.USER_INFO.userID eq club.bkMemId || sessionScope.USER_INFO.userRole eq '관리자'}">
						<a href="clubEdit.lol?bkNum=${club.bkNum}"
							class="btn green"><i class="fa fa-pencil"></i> 정보수정</a>
						<form action="clubMemberList.lol" method="post">
						<br>
							<div>
								<input type="hidden" name="cmNum" value="${club.bkNum}">
								<input type="hidden" name="cmClubName" value="${club.bkClubName}">
								<button type="submit" class="btn green"><i class="fa fa-list"></i> 클럽회원관리</button>
							</div>
						</form>
				</c:if>
			</div>
			<!-- /.col-md-4 -->
		</div>
		<!-- /.row -->

		<!-- Call to Action Well -->
<!-- 		<div class="card text-white bg-secondary my-5 py-4 text-center">
			<div class="card-body">
				<p class="text-white m-0">
					새소식<br>가장 최근 공지사항 정도 넣기..<br>게시판이나 클럽마스터의 관리페이지는 어디다가 넣지?
				</p>
			</div>
		</div> -->


		<!-- *******************카드들 -->
		<!-- Content Row -->
<%-- 		<div class="row">
			<div class="col-md-4 mb-5">
				<div class="card h-100">
					<div class="card-body">
						<h2 class="card-title">Card One</h2>
						<p class="card-text">여긴 뭐 넣거나 다 없애고 채팅창 정도???</p>
					</div>
					<div class="card-footer">
						<a href="#" class="btn btn-primary btn-sm" id="chatOpen">More Info</a>
					</div>
				</div>
			</div>
			<!-- /.col-md-4 -->
			<div class="col-md-4 mb-5">
				<div class="card h-100">
					<div class="card-body">
						<h2 class="card-title">Card Two</h2>
						<p class="card-text">클럽게시판 바로가기?</p>
					</div>
					<div class="card-footer">
						<a href="/club/clubBoardList.lol?cbBoClubNum=${club.bkNum}" class="btn btn-primary btn-sm">클럽게시판으로 가기</a>
					</div>
				</div>
			</div>

		</div> --%>
		<!-- /.row -->

		
			<a href="#" id="chatOpen" class="btn btn-primary btn-lg red"><i class="fas fa-comment-dots" id="chatOpen"></i>클럽채팅</a>
		
		
		<!-- 검색폼!!!!!!!!!!!! -->
		<div class="panel panel-default ">
		<div class="panel-body">
		   <form name="frm_search" action="freeList.lol" method="post" class="form-horizontal">
			  <input type="hidden" name="curPage" value="${searchVO.curPage }">
			  <input type="hidden" name="rowSizePerPage" value="${searchVO.rowSizePerPage }">
			  <div class="jumbotron">
			  <div class="row">
			  <div class="col-sm-1" style="margin-right: 120px;"></div> 
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
	 			  <button type="submit" class="btn btn-primary btn-xs blue">
						<span class="fa fa-search"></span> 검 색
					</button>
				 </div>
			  </div>
			  </div>
		  </form>
		  </div>
		</div>
		<!-- 검색폼끝!! -->
		
		
		<div class="row">
			<div class="col-sm-10"></div>
			<div class="col-sm-2" style="margin-bottom:5px; text-align:right ">
			<c:if test="${sessionScope.USER_INFO ne null}">
				<form action="clubBoardForm.lol" method="post">
					<input type="hidden" name="cbBoClubNum" value="${club.bkNum}">
					<button type="submit" class="btn btn-sm warning">
						<i class="fa fa-plus"></i> &nbsp;&nbsp;글쓰기
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
				<c:if test="${not empty list}">
					<c:forEach items="${list}" var="vo" varStatus="st">
						<tr class="text-center">
								<td>${vo.cbBoNum}</td>
								<td class="text-center"><a href="clubBoardView.lol?cbBoClubNum=${vo.cbBoClubNum}&cbBoNum=${vo.cbBoNum}&notice=${vo.cbBoNotice}">
															${vo.cbBoTitle} </a></td>
								<td>${vo.cbBoWriter}</td>
								<td>${vo.cbBoRegDate}</td>
								<td>${vo.cbBoHit}</td>
						
							
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty list}">
					<td colspan="5" style="text-align: center;">글이 없습니다.. 회원이시라면 첫 글을 써보세요!!</td>
				</c:if>
			</table>
			
			<c:if test="${not empty list}">
			<!-- 페이징 -->
			<nav aria-label="Page navigation example" style="margin-bottom: 15px;">
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
			<!-- 페이징끝!! -->
			</c:if>
			




	</div>
	<!-- /.container -->

	<%@include file="/inc/footer.jsp"%>
	
	<script type="text/javascript">
		function logincheck() {
			var memId = document.getElementById("checkLogin").value;

			if (memId == "") {
				swal({
					text : "로그인이 필요합니다",
					icon : "warning",
					confirmButtononText : "확인"
				}).then(function() {
					location.href = "/login/login.lol";
				})
			};

		}

		
		
		
		
		
		$('#chatOpen').on('click',function(){
			var memId = document.getElementById("checkLogin").value;
			var clubNum = $("input[name = chatUserId]").val();
			console.log(clubNum);
			if(memId != ""){
				params = {"cmMemId" : memId ,"cmNum":clubNum}
				$.ajax({
					type:"POST",
					url: '<c:url value="/club/chatCheck.lol"/>',
					dataType: 'json',
					data : params,
					success : function(data) {
						if(!data.result){
							swal({
								title: "채팅 참여 불가",
								text : data.error,
								icon : "error"
							})
						}else{
							window.open("clubChat.lol?bkNum=${club.bkNum}&bkClubName=${club.bkClubName}", "클럽채팅", "width=1000, height=800, toolbar=no, menubar=no, scrollbars=no, resizable=no" );  
						}
						
					}
				});
				
			}else{
				swal({
					text : "로그인이 필요합니다",
					icon : "warning",
					confirmButtononText : "확인"
				}).then(function() {
					location.href = "/login/login.lol";
				})
			}
			
		});
		
		
		
		
		
		
		$("#btn_join").click(function(e) {
			e.preventDefault();
			f = document.forms.formName
			params = $(f).serialize();
			
			console.log(params);

			$.ajax({
				type : "POST",
				url : "<c:url value='/club/clubMemberRegist.lol'/>",
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
							location.href = "clubMain.lol";
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
		
		
		$("#btn_delete").click(function(e) {
			e.preventDefault();
			f = document.forms.formNm
			params = $(f).serialize();
			
			console.log(params);

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
							location.href = "clubMain.lol";
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