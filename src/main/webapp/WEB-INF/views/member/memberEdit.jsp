<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@include file="/inc/common_header.jsp" %>
<title>회원정보 수정</title>
</head>
<body>
<%@include file="/inc/top_menu.jsp" %>
<div class="container">
	<div class="row">
		<div class="col-md-2 ">
		</div>
		<div class="col-md-9">
		    <div class="card" style="margin-top: 50px; margin-bottom: 50px;">
		        <div class="card-body">
		            <div class="row">
		                <div class="col-md-12">
		                    <h4>회원 정보수정</h4>
		                    <hr>
		                </div>
		            </div>
		            <div class="row">
		                <div class="col-md-12" style="margin-left: 10px;">
		                    <form name="formName" action="<c:url value='/member/memberModify.lol'/>" method="post" onsubmit="return signup();">
		                    <input type="hidden" name="memId" value="${mem.memId}">
                              <div class="form-group row">
                                <label for="memId" class="col-4 col-form-label">ID</label> 	
                                <div class="col-8">
                                 <label class="form-label" id="memId" style="margin-top: .5rem;">${mem.memId}</label>
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="memName" class="col-4 col-form-label">회원명</label> 
                                <div class="col-8">
                                  <input type="text" name="memName" id="memName" value="${mem.memName}" placeholder="회원명 입력" class="form-control here">
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="memRank" class="col-4 col-form-label">등급</label> 
                                <div class="col-8">
                                	<label class="form-label" id="memRank" style="margin-top: .5rem;">${mem.memRank}</label>
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="memPass" class="col-4 col-form-label">패스워드</label> 
                                <div class="col-4">
                                  <input type="password" name="memPass" id="memPass" value="" class="form-control here" required="required"><span style="color: #e64c4c"> 현재 사용중인 비밀번호</span>
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="select" class="col-4 col-form-label">선호 도서</label> 
                                <div class="col-8">
									<select id="select" name="memPref" class="custom-select">
										<option value="">선호 도서를 선택하세요</option>
										<c:forEach items="${pref}" var="vo">
											<c:if test="${vo.commNm eq mem.memPrefNm }">
												<option value="${vo.commCd}" selected="selected">${vo.commNm}</option>

											</c:if>
											<c:if test="${vo.commNm ne mem.memPref}">
												<option value="${vo.commCd}">${vo.commNm}</option>
											</c:if>
										</c:forEach>
									</select> 
                                </div>
                              </div>	
                              <div class="form-group row">
                                <label for="memBir" class="col-4 col-form-label">생일</label> 
                                <div class="col-8">
                                  <input id="memBir" name="memBir" value="${mem.memBir}" class="form-control" required="required" placeholder="생일입력" type="date">
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="memZip" class="col-4 col-form-label">우편번호</label> 
                                <div class="col-2">
                                  <input id="userAddress" name="memZip" placeholder="우편번호입력" class="form-control here" type="text" value="${mem.memZip}">
                                </div>
                                <div>
                                  <input id="postbox" type="button" class="btn btn-secondary" onclick="getAddr()" value="우편번호 찾기">
                                  </div>
                              </div>
                              <div class="form-group row">
                                <label for="publicinfo" class="col-4 col-form-label">주소</label> 
                                <div class="col-4">
                                 	<input type="text"  id="userAddress1" name="memAdd1" class="form-control here" value="${mem.memAdd1}" placeholder="기본주소">
                                </div>
                                <div class="col-4">
					   				<input type="text" id="userAddress2" name="memAdd2" class="form-control here" value="${mem.memAdd2}" placeholder="나머지 주소">
                              	</div>
                              </div>
                               <div class="form-group row">
                                <label for="memMail" class="col-4 col-form-label">메일</label> 
                                <div class="col-8">
									<input type="text" name="memMail" value="${mem.memMail}" class="form-control here" required="required">                              
                                </div>
                              </div> 
                              <div class="form-group row">
                                <label for="memHp" class="col-4 col-form-label">전화번호</label> 
                                <div class="col-8">
									<input type="text" name="memHp" value="${mem.memHp}" class="form-control here" required="required">                              
                                </div>
                              </div> 
                              <div class="form-group row">
	                              	<div class="col-4">
		                              	<c:if test="${sessionScope.USER_INFO.userRole.equals('관리자')}">
		                              		<a href="memberList.lol" class="btn btn-sm btn-primary pull-left"><i class="fas fa-list-ul"></i>&nbsp;회원 목록</a>
		                              	</c:if>
	                              	</div>
	                                <div class="col-8">
										<button type="button" id="id_del_btn" class="btn btn-sm btn-danger pull-right" style="margin-left: 10px;" onclick="javascript: formName.action='memberDelete.lol'"><i class="far fa-trash-alt"></i>&nbsp;회원탈퇴</button>
										<button type="button" id="id_mod_btn" class="btn btn-sm btn-success pull-right" onclick="javascript: formName.action='memberModify.lol'"><i class="fas fa-user-edit"></i>&nbsp;정보수정</button>
	                                </div>
								</div>
                            </form>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	</div>
</div>


<%@include file="/inc/footer.jsp" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="<c:url value='/js/top_menu.js'/>"></script>
			<c:choose>
				<c:when test="${!message.result and message.error eq 'diff'}">
					<script type="text/javascript">
						swal({
			                 text: "회원 본인이 아닙니다.",
			                 icon: "error",
			                 button: "닫기"
			             });
					</script>
				</c:when>
			</c:choose>
<script type="text/javascript">


function signup(){
    
	var userID=document.getElementById("memId");
	var userPassword1=document.getElementById("memPass");
	var userName=document.getElementById("memName");
	var userBirthdate=document.getElementById("memBir");
	var userEmail=document.getElementById("memMail");
    var userNumber=document.getElementById("memHp");
    /* var memPref=document.getElementById("memPref");	 */
	
    if(userID.value==""){
        swal({
            text: "아이디를 입력하세요.",
            icon: "warning",
            button: "닫기"
        });        
        return false;
    }else if(userPassword1.value==""){
        swal({
            text: "비밀번호를 입력하세요.",
            icon: "warning",
            button: "닫기"
        });        
        return false;
    }else if(userName.value==""){
        swal({
            text: "이름을 입력하세요.",
            icon: "warning",
            button: "닫기"
        });        
        return false;
    }else if(userBirthdate.value==""){
        swal({
            text: "생년월일을 입력하세요.",
            icon: "warning",
            button: "닫기"
        });        
        return false;
    }else if(userEmail.value==""){
        swal({
            text: "이메일을 입력하세요.",
            icon: "warning",
            button: "닫기"
        });        
        return false;
  
    }else if(userNumber.value==""){
        swal({
            text: "휴대번호를 입력하세요.",
            icon: "warning",
            button: "닫기"
        });                   
        return false;
    }



    if(userNumber.value.indexOf('-')>0){
        swal({
            text: "전화번호란에 - 를 빼고 입력하세요.",
            icon: "error",
            button: "닫기"
        });           
        return false;
    }
    if(isNaN(userNumber.value)){
        swal({
            text: "전화번호를 숫자로 입력하세요.",
            icon: "error",
            button: "닫기"
        });              
        return false;
    }

	
}

$("#id_del_btn").click(function(e) {
	e.preventDefault();
	f = document.forms.formName
	params = $(f).serialize();
	
	console.log(params);
	
	$.ajax({
		 type : "POST"
		,url : "<c:url value='/member/memberDelete.lol'/>"
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
	            	 location.href = "/";
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

$("#id_mod_btn").click(function(e) {
	e.preventDefault();
	f = document.forms.formName
	params = $(f).serialize();
	
	console.log(params);
	
	$.ajax({
		 type : "POST"
		,url : "<c:url value='/member/memberModify.lol'/>"
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
	            	 location.href = "memberView.lol?memId="+data.user;
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


</script>

</body>
</html>


