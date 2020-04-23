<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%@include file="/inc/common_header.jsp"%>
<link href="<c:url value='/css/freeList.css'/>" rel="stylesheet">
<link href="<c:url value='/css/btn.css'/>" rel="stylesheet">


<title>게시글 상세보기</title>
<style type="text/css">
table.grid th {
	text-align: center;
}

.myfreeChat {
	position: fixed;
	right: 20px;
	bottom: 150px;
	z-index: 1;
}

img {
	width: 50px;
	height: 50px;
}

.popup-messages .session-img {
	border: 1px solid #fff;
	border-radius: 50%;
	float: left;
	height: 30px;
	margin: -10px 0 0;
	width: 30px;
}

.notice {
	color: #dc3545;
}

.jumbotron {
	border-radius: 0rem;
	border: 1px solid darkgrey;
	margin-top: 15px;
	padding: 2rem 1rem;
}
.text-muted{
	color: white;
}
</style>


</head>

<body>
	<%@include file="/inc/top_menu.jsp"%>
	<div class="container">
		<div class="page-header table-responsive">
			<h1 style="margin-top: 20px">상세보기</h1>

		<table class="grid table table-striped">
			<colgroup>
				<col width="20%" />
				<col />
			</colgroup>
			<thead class="thead-dark">
				<tr>
					<th>글번호</th>
					<td>${free.boNum}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${free.boTitle}</td>
				</tr>

				<tr>
					<th>작성자</th>
					<td>${free.boMemId}</td>
				</tr>
				<tr>
					<th>분류</th>
					<td>${free.boCategoryNm}</td>
				</tr>
				<tr>
					<th>조회수</th>
					<td>${free.boHit}</td>
				</tr>
				<tr>
					<th style="vertical-align: middle;">내용</th>
					<td class="ck-content"><div style="min-height: 400px;"><p>${free.boContent}</p></div></td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td><c:forEach var="f" items="${free.attaches}" varStatus="st">
							<div>
								# 파일 ${st.count} <a
									href="<c:url value='/attach/download/${f.ATCH_NO}' />"
									target="_blank"> <i class="fas fa-file-download"></i>
									${f.ATCH_ORIGINAL_NAME}
								</a> Size : ${f.ATCH_FILE_SIZE} Down : ${f.ATCH_DOWN_CNT}
							</div>
						</c:forEach></td>
				</tr>
				<tr>
					<th>작성일</th>
					<td>${free.boRegDate}</td>
				</tr>
				<tr>
					<th>수정일</th>
					<td>${free.boModDate}</td>
				</tr>
			<tr>
				<td colspan="2">
					<div class="pull-left">
						<a href="freeList.lol" class="btn btn-primary btn-xs blue"><i class="fa fa-list"></i>목록</a>
					</div> <c:if
						test="${sessionScope.USER_INFO.userID eq free.boMemId && not empty sessionScope.USER_INFO.userID || sessionScope.USER_INFO.userRole eq '관리자'}">
						<div class="pull-right">
							<a
								href="freeEdit.lol?boNum=${free.boNum}&boNotice=${free.boNotice}"
								class="btn btn-primary btn-xs orange"><i class="fa fa-pencil"></i>정보수정</a>
						</div>
					</c:if>
				</td>
			</tr>
			</thead>
		</table>

<div class="panel panel-default">	
	<div class="form-horizontal">
	<div class="card mb-2">
	<div class="card-header bg-light"><i class="fa fa-comment fa"></i> REPLY
	</div>
	<div class="card-body">
	<form name="formReply" action="<c:url value='/reply/replyRegist.lol'/>" method="post">
		<input type="hidden" name="reMemId" value="${sessionScope.USER_INFO.userID}">
		<input type="hidden" name="reBoardNum" value="${free.boNum}">
		<input type="hidden" name="reCategory" value="FREE">
			<ul class="list-group list-group-flush">
		    <li class="list-group-item">
			<textarea class="form-control" name="reContent" rows="3"></textarea>
			<button id="btn_reply_regist" type="button" class="btn btn-xs float-right dark" style="margin-top: 10px"><i class="fa fa-check" aria-hidden="true"></i>등록</button>
		    </li>
		</ul>
   </form>
	</div>
</div>
</div>
</div>

<br><br><br><br><br><br><br><br><br><br><br><br>




<!-- 		<div class="panel panel-default"> -->
<!-- 			<div class="form-horizontal"> -->
<!-- 				<form name="formReply" -->
<%-- 					action="<c:url value='/reply/replyRegist.lol'/>" method="post"> --%>
<!-- 					<div class="jumbotron"> -->
<!-- 						<input type="hidden" name="reMemId" -->
<%-- 							value="${sessionScope.USER_INFO.userID}"> <input --%>
<%-- 							type="hidden" name="reBoardNum" value="${free.boNum}"> <input --%>
<!-- 							type="hidden" name="reCategory" value="FREE"> -->

<!-- 						<div class="form-group"> -->
<!-- 							<label class="col-sm-2  control-label">댓글</label> -->
<!-- 							<div class="col-sm-14"> -->
<!-- 								<textarea rows="2" name="reContent" class="form-control"></textarea> -->
<!-- 							</div> -->
<!-- 							<div class="offset-10 col-sm-2"> -->
<!-- 								<button id="btn_reply_regist" type="button" -->
<!-- 									class="btn btn-primary btn-xs green float-right" -->
<!-- 									style="margin-top: 5px"><i class="fa fa-check"></i>등록</button> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</form> -->
<!-- 			</div> -->
<!-- 		</div> -->

<!-- Modal -->
<div class="modal fade" id="ModifyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle">댓글 수정</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<form>
      	<input type="text" class="form-control" id="recipient" value="">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">아이디:</label>
            <input type="text" class="form-control" id="recipient-name">
          </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label">댓글 내용:</label>
            <textarea class="form-control" id="message-text"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">수정</button>
      </div>
      
    </div>
  </div>
</div>





		<!-- 댓글목록 -->
		<div id="id_reply_list_area"></div>

	</div>
</div>
	
	<!--container-->
	

	<%@include file="/inc/footer.jsp"%>
	<script src="<c:url value='/js/top_menu.js'/>"></script>
	<script type="text/javascript">
$(document).ready(function() {
	getReplyList();
	
	$('#btn_reply_regist').on("click", function() {
		var content = $('textarea[name=reContent]').val();
		
		if(content == ''){
			swal({
				icon: "warning",
				text: "내용을 입력하지 않았습니다.",
				button: "확인"					
			}).then((result) => {
				$('textarea[name=reContent]').focus();
			})
		} else {
			
			params = {
				"reBoardNum" : "${free.boNum}",
				"reCategory" : "FREE",
				"reMemId"  : "${sessionScope.USER_INFO.userID}",
				"reWriter" : "${sessionScope.USER_INFO.userName}",
				"reContent": content
			}
			
			$.ajax({
				type : 'POST',
				url  : "<c:url value='/reply/replyRegist.lol'/>",
				dataType : 'JSON',
				data : params,
				success : function(data) {
					console.log(data);
					if(data.result){
						swal({
							icon : "success",
							text : "댓글 등록 완료!",
							button : "확인"
						}).then((result) => {
							$('textarea[name=reContent]').val("");
							history.go(0);	
						})
						
					} else {
						swal({
							icon : "warning",
							text : "댓글 등록 실패!!\n관리자에게 문의하세요",
							button : "확인"
						})
					}
				}
	 			,error : function(req, st, err) {
					console.log("req",req); 				
					if(req.status == 401){
						alert("찾을 수 없습니다.");

					} else{
						swal({
			        icon: "warning",
							text : "로그인 후 이용해주세요.",
			        button: "닫기"
			     		}).then(function(){
							location.href = "<c:url value='/login/login.lol'/>"
			            	 })	
					}
				} 
				
			});
		}
	})
}) // document ready

function getReplyList() {
	var area = $('#id_reply_list_area')

	params = {
		"reBoardNum" : '${free.boNum}',
		"reCategory" : 'FREE',					
	}
	
	$.ajax({
		type : 'POST',
		url : '<c:url value="/reply/replyList.lol"/>',
		dataType : 'JSON',
		data : params,
		success : function(data) {
			if(data.result){
				$.each(data.list, function(i, row) {
					str = '';
// 					str += '<div class="jumbotron">';
					str += '<div class="card mb-2">';
					str += '<form name="formList' + row.reNum + '" method="post">                          ';
					str += '<div class= "row" data-renum=" ' + row.reNum + ' " style="margin-left: ' + row.reDepth*50 + 'px;">';
					str += '<div class="col-sm-1">';
					str += '<div class="thumbnail">';
					str += '<img class="img-responsive user-photo" alt="'+ row.reImg +'" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">';
					str += '</div>';	<!-- /thumbnail -->		
					str += '</div>';
					str += '	<div class="col-sm-10">';
					str += ' <div class="panel panel-default">';
					str += ' <div class="card-header bg-light" style="color:black; font-weight:bold"> ';
					str += '<strong>'+ row.reWriter +'</strong> <span class="text-muted">' + row.reRegDate+'</span>';
					str += '</div>';
					str += '<div id="mom' +row.reNum +'"  class="panel-body"  onclick="showDeeper(' + row.reNum + ')"><pre id="cont' + row.reNum + '">' + row.reContent +'</pre> </div>'; <!-- /panel-body -->
					if(row.reMemId == '${sessionScope.USER_INFO.userID}'){
						if(row.reDelYn == 'N'){
							str += '<div style="margin-left: 10px; margin-bottom: 10px; margin-top: 30px;">';
							str +='<button id="btn_reply_edit"   type="button" class="btn btn-primary btn-xs orange float-right"  onclick="fn_modify(this,'+row.reNum+')" style="margin-left:10px;" ><i class="fa fa-pencil"></i>수정</button>';   
							str +='<button id="btn_reply_delete" type="button" class="btn btn-primary btn-xs red float-right" onclick="fn_re_del(this)"><i class="fa fa-times"></i>삭제</button>';
							str += '</div>';
						}
					}
					// 원래 보이는 화면
					//onclick="fn_modify(this,'+row.reNum+')"
					// 대댓글을 위해 가려놓은 화면
					
					str += '  <input type="hidden" name="reNum" value="' + row.reNum + '">';
					str += '  <input type="hidden" name="reMemId" value="${sessionScope.USER_INFO.userName}">    ';
					str += '  <input type="hidden" name="reContent" value="' + row.reContent + '">    ';
					str += '	</div>';<!-- /panel panel-default -->
					str += '	</div>';<!-- /col-sm-5 -->
					str += '	</div>';	
					str += '</div>';
					str += '</form>'
					str += '</div>';	/*jumbo  */		
					
					var link = '<c:url value="/reply/replyRegist.lol"/>';
					
					
					str += '<div class="row" id="hiddenForDeeper' + row.reNum + '" style="display: none; margin-left: '+ row.reDepth*50 +'px; margin-bottom: 20px; border: 1px solid gray;">       '
					str += '<form name="formReplyDeeper' + row.reNum + '" action="'+ link +'" method="post">    '
					str += '	<input type="hidden" name="reMemId" value="${sessionScope.USER_INFO.userID}">     '     
					str += '	<input type="hidden" name="reWriter" value="${sessionScope.USER_INFO.userName}">  '     
					str += '	<input type="hidden" name="reBoardNum" value="${free.boNum}">                     '
					str += '	<input type="hidden" name="reCategory" value="FREE">                              '               
					str += '	<input type="hidden" name="reGroupNum" value="' + row.reGroupNum + '">            '
					str += '	<input type="hidden" name="reDepth" value="' + row.reDepth + '">                  '
					str += '	<input type="hidden" name="reOrder" value="' + row.reOrder + '">                  '
					str += '	<div class="form-group">                                                          '
					str += '		<label class="col-sm-2  control-label">위 글에 대한 답글</label>                             '
					str += '		<div class="col-sm-8">                                                          '
					str += '			<textarea rows="2" name="reContent" class="form-control" style="display: margin-bottom: 100px;" ></textarea>'
					str += '		</div>                                                                          '
					str += '		<div class="col-sm-2">                                                          '
					str += '			<button type="button"                                                         '
					str += '				class="btn btn-primary btn-xs green" style="margin-top: 5px" onclick=registReplyDeeper(this)><i class="fa fa-check"></i>등록</  button>       '
					str += '		</div>                                                                          '
					str += '	</div>                                                                            '

					str += '</form> 																																						'                                          

				
					area.append(str);
				})
			}
		}
	})
}




function registReplyDeeper(b) {
	f = b.form;
		params = $(f).serialize()
		
		$.ajax({
			type : 'POST',
		url : '<c:url value="/reply/replyRegist.lol"/>',
		dataType : 'JSON',
		data : params,
		success : function(data) {
			console.log(data)
			if(data.result){
				swal({
					icon : "success",
					text : "댓글 등록 성공",
					button : "확인"
				}).then((result) => {
					history.go(0)
				})
			} else {
				alert("??")
			}
		}
			,error : function(req, st, err) {
				console.log("req",req); 				
				if(req.status == 401){
					alert("찾을 수 없습니다.");

				} else{
					swal({
		        icon: "warning",
						text : "로그인 후 이용해주세요.",
		        button: "닫기"
		     		}).then(function(){
						location.href = "<c:url value='/login/login.lol'/>"
		            	 })	
				}
			} 
		})
}


function showDeeper(num) {
	if($('#hiddenForDeeper'+ num).css('display') != 'none'){
		$('#hiddenForDeeper'+ num).css('display','none');	
	} else {
		$('#hiddenForDeeper'+ num).css('display','block');
	}
}

function fn_re_del(b) {
	f = b.form;
	params = $(f).serialize();
	console.log(params);
 	$.ajax({
		type : 'POST',
		url  : '<c:url value="/reply/replyDelete.lol"/>',
		dataType : 'JSON',
		data     : params,
		success  : function(data) {
			console.log(data)
			if(data.result){
				swal({
					icon : "success",
					text : "댓글 삭제 성공",
					button : "확인"
				}).then((result) => {
			  	history.go(0)
				})
			} else {
				swal({
					icon : "warning",
					text : "댓글 삭제 실패\n관리자에게 문의하세요",
					button : "확인"
				}).then((result) => {
					history.go(0)
				})
			}
		}
	}) //ajax  
}

function fn_modify(b, num) {
// 	f = b.form;
// 	g = $('#cont'+num);
// 	console.log(g);

	swal("수정할 내용을 입력하세요", {
		  content: "input",
		  closeOnClickOutside: false
		}).then((value) => {
			console.log(value)
// 		  swal(`수정할 내용: ${value}`);
			if(value == '' || value == 'null'){
				swal({
					icon : "info",
					text : "댓글을 입력해주세요",
					button : "닫기"
				}).then((result) => {
					return false;
				})
			}else{
		  params = {
					"reBoardNum" : '${free.boNum}',
					"reCategory" : 'FREE',	
					"reNum" :  num,
					"reContent" : value,
					}
		  console.log('params=',params);
				$.ajax({
					type : 'POST',
				url : '<c:url value="/reply/replyModify.lol"/>',
				dataType : 'JSON',
				data : params,
				success : function(data) {
					console.log('data=',data)
					if(data.result){
						swal({
							icon : "success",
							text : "댓글 수정 성공",
							button : "확인"
						}).then((result) => {
							history.go(0)
						})
					} else {
						swal({
							icon : "warning",
							text : "댓글 수정 실패\n관리자에게 문의하세요",
							button : "확인"
						}).then((result) => {
							history.go(0)
						})
					}
				}
			})
			}
		});


}
	
</script>
</body>
</html>
