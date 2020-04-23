<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>클럽 채팅</title>
    <link href="<c:url value='/css/bootstrap.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/css/clubChat.css?dummi=12'/>" rel="stylesheet">    
    <link href="<c:url value='/font-awesome-4.7.0/css/font-awesome.css'/>" rel="stylesheet">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style type="text/css">
.timep{
	
	padding: 0px;
    float: right;
    margin-right: 45px;
    font-size: 0.8em;
    font-style: italic;
	
}
 
.timeleft{
	
	padding: 0px;
	margin-left: 35px;
    font-size: 0.8em;
    font-style: italic;
	
}

.contentp{
	margin-bottom: 0px;
	
}
.clubName{
	margin-top: 15px;
}
.statusul{
	padding-left: 10px;
    margin-bottom: 0px;
}

li.replies div.text-right{
	margin-right: 5px;
    margin-bottom: 3px;
    font-size: 0.8em;
}
li.sent div.text-left{
	margin-right: 5px;
    margin-bottom: 3px;
    font-size: 0.8em;
}

</style>
</head>
<body>
<input type="hidden" value="${sessionScope.USER_INFO.userID}" id="chatUserId"/>
<input type="hidden" value="${club.bkNum}" id="clubNum"/>

<div id="frame">
	<div id="sidepanel">
		<div id="profile">
			<div class="wrap">
			<c:if test="${not empty list}">
				<c:forEach items="${list}" var="vo" varStatus="st">
					<c:choose>
						<c:when test="${vo.cmMemId eq sessionScope.USER_INFO.userID}">
							<c:if test="${empty vo.cmMemImg}">
								<img src="/image/profileimg.jpeg" alt="" id="profile-img"/>
								<p>${vo.cmMemId}</p>
							</c:if>
							<c:if test="${not empty vo.cmMemImg}">
								<img src="/image/userProfileImg/${vo.cmMemImg}" alt="" id="profile-img"/>
								<p>${vo.cmMemId}</p>
							</c:if>	
								<i class="fa fa-chevron-down expand-button" aria-hidden="true"></i>
								<div id="status-options">
									<ul class="statusul">
										<li id="status-online" class="active"><span class="status-circle"></span> <p>Online</p></li>
										<li id="status-away"><span class="status-circle"></span> <p>Away</p></li>
										<li id="status-busy"><span class="status-circle"></span> <p>Busy</p></li>
										<li id="status-offline"><span class="status-circle"></span> <p>Offline</p></li>
									</ul>
								</div>
								<div id="expanded">
									<label for="twitter"><i class="fa fa-facebook fa-fw" aria-hidden="true"></i></label>
									<input name="twitter" type="text" value="${vo.cmMemMail}" readonly="readonly"/>
									<label for="twitter"><i class="fa fa-twitter fa-fw" aria-hidden="true"></i></label>
									<input name="twitter" type="text" value="${vo.cmCommNm}" readonly="readonly"/>
								</div>
						</c:when>
					</c:choose>
				
				</c:forEach>
			</c:if>
			</div>
		</div>
		<div id="search">
			<label for=""><i class="fa fa-search" aria-hidden="true"></i></label>
			<input type="text" placeholder="Search contacts..." />
		</div>
		<div id="contacts">
			<ul>
			<c:if test="${not empty list}">
				<c:forEach items="${list}" var="vo" varStatus="st">
					<c:choose>
						<c:when test="${vo.cmMemId ne sessionScope.USER_INFO.userID}">
							<li class="contact">
								<div class="wrap">
									<span class="contact-status online"></span>
									<c:choose>
										<c:when test="${empty vo.cmMemImg}">
											<img src="/image/profileimg.jpeg" alt="" />
										</c:when>
										<c:otherwise>
											<img src="/image/userProfileImg/${vo.cmMemImg}" alt="" />
										</c:otherwise>
									</c:choose>
									<div class="meta">
										<input name="memId" value="${vo.cmMemId}" type="hidden">
										<p class="name">${vo.cmMemId}</p>
										<p class="preview"></p>
									</div>
								</div>
							</li>
						</c:when>
						<c:otherwise>
							<li class="contact active">
								<div class="wrap">
									<span id="status-span" class="contact-status"></span>
									<c:choose>
										<c:when test="${empty vo.cmMemImg}">
											<img src="/image/profileimg.jpeg" alt="" />
										</c:when>
										<c:otherwise>
											<img src="/image/userProfileImg/${vo.cmMemImg}" alt="" />
										</c:otherwise>
									</c:choose>
									<div class="meta">
										<input name="memId" value="${vo.cmMemId}" type="hidden">
										<p class="name">${vo.cmMemId}</p>
										<p class="preview"></p>
									</div>
								</div>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:if>
			</ul>
		</div>
		<div id="bottom-bar">
			<button id="addcontact"><i class="fa fa-user-plus fa-fw" aria-hidden="true"></i> <span>Add contact</span></button>
			<button id="settings"><i class="fa fa-cog fa-fw" aria-hidden="true"></i> <span>Settings</span></button>
		</div>
	</div>
	<div class="content">
		<div class="contact-profile">
		<c:choose>
			<c:when test="${empty club.bkImageurl}">
				<img src="http://ssl.gstatic.com/accounts/ui/avatar_2x.png" alt="사진을 등록해주세요.">
			</c:when>
			<c:otherwise>
				<img src="/image/clubProfileImg/${club.bkImageurl}" alt="${club.bkClubName}">
			</c:otherwise>
		</c:choose>
			<p class="clubName">${club.bkClubName}</p>
			<div class="social-media">
				<i class="fa fa-facebook" aria-hidden="true"></i>
				<i class="fa fa-twitter" aria-hidden="true"></i>
				 <i class="fa fa-instagram" aria-hidden="true"></i>
			</div>
		</div>
		<div class="messages">
			<ul>
				<c:if test="${not empty message}">
					<c:forEach items="${message}" var="msg" varStatus="st">					
						<c:choose>
							<c:when test="${msg.clubUserId eq sessionScope.USER_INFO.userID}">
								<li class="replies">
									<div class="text-right">
										${msg.clubUserId}
									</div>
									<div>
									<c:if test="${empty msg.clubUserImg}">
										<img src="/image/profileimg.jpeg" alt="" />
									</c:if>
									<c:if test="${not empty msg.clubUserImg}">
										<img src="/image/userProfileImg/${msg.clubUserImg}" alt="" />
									</c:if>
										<p style="margin-bottom: 0px;">${msg.clubMessageContent}</p>
									</div>
								</li>
								<li class="time" style="margin-top: 0px;"><p class="timep" style="padding: 0px;">${msg.clubMessageSendtime}</p></li>
							</c:when>
							<c:otherwise>
								<li class="sent">
									<div class="text-left">${msg.clubUserId}</div>
									<div>
									<c:if test="${empty msg.clubUserImg}">
										<img src="/image/profileimg.jpeg" alt="" />
									</c:if>
									<c:if test="${not empty msg.clubUserImg}">
										<img src="/image/userProfileImg/${msg.clubUserImg}" alt="" />
									</c:if>
										<p style="margin-bottom: 0px;">${msg.clubMessageContent}</p>
									</div>
								</li>
								<li style="margin-top: 0px;"><p class="timeleft" style="padding: 0px;">${msg.clubMessageSendtime}</p></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:if>
			</ul>
		</div>
		<div class="message-input">
			<div class="wrap">
			<input type="text" placeholder="메시지를 입력해주세요." />
			<i class="fa fa-paperclip attachment" aria-hidden="true"></i>
			<button class="submit"><i class="fa fa-paper-plane" aria-hidden="true"></i></button>
			</div>
		</div>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<script src="<c:url value='/js/jquery.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/js/sockjs.js'/>"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://kit.fontawesome.com/4a2ee2359f.js" crossorigin="anonymous"></script>
<script src="<c:url value='/js/clubChat.js?dummi=122'/>"></script>
<script type="text/javascript">

</script>
</body>
</html>