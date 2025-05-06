<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="true" %>
<%
    // 에러 메시지 담을 변수
    String errorMessage = null;

    // 폼이 POST로 제출됐을 때만 로그인 처리
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String id       = request.getParameter("id");
        String password = request.getParameter("password");

        // TODO: 실제 로그인 로직 구현 (예: Lambda/API Gateway 호출, DB 조회 등)
        boolean loginSuccess = false;
        // 예시: 하드코딩 검증 (반드시 본인 로직으로 교체)
        if ("testuser".equals(id) && "testpass".equals(password)) {
            loginSuccess = true;
        }

        if (loginSuccess) {
            // 세션에 로그인 정보 저장
            session.setAttribute("sessionLogin", id);
            // 리다이렉트해서 세션이 유지된 메인 페이지로 이동
            response.sendRedirect("index.jsp");
            return;
        } else {
            errorMessage = "아이디 또는 비밀번호가 올바르지 않습니다.";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Dr.Plan - 로그인</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
        crossorigin="anonymous">
</head>
<body class="bg-light">
  <div class="container mt-5" style="max-width: 400px;">
    <h2 class="mb-4 text-center">로그인</h2>
    <% if (errorMessage != null) { %>
      <div class="alert alert-danger"><%= errorMessage %></div>
    <% } %>
    <form action="PatientLogin.jsp" method="post">
      <div class="mb-3">
        <label for="id" class="form-label">아이디</label>
        <input type="text" name="id" id="id" class="form-control" required
               value="<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>">
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">비밀번호</label>
        <input type="password" name="password" id="password" class="form-control" required>
      </div>
      <button type="submit" class="btn btn-primary w-100">로그인</button>
    </form>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
          crossorigin="anonymous"></script>
</body>
</html>

