<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서관 상세보기</title>
<%@include file="/inc/common_header.jsp"%>
<%@include file="/inc/top_menu.jsp"%>
</head>
<body>
	<table>
		<tr class="text-center">
			<td>도서관이름 : <h3>${list.libName}</h3></td>
			<td>운영시간 : ${list.libTime}</td>
			<td>도서관코드 : ${list.libCode}</td>
			<td>전화번호 ${list.libTel}</td>
			<td>위도 : ${list.libLatitude}</td>
			<td>경도 : ${list.libLongitude}</td>
		</tr>
	</table>
	
	<h1> 카카오지도 API활용해서 지도띄우기!!</h1>
	
	
		<%@include file="/inc/footer.jsp"%>
</body>
</html>