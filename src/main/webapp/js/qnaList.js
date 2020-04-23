$(document).ready(function(){

	$('.qnaClick').on("click",function(){
		var writer = $(this).parent().data("target");
		var sessionId =$('#sessionId').val();
		var sessionRole =$('#sessionRole').val();
		var qnaNum=$(this).parent().parent().data("target");

		
		if(sessionRole == "관리자"){
			params={"qbMemId":writer}
			$.ajax({
				type:"POST",
				url: 'qnaCheck.lol',
				dataType: 'json',
				data : params,
				success : function(data) {
					console.log(data);
					if(data.result){
						location.href = "qnaView.lol?qbNum="+qnaNum;
					}else{
						swal({
							text: data.message,
							icon: "error",
							button: "확인"
						});  
						return false;
					}
				}
			})
		} else {

			
			if(sessionId == writer){

				
				swal({
					closeOnClickOutside: false,
					content: {
						element: "input",
						attributes: {
							placeholder: "비밀번호를 입력하세요.",
							type: "password",
							},
					},
				}).then((value) => {
					console.log(value);
					if(value==""){
						
						swal({
							text: "비밀번호를 입력하세요.",
							icon: "error",
							button: "확인",
							closeOnClickOutside: false
						});  
						return false;
						
						
					}else{
						
						params={"qbPass":value
								,"qbMemId":writer}
						$.ajax({
							type:"POST",
							url: 'qnaCheck.lol',
							dataType: 'json',
							data : params,
							success : function(data) {
								console.log(data);
								if(data.result){
									location.href = "qnaView.lol?qbNum="+qnaNum;
								}else{
									swal({
										text: data.message,
										icon: "error",
										button: "확인"
									});  
									return false;

								}
				
							}
						})
						
					}
				});
			}else{
				
				swal({
					text: "작성자가 아닙니다.",
					icon: "error",
					button: "확인",
					closeOnClickOutside: false
				});  
				return false;
				
			} 
			
		}
		
		
		

		
	})
	
})
