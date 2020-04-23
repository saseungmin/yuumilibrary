<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@include file="/inc/common_header.jsp" %>
 <link href="<c:url value='/bootstrap3/css/bootstrap.min.css'/>" rel="stylesheet">   
<title>게시글 상세보기</title>
<style type="text/css">
  	table.grid th {text-align:center;}
</style>
 

</head>

<body>
<%@include file="/inc/top_menu.jsp" %>
<div class="container">
	<div class="page-header">
		<h1>상세보기</h1>
	</div>






<!-- ----------------------------------------------------------------------------- -->
<table class="grid table table-striped table-bordered table-hover">
	<colgroup>
		<col width="20%" />
		<col />
	</colgroup>
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
		<th>내용</th>
		<td class="ck-content"><p>${free.boContent}</p></td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td>
			<c:forEach var="f" items="${free.attaches}" varStatus="st">
				<div>
					# 파일 ${st.count} <a href="<c:url value='/attach/download/${f.ATCH_NO}' />"target="_blank"> 
					<i class="fas fa-file-download"></i> ${f.ATCH_ORIGINAL_NAME} </a> 
					Size : ${f.ATCH_FILE_SIZE} Down : ${f.ATCH_DOWN_CNT}
				</div>
			</c:forEach>
		</td>
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
				<a href="freeList.lol" class="btn btn-sm btn-default">목록</a>
			</div>
			<c:if test="${sessionScope.USER_INFO.userID eq free.boMemId && not empty sessionScope.USER_INFO.userID || sessionScope.USER_INFO.userRole eq '관리자'}">
				<div class="pull-right">
					<a href="freeEdit.lol?boNum=${free.boNum}&boNotice=${free.boNotice}" class="btn btn-sm btn-success">
					정보수정</a>
				</div>
			</c:if>
		</td>
	</tr>
</table>

	<div class="panel panel-default">
			<div class="panel-body form-horizontal">
				<form name="formReply"
					action="<c:url value='/reply/replyRegist.lol'/>" method="post">

					<input type="hidden" name="reMemId"
						value="${sessionScope.USER_INFO.userID}"> <input
						type="hidden" name="reBoardNum" value="${qna.qbNum}"> <input
						type="hidden" name="reCategory" value="QNA">

					<div class="form-group">
						<label class="col-sm-2  control-label">댓글</label>
						<div class="col-sm-8">
							<textarea rows="2" name="reContent" class="form-control"></textarea>
						</div>
						<div class="col-sm-2">
							<button id="btn_reply_regist" type="button"
								class="btn btn-sm btn-info">등록</button>
						</div>
					</div>
				</form>
			</div>
		</div>

		<!-- 댓글목록 -->
		<div id="id_reply_list_area"></div>
	</div>


<%@include file="/inc/footer.jsp" %>
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
					
					str += '<form name="formList' + row.reNum + '" method="post">                          ';
					
					str += '<div class= "row" data-renum=" ' + row.reNum + ' " style="margin-left: ' + row.reDepth*50 + 'px;">';
					str += '	<label class="col-sm-2  control-label text-right">'+ row.reWriter +'</label>';
					
					str += '	<div id="mom' +row.reNum +'" class= "col-sm-6"  onclick="showDeeper(' + row.reNum + ')">  ';
					str += '		<pre id="cont' + row.reNum + '">' + row.reContent +'</pre>                      ';
					str += '	</div>                                                                            ';
					str += '	<div class="col-sm-2">';
					
					if(row.reMemId == '${sessionScope.USER_INFO.userID}'){
						if(row.reDelYn == 'N'){
							str +='<button id="btn_reply_edit"   type="button" class="btn btn-sm btn-info"   onclick="fn_modify(this,'+row.reNum+')" >수정</button>';   
							str +='<button id="btn_reply_delete" type="button" class="btn btn-sm btn-danger" onclick="fn_re_del(this)">삭제</button>';
						}
					}
					// 원래 보이는 화면
					
					// 대댓글을 위해 가려놓은 화면
					
					str += '	</div>';	
					str += '</div>';
					str += '  <input type="hidden" name="reNum" value="' + row.reNum + '">';
					str += '  <input type="hidden" name="reMemId" value="${sessionScope.USER_INFO.userName}">    ';
					str += '  <input type="hidden" name="reContent" value="' + row.reContent + '">    ';
					str += '</form>'
					
					var link = '<c:url value="/reply/replyRegist.lol"/>';
					
					
					str += '<div class="row" id="hiddenForDeeper' + row.reNum + '" style="display: none; margin-left: '+ row.reDepth*50 +'px; margin-bottom: 20px;">       '
					str += '<form name="formReplyDeeper' + row.reNum + '" action="'+ link +'" method="post">    '
					str += '	<input type="hidden" name="reMemId" value="${sessionScope.USER_INFO.userID}">     '     
					str += '	<input type="hidden" name="reWriter" value="${sessionScope.USER_INFO.userName}">  '     
					str += '	<input type="hidden" name="reBoardNum" value="${free.boNum}">                     '
					str += '	<input type="hidden" name="reCategory" value="FREE">                              '               
					str += '	<input type="hidden" name="reGroupNum" value="' + row.reGroupNum + '">            '
					str += '	<input type="hidden" name="reDepth" value="' + row.reDepth + '">                  '
					str += '	<input type="hidden" name="reOrder" value="' + row.reOrder + '">                  '
					
					str += '	<div class="form-group">                                                          '
					str += '		<label class="col-sm-2  control-label text-right">댓글의 댓글</label>                             '
					str += '		<div class="col-sm-8">                                                          '
					
					str += '			<textarea rows="2" name="reContent" class="form-control" style="display: margin-bottom: 100px;" ></textarea>'
					
					str += '		</div>                                                                          '
					str += '		<div class="col-sm-2">                                                          '
					str += '			<button type="button"                                                         '
					str += '				class="btn btn-sm btn-info" onclick=registReplyDeeper(this)>등록</  button>       '
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
		}).then((value) => {
			console.log(value)
// 		  swal(`수정할 내용: ${value}`);
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
		});


}
	
</script>
</body>
</html>
