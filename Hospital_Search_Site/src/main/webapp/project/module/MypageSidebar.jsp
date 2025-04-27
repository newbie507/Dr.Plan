<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String currentPage = request.getRequestURI();
%>

<div class="d-flex flex-column flex-shrink-0 p-3 bg-light col-auto" style="width:240px; height: auto;">
    <a href="#" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none">
        <span class="fs-4"><strong>마이페이지</strong></span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <a href="MyPage.jsp" class="nav-link <%= currentPage.contains("MyPage.jsp") ? "active text-white bg-primary" : "link-dark" %>">
                <svg class="bi me-2" width="16" height="16"><use xlink:href="#table"></use></svg>
                예약 확인
            </a>
        </li>
        <li>
            <a href="PassConfirm.jsp" class="nav-link <%= currentPage.contains("PassConfirm.jsp") ? "active text-white bg-primary" : "link-dark" %>">
                <svg class="bi me-2" width="16" height="16"><use xlink:href="#people-circle"></use></svg>
                개인정보 관리
            </a>
        </li>
    </ul>
    <hr>
</div>

