

$(document).ready(function(){

    $("#id_btn_write").click(function() {
		
	});
	
    initClickEvent();
});


$("#status_message").keydown(function(e){
	if (e.keyCode == 13 && !e.shiftKey){
			e.preventDefault();
			send();
			return false;
		}
	});

function initClickEvent(){

	$("#addClass").click(function (e) {
		e.preventDefault();

		var ids = $("#chatUserId").val()
		if(ids==""){
			swal({
			title: "로그인 후 이용하세요.",
			icon: "error",
			});
			return false;
		}else{
			$('#qnimate').addClass('popup-box-on');
			connect();
			offClickEvent();
		}

	});

}

function offClickEvent(){
	$("#addClass").off('click');

}



	$("#removeClass").click(function (e) {
		e.preventDefault();
		$('#qnimate').removeClass('popup-box-on');
		disconnect();
		$('#mainMessage').empty();
		initClickEvent();
	});



	$('#chatButton').click(function() {
		send();
	});


 function connect() {
	    sock = new SockJS('/chat');
	    sock.onopen = function() {
				$area=$('#mainMessage');
				str ='';
				str +='<div class="chat-box-single-line">';
				str +='		<abbr class="timestamp">'+getTimeStamp()+'</abbr>';
				str +='</div>'
				$area.append(str);	

	      console.log('open');
	    };
	    sock.onmessage = function(evt) {
    	 	var data = evt.data;
			 var obj = JSON.parse(data)  	   
			appendMessage(obj);
	    };
	    sock.onclose = function() {
			console.log("close");
	    };
	}

 function appendMessage(msg) {
	console.log(msg);
	if(msg == ''){
		return false;
	}else{
		var nowuser=$("#chatUserId").val();
		var newDate = new Date();
		var timestamp=newDate.getHours()+"시 "+("0"+newDate.getMinutes()).slice(-2)+"분";

		if(msg.clubUserId==nowuser){

			$area=$('#mainMessage');
			str ='';
			str +='<div class="direct-chat-msg doted-border">';
			str +='		<div class="direct-chat-info clearfix">';
			if(msg.clubUserImg == null){
				str +='				<span class="pull-right"><img alt="message user image" src="/image/profileimg.jpeg" class="session-img"></span>';
			}else{
				str +='				<span class="pull-right"><img alt="message user image" src="/image/userProfileImg/'+msg.clubUserImg+'" class="session-img"></span>';
			}
			str +='				<span class="direct-chat-reply-name pull-right">'+msg.clubUserId+'</span>';
			str +='		</div>';
			str +='		<div class="direct-chat-textleft">'+msg.clubMessageContent+'</div>';
			str +='		<div class="direct-chat-info clearfix">';
			str +='			<span class="direct-chat-timestamp pull-right">'+timestamp+'</span>';
			str +='		</div>';
			str +='</div>';
			
			$area.append(str);	

			var chatAreaHeight = $("#topmainM").height();
			var maxScroll = $("#mainMessage").height() - chatAreaHeight;
			$("#topmainM").scrollTop(maxScroll);		


		}else{

			$area=$('#mainMessage');
			str ='';
			str +='<div class="direct-chat-msg doted-border">';
			str +='		<div class="direct-chat-info clearfix">';
			str +='			<span class="direct-chat-name pull-left">'+msg.clubUserId+'</span>';
			str +='		</div>';
			if(msg.clubUserImg == null){				
				str +='		<img alt="message user image" src="/image/profileimg.jpeg" class="direct-chat-img">';
			}else{
				str +='		<img alt="message user image" src="/image/userProfileImg/'+msg.clubUserImg+'" class="direct-chat-img">';
			}	
			str +='		<div class="direct-chat-text">'+msg.clubMessageContent+'</div>';
			str +='		<div class="direct-chat-info clearfix">';
			str +='			<span class="direct-chat-timestamp pull-right">'+timestamp+'</span>';
			str +='		</div>';
			str +='</div>';

			$area.append(str);	

			var chatAreaHeight = $("#topmainM").height();
			var maxScroll = $("#mainMessage").height() - chatAreaHeight;
			$("#topmainM").scrollTop(maxScroll);


		}


	}
}

function disconnect(){
	sock.close();
	sock=null;
}

 function send() {
  var msg = $("#status_message").val();
  if(msg != ""){
	message = {};
	message.clubMessageContent = $("#status_message").val()
  	message.clubUserId = $("#chatUserId").val()
  }else{
	swal({
			title: "내용을 입력하세요.",
			icon: "error",
		}).then(function(){
			return false;
		});   
  }





  sock.send(JSON.stringify(message));
  $("#status_message").val("");
 }




 function getTimeStamp() {

		
		var monthNames = [ "1월", "2월", "3월", "4월", "5월", "6월",
		    "7월", "8월", "9월", "10월", "11월", "12월" ];
		var dayNames= ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"]

		var newDate = new Date();
		newDate.setDate(newDate.getDate());    
		var todaydate=newDate.getFullYear() + "년 " +monthNames[newDate.getMonth()]+ ' ' +newDate.getDate()   + '일 ' + dayNames[newDate.getDay()];


   	return todaydate;
 }

