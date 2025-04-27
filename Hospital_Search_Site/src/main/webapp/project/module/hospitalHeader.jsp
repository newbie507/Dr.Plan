<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="PageControl.jsp?hosAction=search" style="margin-right: 40px"><img src="img/logo.png" class="img-responsive" alt="로고" width="100px" height="80px"></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <!-- <li class="nav-item ml">
          <a class="nav-link" href="Introduction.jsp"><h5><strong>서비스 소개</strong></h5></a>
        </li> -->
        <li class="nav-item">
          <a class="nav-link" href="#"><h5><strong>이용안내</strong></h5></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="PageControl.jsp?hosAction=search"><h5><strong>예약현황</strong></h5></a>
        </li>
      </ul>
       <ul class="nav navbar-nav ml-auto mb-2 mb-lg-0">
        <li class="nav-item dropdown" style="margin-right: 80px">
          <a href="#" class="nav-link dropdown-toggle" role="button" data-bs-toggle="dropdown" style="font-size: 20px; font-weight: 550;"> 
              <i class="fa-solid fa-circle-user"></i> <%= name %>
          </a>
          <ul class="dropdown-menu">
                <li><a href="module/logoutProcess.jsp" class="dropdown-item"><i class="fa-solid fa-right-from-bracket"></i> 로그아웃</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>
<div class="box1" style="background-color: rgb(52,152,219);"></div>
</body>
</html>