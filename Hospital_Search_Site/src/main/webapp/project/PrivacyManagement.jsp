<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="jsp.member.model.*, java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Enumeration"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="pudData" scope="request" class="jsp.member.model.patientuserDTO" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 스크립트 부분 -->
<script
src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
crossorigin="anonymous"></script>
<link rel="stylesheet" href="./css/custom.css">
<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"crossorigin="anonymous">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://kit.fontawesome.com/7f5811a0ff.js"
crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="css/MyPageStyles.css">

<title>마이페이지</title>
</head>
<body>
	<%
			System.out.println(pudData.getAddress());
  			String memLogin = null; // 로그인 여부에 따라 탑메뉴 보여주는 로직
  			memLogin = (String)session.getAttribute("memLogin");
  			if(memLogin == "ok"){ // 환자회원 헤더
  				%>
  				 <jsp:include page="module/patientHeader.jsp" flush="false" />
  				<%
  			}
  			else if(memLogin == "hos"){ // 병원회원 헤더
  				%>
 				 <jsp:include page="module/hospitalHeader.jsp" flush="false" />
 				<%
  			} else{ // 로그인 안했을때 헤더
  				%>
				 <jsp:include page="module/header.jsp" flush="false" />
				<%
  			}
  			
  	%>
  	<div class="container-fluid">
  	  <div class="row justify-content-start">
			  <jsp:include page="module/MypageSidebar.jsp" flush="false" />
		  	  <div class="col-md-9" style="white-space:nowrap;height:600px;padding-top: 50px">
			  	  <section class="container" style="max-width: 560px; padding-top: 20px; height: 70%;">
				    <div class="row align-items-center justify-content-between">
				            <a class="navbar-brand h1 text-left">	
				                <span class="text-dark h3">개인정보</span> <span class="text-primary h3">관리</span>
				            </a>
				    </div>
					<form style="padding-top: 20px; font-size: 17px;">
					  <div class="form-group row">
					    <label for="staticId" class="col-sm-2 col-form-label">아이디</label>
					    <div class="col-sm-10">
					      <input type="text" readonly class="form-control-plaintext" id="staticId" name="Id" value= "<%= pudData.getId() %>">
					    </div>
					  </div>
					  <div class="form-group row" style="padding-top: 5px;">
					    <label for="staticName" class="col-sm-2 col-form-label">이름</label>
					    <div class="col-sm-10">
					      <input type="text" readonly class="form-control-plaintext" id="staticName" name="name" value= "<%= pudData.getName() %>">
					    </div>
					  </div>
					  <div class="form-group row" style="padding-top: 5px;">
					    <label for="staticBirthdate" class="col-sm-2 col-form-label">생년월일</label>
					    <div class="col-sm-10">
					      <input type="text" readonly class="form-control-plaintext" id="staticBirthdate" name="birthdate" value= "<%= pudData.getBirthdate() %>">
					    </div>
					  </div>
					  <div class="form-group row" style="padding-top: 5px;">
					    <label for="staticSex" class="col-sm-2 col-form-label">성별</label>
					    <div class="col-sm-10">
					      <input type="text" readonly class="form-control-plaintext" id="staticSex" name="sex" value= "<%= pudData.getSex() %>">
					    </div>
					  </div>
					  <div class="form-group row" style="padding-top: 5px;">
					    <label for="staticAddress" class="col-sm-2 col-form-label">주소</label>
					    <div class="col-sm-10">
					      <input type="text" readonly class="form-control-plaintext" id="staticAddress" name="address" value= "<%= pudData.getAddress() %>">
					    </div>
					  </div>
					  <div class="form-group row" style="padding-top: 5px; padding-bottom: 30px;">
					    <label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
					    <div class="col-sm-10" id="passwordCheck">
					      <input type="password" class="form-control" id="inputPassword" placeholder="Password" name="password" value= "<%= pudData.getPassword() %>">
					      <i class="fa fa-eye fa-lg"></i>
					    </div>
					  </div>
					  <button class="w-100 btn btn-lg btn-primary" type="submit">수정</button>
				      <input type=hidden name="action" value="change">
					</form>
				  </section>
		  	  </div>
  		</div>
  	</div>
    
    <jsp:include page="module/footer.jsp" flush="false"/>	
    <!-- IONICONS -->
    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
	  <symbol id="facebook" viewBox="0 0 16 16">
	    <path
			d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951z" />
	  </symbol>
	  <symbol id="instagram" viewBox="0 0 16 16">
	      <path
			d="M8 0C5.829 0 5.556.01 4.703.048 3.85.088 3.269.222 2.76.42a3.917 3.917 0 0 0-1.417.923A3.927 3.927 0 0 0 .42 2.76C.222 3.268.087 3.85.048 4.7.01 5.555 0 5.827 0 8.001c0 2.172.01 2.444.048 3.297.04.852.174 1.433.372 1.942.205.526.478.972.923 1.417.444.445.89.719 1.416.923.51.198 1.09.333 1.942.372C5.555 15.99 5.827 16 8 16s2.444-.01 3.298-.048c.851-.04 1.434-.174 1.943-.372a3.916 3.916 0 0 0 1.416-.923c.445-.445.718-.891.923-1.417.197-.509.332-1.09.372-1.942C15.99 10.445 16 10.173 16 8s-.01-2.445-.048-3.299c-.04-.851-.175-1.433-.372-1.941a3.926 3.926 0 0 0-.923-1.417A3.911 3.911 0 0 0 13.24.42c-.51-.198-1.092-.333-1.943-.372C10.443.01 10.172 0 7.998 0h.003zm-.717 1.442h.718c2.136 0 2.389.007 3.232.046.78.035 1.204.166 1.486.275.373.145.64.319.92.599.28.28.453.546.598.92.11.281.24.705.275 1.485.039.843.047 1.096.047 3.231s-.008 2.389-.047 3.232c-.035.78-.166 1.203-.275 1.485a2.47 2.47 0 0 1-.599.919c-.28.28-.546.453-.92.598-.28.11-.704.24-1.485.276-.843.038-1.096.047-3.232.047s-2.39-.009-3.233-.047c-.78-.036-1.203-.166-1.485-.276a2.478 2.478 0 0 1-.92-.598 2.48 2.48 0 0 1-.6-.92c-.109-.281-.24-.705-.275-1.485-.038-.843-.046-1.096-.046-3.233 0-2.136.008-2.388.046-3.231.036-.78.166-1.204.276-1.486.145-.373.319-.64.599-.92.28-.28.546-.453.92-.598.282-.11.705-.24 1.485-.276.738-.034 1.024-.044 2.515-.045v.002zm4.988 1.328a.96.96 0 1 0 0 1.92.96.96 0 0 0 0-1.92zm-4.27 1.122a4.109 4.109 0 1 0 0 8.217 4.109 4.109 0 0 0 0-8.217zm0 1.441a2.667 2.667 0 1 1 0 5.334 2.667 2.667 0 0 1 0-5.334z" />
	  </symbol>
	  <symbol id="twitter" viewBox="0 0 16 16">
	    <path
			d="M5.026 15c6.038 0 9.341-5.003 9.341-9.334 0-.14 0-.282-.006-.422A6.685 6.685 0 0 0 16 3.542a6.658 6.658 0 0 1-1.889.518 3.301 3.301 0 0 0 1.447-1.817 6.533 6.533 0 0 1-2.087.793A3.286 3.286 0 0 0 7.875 6.03a9.325 9.325 0 0 1-6.767-3.429 3.289 3.289 0 0 0 1.018 4.382A3.323 3.323 0 0 1 .64 6.575v.045a3.288 3.288 0 0 0 2.632 3.218 3.203 3.203 0 0 1-.865.115 3.23 3.23 0 0 1-.614-.057 3.283 3.283 0 0 0 3.067 2.277A6.588 6.588 0 0 1 .78 13.58a6.32 6.32 0 0 1-.78-.045A9.344 9.344 0 0 0 5.026 15z" />
	  </symbol>
	  <symbol id="table" viewBox="0 0 16 16">
	    <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm15 2h-4v3h4V4zm0 4h-4v3h4V8zm0 4h-4v3h3a1 1 0 0 0 1-1v-2zm-5 3v-3H6v3h4zm-5 0v-3H1v2a1 1 0 0 0 1 1h3zm-4-4h4V8H1v3zm0-4h4V4H1v3zm5-3v3h4V4H6zm4 4H6v3h4V8z"></path>
	  </symbol>
	  <symbol id="people-circle" viewBox="0 0 16 16">
	    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"></path>
	    <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"></path>
	  </symbol>
	  <symbol id="grid" viewBox="0 0 16 16">
	    <path d="M1 2.5A1.5 1.5 0 0 1 2.5 1h3A1.5 1.5 0 0 1 7 2.5v3A1.5 1.5 0 0 1 5.5 7h-3A1.5 1.5 0 0 1 1 5.5v-3zM2.5 2a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 1h3A1.5 1.5 0 0 1 15 2.5v3A1.5 1.5 0 0 1 13.5 7h-3A1.5 1.5 0 0 1 9 5.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zM1 10.5A1.5 1.5 0 0 1 2.5 9h3A1.5 1.5 0 0 1 7 10.5v3A1.5 1.5 0 0 1 5.5 15h-3A1.5 1.5 0 0 1 1 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3zm6.5.5A1.5 1.5 0 0 1 10.5 9h3a1.5 1.5 0 0 1 1.5 1.5v3a1.5 1.5 0 0 1-1.5 1.5h-3A1.5 1.5 0 0 1 9 13.5v-3zm1.5-.5a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3z"></path>
	  </symbol>
	  <symbol id="collection" viewBox="0 0 16 16">
	    <path d="M2.5 3.5a.5.5 0 0 1 0-1h11a.5.5 0 0 1 0 1h-11zm2-2a.5.5 0 0 1 0-1h7a.5.5 0 0 1 0 1h-7zM0 13a1.5 1.5 0 0 0 1.5 1.5h13A1.5 1.5 0 0 0 16 13V6a1.5 1.5 0 0 0-1.5-1.5h-13A1.5 1.5 0 0 0 0 6v7zm1.5.5A.5.5 0 0 1 1 13V6a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5h-13z"></path>
	  </symbol>
	  <symbol id="calendar3" viewBox="0 0 16 16">
	    <path d="M14 0H2a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zM1 3.857C1 3.384 1.448 3 2 3h12c.552 0 1 .384 1 .857v10.286c0 .473-.448.857-1 .857H2c-.552 0-1-.384-1-.857V3.857z"></path>
	    <path d="M6.5 7a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm-9 3a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm-9 3a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"></path>
	  </symbol>
	</svg>
    <!-- JS -->
    <script type="text/javascript">
	$(document).ready(function(){
	    $('#passwordCheck i').on('click',function(){
	        $('#inputPassword').toggleClass('active');
	        if($('#inputPassword').hasClass('active')){
	            $(this).attr('class',"fa fa-eye-slash fa-lg")
	            .prev('#inputPassword').attr('type',"text");
	        }else{
	            $(this).attr('class',"fa fa-eye fa-lg")
	            .prev('#inputPassword').attr('type','password');
	        }
	    });
	});
	</script>
    <script src="js/main.js"></script>
</body>
</html>