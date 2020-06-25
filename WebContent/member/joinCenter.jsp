<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

  

<!DOCTYPE html>
<html>
<head>


<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/join.css">
<script src="http://code.jquery.com/jquery.js"></script> <%--유효성떄메 --%> 
<script type="text/javascript">
	function checkPwd(){
		 var pwd1 = $("#passwd").val();
		 var checkSpan = $("#checkPwd1");
		 var reg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/;
		
		 if(!reg.test(pwd1)){
			 checkSpan.html("<b style='color:red'>영문,특수문자,숫자 조합으로 8자 이상으로 작성하세요.</b>");
			 result_pwd = false;
		 }else{
			 checkSpan.html("<b style='color:#7300e6'>사용가능한 비밀번호 입니다.</b>");
			 result_pwd = true;
		 }
	}
	
	function checkPwd2(){
		   	var pwd1 = document.getElementById("passwd").value;
		    var pwd2 = document.getElementById("passwd-repeat").value;
		    var checkSpan = document.getElementById("checkPwd2");
		    if(pwd2 != ""){
			   	if(pwd1 == pwd2){
			    	checkSpan.innerHTML = "<b style='color:aqua'>비밀번호가 일치합니다.</b>";
			    	result_pwd2 = true;
			   	}else{
			   		checkSpan.innerHTML = "<b style='color:aqua'>비밀번호가 일치하지 않습니다.</b>";
			   		result_pwd2 = false;
			    }
		    }
		    setTimeout("checkPwd2()",0);
	}

	function checkPhone(){
		var phone = $("#phone").val();
		var checkSpan2 = $("#checkPhone");
		var regPhone = /^((01[1|6|7|8|9])[1-9]+[0-9]{6,7})|(010[1-9][0-9]{7})$/;
		
	 	if(!regPhone.test(phone)){
	 		checkSpan2.html("<b style='color:aqua'>형식이 맞지 않습니다.</b>");
	 	}else{
	 		checkSpan2.html("<b style='color:aqua'>사용가능한 전화번호</b>");
	 	}
	}

	function checkId(){
		 var id = $("#id").val();
		 var checkSpan4 = $("#checkId");
		 var regId = /^[a-zA-Z0-9]{4,12}$/;
		 
		 if(!regId.test(id)){
			 checkSpan4.html("<b style='color:aqua'>아이디는 4~12글자로 대/소문자와 숫자만 사용가능합니다.</b>");
			 document.getElementById("authBtn").disabled=true;
		 }else{
			 checkSpan4.html("<b style='color:aqua'>사용가능한 아이디 입니다.중복확인을 해주세요.</b>");
			 document.getElementById("authBtn").disabled=false;
		 }
	}

	function checkName(){
		var name = $("#name").val();
		var checkSpan3 = $("#checkName");
		var regName = /^[가-힣]{2,4}$/;
		
	 	if(!regName.test(name)){
	 		checkSpan3.html("<b style='color:aqua'>형식이 맞지 않습니다.</b>");
	 	}else{
	 		checkSpan3.html("<b style='color:aqua'>사용가능 합니다.</b>");
	 	}
	}
			
	function checkForm(){
				
				if($("#id").val()==""){
					alert("아이디를 입력해 주시기 바랍니다.");
					$("#id").focus();
					return false;
				}else if($("#InputPassword1").val()==""){
					alert("비밀번호를 입력해 주시기 바랍니다.");
					$("#InputPassword1").focus();
					return false;
				}else if($("#InputPassword2").val()==""){
					alert("비밀번호 확인창을 입력해야 합니다.");
					$("#InputPassword2").focus();
					return false;
				}else if(result_pwd == false){
					alert("비밀번호 형식이 잘못되었습니다.");
					$("#InputPassword1").focus();
					return false;
				}else if(result_pwd2 == false){
					alert("두 비밀번호가 일치하지 않습니다.");
					$("#InputPassword1").focus();
					return false;
				}else if($("#name").val()==""){
					alert("이름을 입력해야 합니다.");
					$("#name").focus();
					return false;
				}else if(idx==false){
					alert("이미 사용중인 아이디입니다.");
					return false;
				}else{
					return;
				}
			}

</script>
</head>
<body>
 <c:set var="contextPath"  value="${pageContext.request.contextPath}"/>    

<form action="${contextPath}/mem/joinPro.do" method="post" style="border:1px solid #ccc">
  <div class="container">
    <h1>Sign Up</h1>
    <p>Please fill in this form to create an account.</p>
    <hr>
	<div>
    <label for="id"><b>Id</b></label>
    <input type="text" id="id" placeholder="Enter Id" name="id" required onblur="checkId()">
    <span id="checkId">&nbsp;</span>
	</div>
	<div>
    <label for="psw"><b>Password</b></label>
    <input type="password" id="passwd" placeholder="Enter Password" name="passwd" required onblur="checkPwd()">
    <span id="checkPwd1">&nbsp;</span>
	</div>
	<div>
    <label for="psw-repeat"><b>Repeat Password</b></label>
    <input type="password" id="passwd-repeat" placeholder="Repeat Password" name="passwd-repeat" required onblur="checkPwd2()">
    <span id="checkPwd2">&nbsp;</span>
	</div>
	<label for="name"><b>Name</b></label>
	<input type="text" placeholder="Enter Name" name="name" id="name" required onblur="checkName()">
	<span id="checkName">&nbsp;</span><br>

	<label for="birth"><b>Birth</b></label>
	<input type="text" placeholder="Enter Birth" name="birth" id="birth" required>
	
	
	<label for="email"><b>Email</b></label>
	<input type="email" name="email" id="email" placeholder="Email" required >
	
	<label for="phone"><b>Phone</b></label>
	<input type="text" name="phone" id="phone" placeholder="Phone" required onblur="checkPhone()">
	<span id="checkPhone">&nbsp;</span>
	
	<label for="address"><b>Address</b></label>
	<input type="text" name="address" id="address" placeholder="Address" required >
	


    <label>
      <input type="checkbox" checked="checked" name="remember" style="margin-bottom:15px"> Remember me
    </label>

    <p>By creating an account you agree to our <a href="#" style="color:dodgerblue">Terms & Privacy</a>.</p>

    <div class="clearfix">
      <button type="button" class="cancelbtn">Cancel</button>
      <button type="submit" class="signupbtn">Sign Up</button>
    </div>
    
  </div>
</form>
</body>
</html>