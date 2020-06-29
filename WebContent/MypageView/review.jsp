<%@page import="Mypage.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
  border: 1px solid #ddd;
  width: 70%;
  margin: auto;
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
  <tr align="center">
    <th>글번호</th>
    <th>제목</th>
    <th>작성자</th>
    <th>작성일자</th>
    <th>조회수</th>
  </tr>

  	    
	<c:if test="${articleList == null }">
			<tr height="10">
				<td colspan="4">
					<p align="center"><b>등록된 글이 없습니다.</b></p>
				</td>
			</tr>
	</c:if>
	
	<c:if test="${articleList != null}">
		<%--ArrayList객체의 크기(검색한 글의 갯수(ArticleVO객체의 갯수))만큼 반복하여
			검색한 글정보(ArticleVO객체)들을 ArrayList배열 내부의 각인덱스 위치로부터 차례대로 꺼내와
			검색한 글목록을 표시합니다.
		 --%>
		<c:forEach var="article" items="${articleList}">
			<tr align="center">
				<%--ArticleVO객체의 id변수값 얻어 출력 --%>
				<th width="5%">${article.num}</th>
				<th width="8%">${article.title}</th>
				<th width="3%">${article.id}</th>
				<th width="2%"><fmt:formatDate value="${article.date}"/></th>								
				<th width="1%">조회</th>
			</tr>
		</c:forEach>
	</c:if>
	
	<c:if test="${count > 0}">
		<c:if test="${startPage > pageBlock}">
			<c:url var="url1" value="/mypage/review.do">
				<c:param name="pageNum" value="${startPage-pageBlock}"/>
			</c:url>
			<a style="font-size: x-large;" class="page-link" href='${url1}'>Previous</a>
		</c:if>
		
		<c:forEach var="i" begin="${startPage}" end="${endpage}">
		<c:url var="url2" value="/mypage/review.do">
		<c:param name="pageNum" value="${i}"/>
		</c:url>
			<a style="font-size: x-large;" class="page-link" href='${url2}'>${i}</a>
		</c:forEach>
		
		<c:if test="${endPage < pageCount}">
			<c:url var="url3" value="/mypage/review.do">
				<c:param name="pageNum" value="${startPage+pageBlock}"/>
			</c:url>
			<a style="font-size: x-large;" class="page-link" href='${url3}'>Next</a>
		</c:if>
	</c:if>
					
</table>

<c:if test="${sessionScope.id != null}">
	<button type="button" onclick="location.href='${contextPath}/mypage/reviewWrite.do'">글쓰기</button>
</c:if>


<!-- 밑바닥 -->
<jsp:include page="../member/footer.jsp"></jsp:include>


</body>
</html>


