<%@page import="java.sql.Date"%>
<%@page import="notice.noticeDAO"%>
<%@page import="notice.noticeVO"%>
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
<link type="text/css" rel="stylesheet" href="../css/board.css" />
<%
	request.setCharacterEncoding("UTF-8");
%>
	<c:set var = "DAO" value="${noticeDAO}" /> 
</head>
<body>
<div class="container">
<article>
<form action="${contextPath}/not/noticeContent.do" method="post" >
<input type="hidden" name="num" value="${vo.num }">
  <h2>공지사항</h2>  <br><br>      
  <table class="table table-bordered">
    <tbody>
      <tr>
      <td>${vo.title}</td>
      <td>작성자 : ${vo.id}</td>
      <td>조회수 : ${vo.count}</td>
      </tr>
      <tr>
      <td colspan="4">${vo.content}<br><br><br><br><br><br><br><br><br><br><br><br><br></td>
	</tr>
    </tbody>
  </table>
 </form>
				<div id = "btnarea">
					<div class="btn-div">
						<button class="btn wrbtn" id="btn1"
							onclick="location.href='${contextPath}/not/noticeUpdate.do?num=${vo.num}'">수정하기</button> &nbsp;
						<button class="btn wrbtn" id="btn2"
							onclick="${contextPath}/not/noticeDelete.do?num=${vo.num}">삭제</button>&nbsp;									
				<button class="btn wrbtn" id="btn3" 
							onclick="location.href='${contextPath}/not/notice.do'">처음으로</button> &nbsp;
					</div>
				</div>
					</article>
			</div>
		
	<div style="height: 50px;"></div>
</body>
</html>