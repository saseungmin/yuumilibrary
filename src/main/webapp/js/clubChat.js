
// $(window).load(function() {

// $(".messages").scrollTop($(".messages")[0].scrollHeight);


// });

$(window).load(function(){   
	$(".messages").animate({scrollTop:$(".messages")[0].scrollHeight}, "fast");
	$("#profile-img").addClass("online");
	$("#status-span").addClass("online");
});


$(document).ready(function(){
	connect();


	$('.submit').click(function() {
		send();
	});

	$(window).on('keydown', function(e) {
	if (e.which == 13) {
		send();
		return false;
	}
	});


});

function disconnect(){
	sock.close();
	sock=null;
}

 function connect() {
	    sock = new SockJS('/clubChat');
	    sock.onopen = function() {


	    };
	    sock.onmessage = function(evt) {
    	 	var data = evt.data;
			var obj = JSON.parse(data)  	   
			appendMessage(obj);
			$(".messages").animate({scrollTop:$(".messages")[0].scrollHeight}, "fast");

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
		var timestamp=newDate.getHours()+": "+("0"+newDate.getMinutes()).slice(-2);
		var mytamp=new Date().format("a/p hh:mm");
		var idsize = $("input[name='memId']").length;
		console.log(idsize);
		console.log(msg);
		if(msg.clubUserId==nowuser){
			if(msg.clubUserImg ==null){
				$('<li class="replies"><div class="text-right">'+msg.clubUserId+'</div><div><img src="/image/profileimg.jpeg" alt="" /><p class="contentp">'+msg.clubMessageContent+'</p></li><li class="time" style="margin-top: 0px;"><p class="timep" style="padding: 0px;">'+mytamp+'</p></div></li>').appendTo($('.messages ul'));
			}else{
				$('<li class="replies"><div class="text-right">'+msg.clubUserId+'</div><div><img src="/image/userProfileImg/'+msg.clubUserImg+'" alt="" /><p class="contentp">'+msg.clubMessageContent+'</p></li><li class="time" style="margin-top: 0px;"><p class="timep" style="padding: 0px;">'+mytamp+'</p></div></li>').appendTo($('.messages ul'));
			}
			$('.message-input input').val(null);
			$('.contact.active .preview').html('<span>You: </span>' + msg.clubMessageContent);
			//$(".messages").scrollTop($(".messages")[0].scrollHeight);
			// $(".messages").animate({scrollTop: docHeight + 93}, "fast");
			// docHeight += 93;


		}else{
			if(msg.clubUserImg ==null){
				$('<li class="sent"><div class="text-left">'+msg.clubUserId+'</div><div><img src="/image/profileimg.jpeg" alt="" /><p class="contentp">' + msg.clubMessageContent + '</p></li><li class="time" style="margin-top: 0px;"><p class="timeleft" style="padding: 0px;">'+mytamp+'</p></div></li>').appendTo($('.messages ul'));
			}else{
				$('<li class="sent"><div class="text-left">'+msg.clubUserId+'</div><div><img src="/image/userProfileImg/'+msg.clubUserImg+'" alt="" /><p class="contentp">' + msg.clubMessageContent + '</p></li><li class="time" style="margin-top: 0px;"><p class="timeleft" style="padding: 0px;">'+mytamp+'</p></div></li>').appendTo($('.messages ul'));
			}
			$('.message-input input').val(null);
/*			$('input[type=text][value=ffff]').closest(".meta").find(".preview").text("gdgdgdgdgdgdg");
*/			$("input[name='memId']").each(function (i) {
		        var my =$("input[name='memId']").eq(i).attr("value");
		        if(my==msg.clubUserId){
		        	var $name=$("input[name='memId']").eq(i).closest(".meta").find(".preview");
		        	console.log($name);
		        	$name.html('<span>'+my+': </span>' + msg.clubMessageContent);
		        	/*$('.contact .preview')*/
		        }
		    });
				// $(".messages").animate({scrollTop: docHeight + 93}, "fast");
				// docHeight += 93;

		}



	}
}



 function send() {


	msg = $(".message-input input").val();
	console.log(msg);
	if($.trim(msg) != ''){
		message = {};
		message.clubMessageContent = msg;
		message.clubUserId = $("#chatUserId").val();
		message.clubRoomNum = $("#clubNum").val();
		console.log(message);

		sock.send(JSON.stringify(message));
  	$(".message-input input").val("");
	}else{
		swal({
				title: "내용을 입력하세요.",
				icon: "error",
			}).then(function(){
				return false;
			});   
	}

 }



 Date.prototype.format = function(f) {
	    if (!this.valueOf()) return " ";
	 
	    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
	    var d = this;
	     
	    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
	        switch ($1) {
	            case "yyyy": return d.getFullYear();
	            case "yy": return (d.getFullYear() % 1000).zf(2);
	            case "MM": return (d.getMonth() + 1).zf(2);
	            case "dd": return d.getDate().zf(2);
	            case "E": return weekName[d.getDay()];
	            case "HH": return d.getHours().zf(2);
	            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
	            case "mm": return d.getMinutes().zf(2);
	            case "ss": return d.getSeconds().zf(2);
	            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
	            default: return $1;
	        }
	    });
	};
	 
	String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
	String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
	Number.prototype.zf = function(len){return this.toString().zf(len);
	};


 
 
 
 
 


$("#profile-img").click(function() {
	$("#status-options").toggleClass("active");
});

$(".expand-button").click(function() {
  $("#profile").toggleClass("expanded");
	$("#contacts").toggleClass("expanded");
});

$("#status-options ul li").click(function() {
	var userId=$("#chatUserId").val();
	
	$("#profile-img").removeClass();
	$("#status-span").removeClass();
	$("#status-online").removeClass("active");
	$("#status-away").removeClass("active");
	$("#status-busy").removeClass("active");
	$("#status-offline").removeClass("active");
	$(this).addClass("active");
	
	if($("#status-online").hasClass("active")) {
		$("#profile-img").addClass("online");
		$("#status-span").addClass("online");
	} else if ($("#status-away").hasClass("active")) {
		$("#profile-img").addClass("away");
		$("#status-span").addClass("away");
	} else if ($("#status-busy").hasClass("active")) {
		$("#profile-img").addClass("busy");
		$("#status-span").addClass("busy");
	} else if ($("#status-offline").hasClass("active")) {
		$("#profile-img").addClass("offline");
		$("#status-span").addClass("offline");
	} else {
		$("#profile-img").removeClass();
		$("#status-span").removeClass();
	};
	
	$("#status-options").removeClass("active");
	
//	var status=$("#profile-img").attr("class");
//	console.log(status);
//	params={ "userId": userId, "status": status}
//	
//	$.ajax({
//		type:"POST",
//		url: '/club/userStatus.lol',
//		dataType: 'json',
//		data : params,
//		success : function(data) {
//			$("input[name='memId']").each(function (i) {
//				var my =$("input[name='memId']").eq(i).attr("value");
//				if(my == data.userId){
//					var qw=$("input[name='memId']").eq(i).parent().prev().prev().addClass(data.status);
//					console.log(qw);
//				}
//			})
//			
//			
//			
//		}
//	});
});







