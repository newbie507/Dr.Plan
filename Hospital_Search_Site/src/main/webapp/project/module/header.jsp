<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="main.jsp" style="margin-right: 40px">
      <img src="img/logo.png" class="img-responsive" alt="로고" width="80px" height="80px">
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
            aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <!-- <li class="nav-item">
          <a class="nav-link" href="Introduction.jsp">
            <span class="nav-label">서비스 소개</span>
          </a>
        </li> -->
        <li class="nav-item">
          <a class="nav-link" href="Guide.jsp">
            <span class="nav-label">이용안내</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="index.jsp">
            <span class="nav-label">예약</span>
          </a>
        </li>
      </ul>
      <ul class="navbar-nav ml-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="PatientLogin.jsp">
            <span class="nav-label">로그인</span>
          </a>
        </li>
        <li class="nav-item" style="margin-right: 80px">
          <a class="nav-link" href="PatientSignUp.jsp">
            <span class="nav-label">회원가입</span>
          </a>
        </li>
      </ul>
    </div>
  </div>
</nav>
<div class="box1"></div>
</body>
</html>
