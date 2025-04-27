<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    session.removeAttribute("memLogin");
%>
<script>
  // ✅ localStorage에 저장된 Cognito 토큰 제거
  localStorage.removeItem("accessToken");
  localStorage.removeItem("refreshToken");
  localStorage.removeItem("idToken");

  alert("로그아웃 되었습니다.");
  location.href = "../index.jsp";
</script>
