<%@ page language="java" contentType="application/vnd.ms-excel; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<% 
  String filename = request.getAttribute("filename").toString();
  response.setHeader("Content-Type", "application/vnd.ms-xls");
  response.setHeader("Content-Disposition", "inline; filename=LoanList_" + filename + ".xls");
%>​ 
</head>
<body>
	<table class="grid table table-striped table-bordered table-hover">
		<tr id="table-head">
			<th>도서번호</th>
			<th>도서명</th>
			<th>대출인</th>
			<th>대출일</th>
			<th>반납일</th>
			<th>반납여부</th>
		</tr>
		<c:forEach items="${loanList}" var="vo">
			<tr class="text-center">
				<td><a href="bookView.lol?bookIsbn=${vo.loaIsbn}">${vo.loaIsbn}</a></td>
				<td class="text-left">${vo.loaBookName}</td>
				<td class="text-left">${vo.loaMemId}</td>
				<td>${vo.loaLoanDate}</td>
				<td>${vo.loaReturnDate}</td>
				<c:if test="${vo.loaReturnYN.equals('N')}">
					<td><a href="returnBook.lol?bookIsbn=${vo.loaIsbn}"><i
							class="fas fa-user-edit"></i>&nbsp;미반납</a></td>
				</c:if>
				<c:if test="${vo.loaReturnYN.equals('Y')}">
					<td><i class="fas fa-user-edit"></i>&nbsp;반납완료</td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
</body>
</html>