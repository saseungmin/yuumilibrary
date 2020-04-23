<%@ page language="java"
	contentType="application/vnd.ms-excel; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%
	String filename = request.getAttribute("filename").toString();
	response.setHeader("Content-Type", "application/vnd.ms-xls");
	response.setHeader("Content-Disposition", "inline; filename=MemberList_" + filename + ".xls");
%>​
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table class="table table-bordered">
		<colgroup>
			<col width="5%" />
			<col width="5%" />
			<col width="5%" />
			<col width="20%" />
			<col width="5%" />
			<%-- 		<col width="5%" /> --%>
			<col width="5%" />
		</colgroup>
		<tr>
			<th>NO</th>
			<th>ID</th>
			<th>회원명</th>
			<th>주소</th>
			<th>선호장르</th>
			<th>등급</th>
		</tr>
		<c:forEach items="${list}" var="vo" varStatus="st">
			<tr>
				<td>${st.count}</td>
				<td><a href="memberView.lol?memId=${vo.memId}">${vo.memId}</a></td>
				<td>${vo.memName}</td>
				<td>${vo.memAdd1}${vo.memAdd2}</td>
				<td>${vo.memPrefNm}</td>
				<td>${vo.memRank}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>