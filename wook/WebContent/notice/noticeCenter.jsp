<%@page import="java.text.SimpleDateFormat"%>
<%@page import="notice.noticeDAO"%>
<%@page import="notice.noticeVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <c:set var="contextPath"  value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/notice.css">
	<c:set var="id" value="${sessionScope.id }"/>
	<c:set var = "DAO" value="${noticeDAO}" /> 
	<c:set var = "count" value="${DAO.getnoticeCount}"/>
	
	
<!-- 	String id = (String)session.getAttribute("id");   -->
<!-- 	noticeDAO dao = new noticeDAO(); -->	
<!-- 	int count = dao.getnoticeCount(); -->	
<!-- 	int pageSize = 5; //하나의 화면 마다 보여줄 글 개수 10 -->
<!-- 	String pageNum = request.getParameter("pageNum"); //현재 선택한 페이지 번호 -->	
<!-- 	if(pageNum == null){ //현재 선택한 페이지 번호가 없으면 -->
<!-- 		pageNum = "1"; //1페이지 처리 -->
<!-- 	} -->
<!-- 	int currentPage = Integer.parseInt(pageNum); //pageNum을 정수로 변경 -->
<!-- 	//각 페이지마다 첫번째 글번호 -->
<!-- 	int startRow = (currentPage - 1) * pageSize; -->
	
<!-- 	List<noticeVO> list = null; -->
	
<!-- 	if(count > 0){ -->
<!-- 		list = dao.getnoticeList(startRow, pageSize); -->
<!-- 	} -->

</head>
<body>
<div class="container-fluid">   
    <div class="row" >&nbsp;</div>
    <div class="row" id="main_img">
		  <div class="content">
		    <h1>Notice</h1>
		  </div>
		
   		 </div>
    
    
	<div class="row">
  		<div class="col-md-10 col-md-offset-1">

<br><br>

		    <table class="table table-hover" id="table1">
				<tr>
				<td class="tno"><b>No.</b></td>
			    <td class="ttitle"><b>Title</b></td>
			    <td class="twrite"><b>Writer</b></td>
			    <td class="tdate"><b>Date</b></td>
			    <td class="tread"><b>Read</b></td>
				</tr>
			
			<c:if test="${articleList == null }">																								
				<tr>
					<td colspan="5">게시판 글이 없습니다.</td>
				</tr>			
			</c:if>
			<c:if test="${articleList != null }">
			<c:forEach var="article" items="${articleList }">
				<c:url var="url1" value="/not/noticeContent.do">
				<c:param name="num" value="${article.num}"/>
				</c:url>
				<tr align="center" onclick="location.href='${url1}'">
					<td width="5%">${article.num }</td>
					<td width="15%">${article.title }</td>
					<td width="15%">${article.id }</td>
					<td width="5%"><fmt:formatDate value="${article.date}"/></td>
					<td>${article.count }</td>				
				</tr>
			</c:forEach>
			</c:if>
			</table>		
			<c:if test="${not empty sessionScope.id }">					
			<div id = "btnarea">
				<div class="btn-div">
				<button class="btn wrbtn" id="btn1" onclick="location.href='${contextPath}/not/write.do'">글쓰기</button> &nbsp;&nbsp;				
				</div>
			</div>
			</c:if>
			
		
		<!-- <button class="btn wrbtn" id="btn3" 
							onclick="location.href='notice.jsp'">처음으로</button> &nbsp;		
		<div class="search">
			<form action="notice_search.jsp" name="search" method="post">
			<div class="example">
  			<input type="text" placeholder="Search.." name="search">
  			<button type="submit"><i class="fa fa-search"></i></button>
			</div>
			</form>
		</div>
				 -->

			<%-- <div class="pagination">
			
				<c:if test ="${count > 0 }">
				<c:if test ="${startPage > pageBlock}">
				<cL		
					<a href="notice.jsp?pageNum=<%=startPage-pageBlock %>">◀◀</a>
				
					for(int i=startPage;i<=endPage;i++){
				
					<a href="notice.jsp?pageNum=<%=i %>">[<%=i %>]</a>
				
				
					if(endPage < pageCount){
				
					<a href="notice.jsp?pageNum=<%=startPage+pageBlock %>">▶▶</a>
			
			</div> --%>
						
		</div>	
	</div>
	</div>
</body>
</html>