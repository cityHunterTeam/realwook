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
<div class="container">
<form action="${contextPath}/mypage/reviewWritePro.do" align="center" color="blue" method="post" enctype="multipart/form-data">
<h1>리뷰 글쓰기</h1>
<p>여행객들의 리뷰를 적는 게시판 입니다.</p>
	
    <hr>
    <div>
    <label for="id" ><b>작성자</b></label>
    <input type="text" id="id" name="id" value="${sessionScope.id}" readonly>
        
	</div>
	<div>
	<label for="image" ><b>이미지</b></label>
    <input type="file" id="image" name="image">
	</div>
	<div>
    <label for="title"><b>제목</b></label>
    <input type="text" id="title" placeholder="제목을 입력하세요." name="title" rows="5" cols="5" required>
	</div>
	<div>
    <label for="content"><b>글내용</b></label>
    <textarea id="content" placeholder="내용을 입력하세요." name="content" required></textarea>
	</div>
	
    <div class="clearfix">
      <button type="button" class="cancelbtn" onclick="location.href='${contextPath}/mypage/review.do'">돌아가기</button>
      <button type="submit" class="signupbtn">글쓰기</button>
    </div>
    
  </div>
</form>



<!-- 밑바닥 -->
<jsp:include page="../member/footer.jsp"></jsp:include>


</body>
</html>


