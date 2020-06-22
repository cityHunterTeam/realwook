<%@page import="Mypage.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
<%
	request.setCharacterEncoding("UTF-8");
	ReviewDAO reviewDAO = new ReviewDAO();
//	int count = reviewDAO.getReviewCount();
	int pageSize = 10; //한페이지당 보여줄 글 갯수
	
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize;
	
	String search = "";
	
	if(request.getParameter("search") != null)
	{
		search = request.getParameter("search"); 
		
	}

/* 	List<BoardBean> list = null;
	
	if(count > 0){
		list=boardDAO.getBoardList(startRow, pageSize, search);
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyy.MM.dd"); */

%>
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
<%-- <%
	if(count > 0){
		for(int i=0; i<list.size;i++){
			ReviewVO VO = list.get(i);
%> --%>
  <tr>
    <td>${num }</td>
    <td>${title }</td>
    <td>${date }</td>
  </tr>
<%-- <% 
 		}
 	}
%>     --%>
</table>

	<button type="button" onclick="location.href='reviewWhite.jsp'">글쓰기</button>


<!-- 밑바닥 -->
<jsp:include page="../member/footer.jsp"></jsp:include>


</body>
</html>


