<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String memLogin = (String) session.getAttribute("memLogin");
    String name = (String) session.getAttribute("memId");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="index.jsp" style="margin-right: 40px">
      <img src="img/logo.png" class="img-responsive" alt="로고" width="100px" height="80px">
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
            aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <!-- 좌측 메뉴 -->
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

      <!-- 우측 드롭다운 메뉴 -->
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
        <li class="nav-item dropdown" style="margin-right: 80px">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
            <i class="fa-solid fa-circle-user"></i> <span class="nav-label"><%= name %></span>
          </a>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="MyPage.jsp">
              <i class="fa-solid fa-user"></i> 내 정보 보기
            </a></li>
            <li><a class="dropdown-item" href="module/logoutProcess.jsp">
              <i class="fa-solid fa-right-from-bracket"></i> 로그아웃
            </a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>

<div class="box1"></div>
</body>
</html>
