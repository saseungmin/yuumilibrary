$(document).ready(function(){

	$("#my-file-selector").on("change", function(e){
		fileChange(e);
	});
});



function fileChange(e) {
	e.preventDefault();

 	var pattern = /jpg$|gif$|png$|jpeg$/i;
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	console.log(filesArr);

	
	var file = files[0]
	console.log(file.type);
	


	if(!file.type.match("image.*")) {
		 swal({
		    text: "확장자는 이미지 확장자만 가능합니다.",
		    icon: "error",
		    button: "확인"
		})
		return false;
     
	}

	if(!file.name.match(pattern)){
		 swal({
		    text: "확장자는 jpg,gif,png,jpeg 확장자만 가능합니다.",
		    icon: "error",
		    button: "확인"
		})
		return false;
	}

	var reader = new FileReader();
	reader.onload = function(e) {
		$("#user_image").attr("src", e.target.result);
	}
	reader.readAsDataURL(file);



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
			console.log();
            swal({
				title:"프로필 사진 변경",
                text: "프로필 이미지가 변경 되었습니다.",
                icon: "success",
                button: "닫기"
            }); 
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

}