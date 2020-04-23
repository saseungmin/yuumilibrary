$(document).ready(function() {

    
    var readURL = function(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('.img-thumbnail').attr('src', e.target.result);
            }
    
            reader.readAsDataURL(input.files[0]);
        }
    }
    

    $(".file-upload").on('change', function(e){
		e.preventDefault();
    	var result=fileChange(e);
		if(result){
			readURL(this);
		}else{
			return false;
		}
	});
	



	var memId = document.getElementById("checkLogin").value
	
	if(memId == ""){
		swal({
			text: "로그인이 필요합니다",
			icon: "warning",
			confirmButtononText: "확인"
			}).then(function(){
					window.history.back();
				})
		};



});




function fileChange(e) {
	e.preventDefault();

 	var pattern = /jpg$|gif$|png$|jpeg$/i;
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	console.log(filesArr);

	
	var file = files[0]
	console.log(file);
	


	if(!file.type.match("image.*")) {
		 swal({
		    text: "확장자는 이미지 확장자만 가능합니다.",
		    icon: "error",
		    button: "확인"
		})
		return false;
     
	}else if(!file.name.match(pattern)){
		 swal({
		    text: "확장자는 jpg,gif,png,jpeg 확장자만 가능합니다.",
		    icon: "error",
		    button: "확인"
		})
		return false;
	}else{
		return true;
	}
	
	
	/* else{


	var memId=$("#memId").val();
    var formData = new FormData();

	formData.append("file", file);

		$.ajax({
    	url: '/uploadForm',
		  data: formData,
		  dataType:'text',
		  enctype: 'multipart/form-data',
		  processData: false,
		  contentType: false,
		  type: 'POST',
		  success: function(){
            swal({
				title:"클럽 이미지 변경",
                icon: "success",
                button: "닫기"
            }).then((value) =>{
				return true;
			})
		  },
		  error: function (e) {
			swal({
				title:"변경 실패",
				text: e,
				icon: "error",
				button: "닫기"
            }); 
		  }
		})









		return true;
	} */
}
