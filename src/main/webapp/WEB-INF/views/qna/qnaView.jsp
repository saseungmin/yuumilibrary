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
<link href="<c:url value='/css/btn.css?dummi=12'/>" rel="stylesheet">
<!-- <link href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" rel="stylesheet"> -->
<!-- <link href="http://fonts.googleapis.com/css?family=Roboto:400,700,300" rel="stylesheet" type="text/css"> -->
<title>게시글 상세보기</title>
<style type="text/css">
table.grid th {
	text-align: center;
}
img {
	width: 50px;
	height: 50px;
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
<!-- Fonts and icons -->

</head>

<body>
	<%@include file="/inc/top_menu.jsp"%>
	<div class="container">
		<div class="page-header table-responsive">
		<h1 style="margin-top: 20px">QnA 상세 보기</h1>
<table class="grid table table-striped table-hover table-bordered">
			<colgroup>
				<col width="20%" />
				<col />
			</colgroup>
			<thead class="thead-dark">
			<tr>
				<th>글번호</th>
				<td class="success">${qna.qbNum}</td>
			</tr>
			<tr>
				<th>제목</th>
				<td class="success">${qna.qbTitle}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td class="success">${qna.qbWriter}(${qna.qbMemId})</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td class="success">${qna.qbHit}</td>
			</tr>
			<tr>
				<th style="vertical-align: middle;">내용</th>
				<td class="ck-content success"><div style="min-height: 400px;">${qna.qbContent}</div></td>
			</tr>
			<tr>
				<th>작성일</th>
				<td class="success">${qna.qbRegDate}</td>
			</tr>
			<tr>
				<th>수정일</th>
				<td class="success">${qna.qbModDate}<c:if test="${empty qna.qbModDate}">
						최초작성
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="pull-left">
						<a href="qnaList.lol" class="btn btn-primary btn-xs blue"><i class="fa fa-list"></i>목록</a>
					</div> <c:if test="${sessionScope.USER_INFO.userID eq qna.qbMemId}">
						<div class="pull-right">
							<a href="qnaEdit.lol?qbNum=${qna.qbNum}"
								class="btn btn-primary btn-xs orange"><i class="fa fa-pencil"></i> 정보수정</a>
						</div>
					</c:if>
				</td>
			</tr>
			</thead>
		</table>


		<!-- 댓글쓰기 --> 
		<div class="panel panel-default">	
	<div class="form-horizontal">
	<div class="card mb-2">
	<div class="card-header bg-light"><i class="fa fa-comment fa"></i> REPLY
	</div>
	<div class="card-body">
	<form name="formReply" action="<c:url value='/reply/replyRegist.lol'/>" method="post">
		<input type="hidden" name="reMemId" value="${sessionScope.USER_INFO.userID}">
		<input type="hidden" name="reBoardNum" value="${qna.qbNum}">
		<input type="hidden" name="reCategory" value="QNA">
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
<%-- 				<form name="formReply" action="<c:url value='/reply/replyRegist.lol'/>" method="post"> --%>
<!-- 					<div class="jumbotron"> -->
<!-- 					<input type="hidden" name="reMemId" -->
<%-- 						value="${sessionScope.USER_INFO.userID}"> --%>
<%-- 						<input type="hidden" name="reBoardNum" value="${qna.qbNum}"> --%>
<!-- 						<input type="hidden" name="reCategory" value="QNA"> -->

<!-- 					<div class="form-group"> -->
<!-- 						<label class="col-sm-2  control-label">댓글</label> -->
<!-- 						<div class="col-sm-14"> -->
<!-- 							<textarea rows="2" name="reContent" class="form-control"></textarea> -->
<!-- 						</div> -->
<!-- 						<div class="offset-10 col-sm-2"> -->
<!-- 							<button id="btn_reply_regist" type="button" -->
<!-- 								class="btn btn-primary btn-xs green float-right" -->
<!-- 								style="margin-top: 5px"><i class="fa fa-check"></i>등록</button> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					</div> -->
<!-- 				</form> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->

		<!-- 댓글목록 -->
<!-- 	<div class="card mb-2"> -->
<!-- 		<div class="card-body"> -->
		<div id="id_reply_list_area"></div>

		</div>
	</div>
 <!--container  -->


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
					"reBoardNum" : "${qna.qbNum}",
					"reCategory" : "QNA",
					"reMemId"  : "${sessionScope.USER_INFO.userID}",
					"reWriter" : "${sessionScope.USER_INFO.userName}",
					"reContent": content
				}
				
				if(params.reMemId == null){
					swal({
						icon : "warning",
						text : "로그인이 필요합니다.",
						button : "확인"
					}).then((result) => {
						return false;
					})
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
			"reBoardNum" : '${qna.qbNum}',
			"reCategory" : 'QNA',			
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
// 						str += '<div class="jumbotron">';
						str += '<div class="card mb-2">';
						str += '<form name="formList' + row.reNum + '" >'
						str += '<div class= "row" data-renum=" ' + row.reNum + ' " style="margin-left: ' + row.reDepth*50 + 'px;">';
						str += '<div class="col-sm-1">';
						str += '<div class="thumbnail">';
						str += '<img class="img-responsive user-photo" alt="'+ row.reImg +'" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">';
						str += '</div>';	<!-- /thumbnail -->		
						str += '</div>';
						str += '	<div class="col-sm-10">';
						str += ' <div class="panel panel-default">';
						str += ' <div class="card-header bg-light"  style="color:black; font-weight:bold">';
						str += '<strong>'+ row.reWriter +'</strong> <span class="text-muted">' + row.reRegDate+'</span>';
						str += '</div>';
						str += '<div id="mom' +row.reNum +'"  class="panel-body"  onclick="showDeeper(' + row.reNum + ')"><pre id="cont' + row.reNum + '">' + row.reContent +'</pre> </div>'; <!-- /panel-body -->
						
						if(row.reMemId == '${sessionScope.USER_INFO.userID}'){
							if(row.reDelYn == 'N'){
								str += '<div style="margin-left: 10px; margin-bottom: 10px;">';
								str +='<button id="btn_reply_edit"   type="button" class="btn btn-primary btn-xs orange pull-right"   onclick="fn_modify(this,'+row.reNum+')" style="margin-left:10px;" ><i class="fa fa-pencil"></i>수정</button>';   
								str +='<button id="btn_reply_delete" type="button" class="btn btn-primary btn-xs red pull-right" onclick="fn_re_del(this)"><i class="fa fa-times"></i>삭제</button>';
								str += '</div>';
							}
						}
						// 원래 보이는 화면
						// 대댓글을 위해 가려놓은 화면
						str += '  <input type="hidden" name="reNum" value="'+row.reNum+'">';
						str += '  <input type="hidden" name="reContent" value="'+row.reContent+'">    ';
						str += '  <input type="hidden" name="reMemId" value="${sessionScope.USER_INFO.userName}">    ';
						str += '	</div>';
						str += '	</div>';
						str += '	</div>';	
						str += '</div>';	
						str += '</form>';
						str += '</div>'; 	/*jumbo  */
						
						var link = '<c:url value="/reply/replyRegist.lol"/>';
						
						
						str += '<div class="row" id="hiddenForDeeper' + row.reNum + '" style="display: none; margin-left: '+ row.reDepth*50 +'px; margin-bottom: 20px;">       '
						str += '<form name="formReplyDeeper' + row.reNum + '" action="'+ link +'" method="post">      '
						str += '	<input type="hidden" name="reMemId" value="${sessionScope.USER_INFO.userID}">     '     
						str += '	<input type="hidden" name="reWriter" value="${sessionScope.USER_INFO.userName}">  '     
						str += '	<input type="hidden" name="reBoardNum" value="${qna.qbNum}">                      '
						str += '	<input type="hidden" name="reCategory" value="QNA">                               '
						str += '	<input type="hidden" name="reGroupNum" value="' + row.reGroupNum + '">            '
						str += '	<input type="hidden" name="reDepth" value="' + row.reDepth + '">                  '
						str += '	<input type="hidden" name="reOrder" value="' + row.reOrder + '">                  '
						
						str += '	<div class="form-group">                                                          '
						str += '		<label class="col-sm-2  control-label text-right">위 글에 대한 답글</label>                    '
						str += '		<div class="col-sm-8">                                                        '
						str += '			<textarea rows="2" name="reContent" class="form-control" style="display: margin-bottom: 100px;" ></textarea>      '
						str += '		</div>                                                                        '
						str += '		<div class="col-sm-2">                                                        '
						str += '			<button type="button"                               '
						str += '				class="btn btn-primary btn-xs green" style="margin-top: 5px" onclick=registReplyDeeper(this)><i class="fa fa-check"></i>등록</button>'
						str += '		</div>                                                                        '
						str += '	</div>                                                                            '
						str += '</form>                                                                               '
						
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
					swal({
						icon : "warning",
						text : "댓글 등록 실패\n관리자에게 문의하세요",
						button : "확인"
					}).then((result) => {
						history.go(0)
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
		swal("수정할 내용을 입력하세요", {
			  content: "input",
			  closeOnClickOutside: false,  /*팝업 창 외부를 클릭하면 SweetAlert가 닫히지 않도록 방지  */
			  closeOnEsc: false
			}).then((value) => {
			  	if(value=="" || value =='null'){
					swal({
						icon : "info",
						text : "내용을 입력하세요",
						button : "닫기"
					}).then((result) => {
						return false
					});
			  	} else{
			  params = {
						"reBoardNum" : '${qna.qbNum}',
						"reCategory" : 'QNA',	
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
