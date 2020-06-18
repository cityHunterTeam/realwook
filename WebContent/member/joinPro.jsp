<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Martine</title>
    <link rel="icon" href="../img/favicon.png">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <!-- animate CSS -->
    <link rel="stylesheet" href="../css/animate.css">
    <!-- owl carousel CSS -->
    <link rel="stylesheet" href="../css/owl.carousel.min.css">
    <!-- themify CSS -->
    <link rel="stylesheet" href="../css/themify-icons.css">
    <!-- flaticon CSS -->
    <link rel="stylesheet" href="../css/flaticon.css">
    <!-- fontawesome CSS -->
    <link rel="stylesheet" href="../fontawesome/css/all.min.css">
    <!-- magnific CSS -->
    <link rel="stylesheet" href="../css/magnific-popup.css">
    <link rel="stylesheet" href="../css/gijgo.min.css">
    <!-- niceselect CSS -->
    <link rel="stylesheet" href="../css/nice-select.css">
    <!-- slick CSS -->
    <link rel="stylesheet" href="../css/slick.css">
    <!-- style CSS -->
    <link rel="stylesheet" href="../css/style.css">
</head>

<body>
   <!--::header part start::-->
	<jsp:include page="header.jsp"/>
    <!-- Header part end-->
<!-- 회원가입폼 -->
 <form action="joinPro.jsp" method="post" id="join" name="fr">
  <div class="container" id="mem_join_con">
    <h1>Sign Up</h1>
    <hr>

	<fieldset id="mem_join">
	<legend>필수 입력사항</legend>
	<ul id="id_sec">
	<li> <label for="id"><b>ID</b>
	<span id="id_sp2"> *아이디는 4~12자의 영문 대소문자와 숫자만 가능합니다</span></label>
	<input type="text"  placeholder="Enter Id"  onkeydown="inputIdChk()" name="id" id="id" required>
	</li>
	<li> <button type="button" class="idchbtn" id="BTN_USERID_CHECK" onclick="winopen();">ID 중복체크</button>
	<input type="hidden" name="idDuplication" value="idUncheck"> </li>
	</ul> <br/><br/><br/><br/><br/>

    <label for="psw"><b>Password</b>  <span id="pass_sp1"> *비밀번호는 4~12자의 영문 대소문자와 숫자만 가능합니다 <br/></span>
    <span id="pass_sp2"> *비밀번호에는 하나이상의 문자와 숫자가 포함되어야 합니다.</span> </label>
    <input type="password" placeholder="Enter Password" name="pass" id="pass"required>
   
    <label for="psw-repeat"><b>Repeat Password</b>
    <span id="pass_sp3"> *비밀번호가 다릅니다.</span></label>
    <input type="password" placeholder="Repeat Password" name="pass-repeat" id="pass-repeat"required>

  	<label for="name"><b>Name</b>
  	<span id="name_sp"> *이름은 2자 이상의 문자만 입력할 수 있습니다.</span></label>
    <input type="text" placeholder="Enter Name" name="name" id="name" required>
    
    <label for="phone"><b>Phone</b>
    <span id="ph_sp"> *전화번호 형식이 잘못되었습니다.</span> </label>
    <input type="text" placeholder="Enter Phone" name="phone" id="phone" required>
    
    <label for="email"><b>Email</b>
    <span id="email_sp"> *이메일 형식이 잘못되었습니다.</span></label>
    <input type="text" placeholder="Enter email" name="email" id="email" required>
    </fieldset>
    <br><br>
    <fieldset>
	<legend>선택 입력사항</legend>

    <label for="sex"><b>성별</b></label><br/><br/>
    <input type="radio" name="gender" value="female">female &nbsp;&nbsp;&nbsp;&nbsp; 
	<input type="radio" name="gender" value="male">male &nbsp;&nbsp;&nbsp;&nbsp;
	<input type="radio" name="gender" value="none">알리고싶지않음 <br><br/>

    <label for="birth"><b>Birth</b>
    <span id="birth_sp"> *생일은 형식이 올바르지 않습니다.(6자리 숫자만 가능)</span></label>
    <input type="text" placeholder="Enter birth" name="birth" id="birth">

    <label for="addr"><b>Address</b></label>	<br>
	<label>
    <input type="text" id="sample6_postcode" name="postcode" placeholder="우편번호" readonly="readonly" style="width: 50%">
	&nbsp; &nbsp;
	<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" id="postcode_btn"><br>
	</label>
	<input type="text" id="sample6_address" name="addr1" placeholder="주소" readonly="readonly">
	<input type="text" id="sample6_address2" name="addr2" placeholder="상세주소">
    
    
    
    </fieldset>

    <div class="clearfix">
      <button type="reset" class="cancelbtn">Cancel</button>
      <button type="button" class="signupbtn" id="btnSend" onclick="checkVlaue(); return false;">Sign Up</button>
    </div>
  </div>
</form>

    <!-- footer part start-->
    <jsp:include page="footer.jsp"></jsp:include>
    <!-- footer part end-->

    <!-- jquery plugins here-->
    <script src="js/jquery-1.12.1.min.js"></script>
    <!-- popper js -->
    <script src="js/popper.min.js"></script>
    <!-- bootstrap js -->
    <script src="js/bootstrap.min.js"></script>
    <!-- magnific js -->
    <script src="js/jquery.magnific-popup.js"></script>
    <!-- swiper js -->
    <script src="js/owl.carousel.min.js"></script>
    <!-- masonry js -->
    <script src="js/masonry.pkgd.js"></script>
    <!-- masonry js -->
    <script src="js/jquery.nice-select.min.js"></script>
    <script src="js/gijgo.min.js"></script>
    <!-- contact js -->
    <script src="js/jquery.ajaxchimp.min.js"></script>
    <script src="js/jquery.form.js"></script>
    <script src="js/jquery.validate.min.js"></script>
    <script src="js/mail-script.js"></script>
    <script src="js/contact.js"></script>
    <!-- custom js -->
    <script src="js/custom.js"></script>
</body>

</html>