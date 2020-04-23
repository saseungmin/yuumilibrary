<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
  
<!DOCTYPE html>
<html lang="ko">
  <head>
  	<%@include file="/inc/common_header.jsp" %>
 	<title>${resultMessage.title}</title>
  </head>
<body>
  <%@include file="/inc/top_menu.jsp" %>
<div class="container">

		<div class="row col-md-8 col-md-offset-2">
			<div class="page-header">
				<h3>${resultMessage.title}</h3>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<p>${resultMessage.message}</p>
				</div>
				<div class="panel-body">
					<a href="${pageContext.request.contextPath}/index.jsp"
						class="btn btn-primary"> <span
						class="glyphicon glyphicon-home" aria-hidden="true"></span>
						&nbsp;Home
					</a>
					<div class="pull-right">
						<a href="#" onclick="history.back()" class="btn btn-default">
							<span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
							&nbsp;뒤로가기
						</a> &nbsp;&nbsp;
						<c:if test="${not empty resultMessage.url}">
							<a href="${pageContext.request.contextPath}${resultMessage.url}"
								class="btn btn-warning"> <span
								class="glyphicon glyphicon-new-window aria-hidden="true"></span>
								&nbsp;${resultMessage.urlTitle}
							</a>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>