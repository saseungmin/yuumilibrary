$(document).ready(function(){
	
	
    $("#memMailYn").change(function(){
    	if($("#memMailYn").is(":checked")){
    		$("#memMailYn").val("Y");
	    }else{
	    	$("#memMailYn").val("N");
	    }
    })
        $("#memHpYn").change(function(){
    	if($("#memHpYn").is(":checked")){
    		$("#memHpYn").val("Y");
	    }else{
	    	$("#memHpYn").val("N");
	    }
    }) 
    
/*    if($('input:checkbox[id="memMailYn"]').prop("checked")==true){
   	$('input:checkbox[id="memMailYn"]').val("Y");

   }else if($('input:checkbox[id="memMailYn"]').prop("checked")==false){
   	$('input:checkbox[id="memMailYn"]').val("N");
   }
   
   if($('input:checkbox[id="memHpYn"]').prop("checked")){
   	$('input:checkbox[id="memHpYn"]').val("Y");

   }else if($('input:checkbox[id="memHpYn"]').prop("checked")==false){
   	$('input:checkbox[id="memHpYn"]').val("N");
   } */
    
    //8자 이하
    var bad = /(?=.{8,}).*/;
    //숫자와 영어8자이상
    var good = /^(?=\S*?[a-z])(?=\S*?[0-9])\S{8,}$/;
    //적어도 하나의 대문자, 소문자 및 (숫자 또는 특수 문자)를 포함.
    var better = /^(?=\S*?[A-Z])(?=\S*?[a-z])((?=\S*?[0-9])|(?=\S*?[^\w\*]))\S{8,}$/;
    // 적어도 하나의 대문자, 소문자 및 (숫자와 하나의 특수 문자)를 포함.
    var best = /^(?=\S*?[A-Z])(?=\S*?[a-z])(?=\S*?[0-9])(?=\S*?[^\w\*])\S{8,}$/;
    
    $('#memPass').on('keyup', function () {
        var password = $(this);
        var pass = password.val();
        var passLabel = $('[for="memPass1"]');
        var stength = 'Weak';
        var pclass = 'danger';
        if (best.test(pass) == true) {
            stength = '매우 안전';
            pclass = 'success';
        } else if (better.test(pass) == true) {
            stength = '안전';
            pclass = 'warning';
        } else if (good.test(pass) == true) {
            stength = '보통';
            pclass = 'warning';
        } else if (bad.test(pass) == true) {
            stength = '약함';
        } else {
            stength = '매우 약함';
        }
    
        var popover = password.attr('data-content', stength).data('bs.popover');
        popover.setContent();
        popover.$tip.addClass(popover.options.placement).removeClass('danger success info warning primary').addClass(pclass);
    
    });
    
    $('input[data-toggle="popover"]').popover({
        placement: 'top',
        trigger: 'focus'
    });
    

    $('#idcheck').on('click', function () {
        var memId = $('#memId').val();
        if(memId==""){
		            swal({
		                text: "아이디를 입력해주세요.",
		                icon: "warning",
		                button: "확인"
		            });                   
            return false;
        }else{

            $.ajax({
                type:"POST",
                url: '/member/memberIdCheck.lol',
                dataType:'json',
                data: {'memId':memId},
                success : function(data) {
                    console.log(data);
                    if(!data.result){
                        swal({
                            text: "이미 가입된 아이디가 존재합니다.",
                            icon: "warning",
                            button: "확인"
                        });        
                    }else if(data.result){
                        swal({
                            text: "사용가능한 아이디 입니다.",
                            icon: "success",
                            button: "확인"
                        }); 
                    }
                
                }
            })

        }

    });



});


    function getAddr() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    var extraAddr1=extraAddr;
                
                } else {
                    document.getElementById("userAddress1").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('userAddress').value = data.zonecode;
                document.getElementById("userAddress1").value = addr+extraAddr1;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("userAddress2").focus();
            }
        }).open();
    }







    

   function signup(){
       
        var memRank=document.getElementById("memRank");
    	var userID=document.getElementById("memId");
    	var userPassword1=document.getElementById("memPass");
    	var userPassword2=document.getElementById("memPass2");
    	var userName=document.getElementById("memName");
    	var userBirthdate=document.getElementById("memBir");
    	var userEmail=document.getElementById("memMail");
        var userNumber=document.getElementById("memHp");
        var memPref=document.getElementById("memPref");
    	var termAgree=document.getElementsByName("termagree");
    	var userAddress=document.getElementById("userAddress2");
    	
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
        }else if(memRank.value==""){
            swal({
                text: "회원 타입을 정해주세요.",
                icon: "warning",
                button: "닫기"
            });        
            return false;
        }else if(memPref.value==""){
            swal({
                text: "도서 선호 장르를 선택해주세요.",
                icon: "warning",
                button: "닫기"
            });        
            return false;
        }else if(userPassword2.value==""){
            swal({
                text: "비밀번호 확인란을 입력하세요.",
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
        }else if(userAddress.value==""){
            swal({
                text: "주소를 입력하세요.",
                icon: "warning",
                button: "닫기"
            });                   
            return false;
        }else if(!termAgree[0].checked){
            swal({
                text: "약관에 동의하세요.",
                icon: "warning",
                button: "닫기"
            });                    
            return false;
        }

        if(userPassword1.value.length<8){
            swal({
                text: "비밀번호를 8자리 이상 입력하세요.",
                icon: "error",
                button: "닫기"
            });                    
            return false;
        }
        if(userPassword1.value!=userPassword2.value){
            swal({
                text: "비밀번호가 서로 다릅니다.",
                icon: "error",
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