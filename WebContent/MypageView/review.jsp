<%@page import="Mypage.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <c:set var="contextPath"  value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>

table {
  border-collapse: collapse;
  border-spacing: 0;
  width: 100%;
  border: 1px solid #ddd;
}

th, td {
  text-align: left;
  padding: 16px;
}

tr:nth-child(even) {
  background-color: #f2f2f2;
}
</style>
</head>
<body>

<!-- 대가리 --> 
<jsp:include page="../member/header.jsp"/>

<br><br><br>
<form align="center" color="blue">
<h2>리뷰 게시판</h2>
<p>여행객들의 리뷰를 적는 게시판 입니다.</p>
</form>
<table>
  <tr>
    <th>글번호</th>
    <th>제목</th>
    <th>작성일자</th>
  </tr>

  <tr>
    <td>${num }</td>
    <td>${title }</td>
    <td>${date }</td>
  </tr>
  <c:choose>
	<%--BoardController.java서블릿으로 부터 전달 받은 
	    request영역에 articleList속성(키)이름으로 바인딩된 ArryList객체가 저장되어 있지 않다면? --%>
	    
	<c:when test="${ReviewList == null }">
			<tr height="10">
				<td colspan="4">
					<p align="center"><b>등록된 글이 없습니다.</b></p>
				</td>
			</tr>
	</c:when>
	
	<c:when test="${ReviewList != null}">
		<%--ArrayList객체의 크기(검색한 글의 갯수(ArticleVO객체의 갯수))만큼 반복하여
			검색한 글정보(ArticleVO객체)들을 ArrayList배열 내부의 각인덱스 위치로부터 차례대로 꺼내와
			검색한 글목록을 표시합니다.
		 --%>
		<c:forEach var="Review" items="${ReviewList}" varStatus="ReviewNum">
			<tr align="center">
				<%--varStatus의 count속성을 이용해 글번호를 1부터 자동으로 표시함 --%>
				<td width="5%">${ReviewNum.count}</td>
				<%--ArticleVO객체의 id변수값 얻어 출력 --%>
				<td width="10%">${Review.id}</td>
				<td width="10%">${Review.title}</td>
				<td width="10%">${Review.content}</td>
								
				<td width="35%" align="left">
					<%--왼쪽으로 30px만큼 여백을 준 후 글제목을 표시할 목적으로 여백을 줌 --%>
					<span style="padding-right: 30px"></span>
					
					
				</td>
				<td width="10%"><fmt:formateDate value="${ReviewList.writeDate}"/></td>
			</tr>
		</c:forEach>
	</c:when>
</c:choose>
					
</table>

<c:if test="${sessionScope.id != null}">
	<button type="button" onclick="location.href='${contextPath}/mypage/reviewWrite.do'">글쓰기</button>
</c:if>


<!-- 밑바닥 -->
<jsp:include page="../member/footer.jsp"></jsp:include>


</body>
</html>


