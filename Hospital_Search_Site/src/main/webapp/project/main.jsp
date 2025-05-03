<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String memLogin = (String) session.getAttribute("memLogin");

    if ("ok".equals(memLogin)) {
%>
    <jsp:include page="module/patientHeader.jsp" flush="false" />
<%
    } else if ("hos".equals(memLogin)) {
%>
    <jsp:include page="module/hospitalHeader.jsp" flush="false" />
<%
    } else {
%>
    <jsp:include page="module/header.jsp" flush="false" />
<%
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Dr.Plan</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
        <style>
          html, body, h1, h4, h5, p, a, .card-title, .card-text {
            font-family: 'Gowun Dodum', sans-serif !important;
          }
          h3.fw-bold {
            font-size: 1.8rem;  /* 기존 대비 약 1.5배 */
          }

          p, .text-muted {
            font-size: 1.2rem;  /* 일반 문장 1.5배 */
            line-height: 1.8;
          }

          h4 {
            font-size: 1.4rem;
          }

          h1 {
            font-size: 2.2rem;
          }
        /* 확대 효과 */
        .zoom-section {
          transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .zoom-section:hover {
          transform: scale(1.2);
        }
        .btn-hover-zoom {
          transition: transform 0.3s ease;
        }

        .btn-hover-zoom:hover {
          transform: scale(1.3);
        }        
        </style>        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="./css/custom.css">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://kit.fontawesome.com/7f5811a0ff.js" crossorigin="anonymous"></script>
        <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ab2bc5c24540617e4235c668b239cd7e&libraries=services"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
      </head>
<body>

    <script>
        window.onload = function() {
          const userId = localStorage.getItem("userId");
          const accessToken = localStorage.getItem("accessToken");
          const sessionLogin = "<%= memLogin %>";
      
          console.log("🧾 세션 sessionLogin:", sessionLogin);
          console.log("👤 localStorage userId:", userId);
          console.log("🔑 localStorage accessToken:", accessToken);
      
          if (sessionLogin === "ok" && userId && accessToken) {
            console.log("✅ 로그인 유지 상태입니다:", userId);
            // 여기에 로그인된 사용자용 UI 표시하거나 추가 동작 넣을 수 있어
          } else {
            console.log("🆓 비로그인 상태로 메인 페이지 접근");
            // 비로그인 사용자도 그냥 접근 가능, 아무 동작 없음
          }
        }
      </script>

<!-- 예약하러 가기 Section -->
<div class="container py-5">
  <div class="row align-items-center">
    <!-- 왼쪽 텍스트 + 배경 이미지 영역 -->
    <div class="col-md-6 text-center" style="
      background-image: url('img/back1.png');
      background-size: contain;
      background-repeat: no-repeat;
      background-position: calc(50% - 40px) center;
      padding: 80px 20px;
      min-height: 450px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
    ">
      <h1 class="mb-3 fw-bold">쉽고 빠른 병원 예약, Dr.Plan</h1>
      <h4 class="mb-4">언제 어디서나 편리하게 예약하세요.</h4>
      <a class="btn btn-primary btn-hover-zoom" href="index.jsp" role="button">예약하러 가기</a>
    </div>

    <!-- 오른쪽 이미지 영역 -->
    <div class="col-md-6 text-center">
      <img src="img/main1.png" alt="Dr.Plan Main" class="img-fluid" style="max-width: 90%; height: auto; transform: translateX(30px);">
    </div>
  </div>
</div>

<!-- 병원 검색 Section -->
<div class="container py-5">
  <div class="row align-items-center zoom-section">
    <!-- 왼쪽 이미지 -->
    <div class="col-md-6 text-center">
      <img src="img/main2.png" alt="병원 검색" class="img-fluid" style="max-width: 90%; height: auto;">
    </div>

    <!-- 오른쪽 텍스트 -->
    <div class="col-md-6 text-center">
      <h3 class="fw-bold">병원 검색</h3>
      <p>전국의 병원을 손쉽게 검색하고, 지도 상에서 위치까지 한눈에 확인할 수 있습니다.</p>
      <p class="text-muted">
        진료 과목, 병원명, 지역 등을 기반으로 다양한 병원을 비교해볼 수 있어요.<br>
        현재 위치를 기준으로 가까운 병원도 자동으로 추천되며, 상세 정보도 함께 제공합니다.<br>
        초진뿐 아니라 재진 가능한 병원까지 한 번에 확인 가능하여 더욱 편리한 검색 경험을 제공합니다.<br>
        Dr.Plan은 여러분이 필요한 병원을 빠르게 찾을 수 있도록 도와드립니다.
        </p>
    </div>
  </div>
</div>

<!-- 진료 예약 Section -->
<div class="container py-5">
  <div class="row align-items-center zoom-section">
    <!-- 왼쪽 텍스트 -->
    <div class="col-md-6 text-center">
      <h3 class="fw-bold">진료 예약</h3>
      <p>원하는 병원과 진료 과목을 선택하여 온라인으로 간편하게 예약하세요.</p>
      <p class="text-muted">
      전화 예약 없이 클릭 몇 번으로 병원 진료 일정을 예약할 수 있습니다.<br>
      예약 가능 시간과 남은 인원 수까지 실시간으로 확인할 수 있어 계획을 세우기 쉬워요.<br>
      예약 내역은 마이페이지에서 바로 확인 가능하며, 수정 및 취소도 자유롭습니다.<br>
      Dr.Plan은 빠르고 정확한 진료 예약 경험을 제공합니다.
      </p>
    </div>

    <!-- 오른쪽 이미지 -->
    <div class="col-md-6 text-center">
      <img src="img/main3.png" alt="진료 예약" class="img-fluid" style="max-width: 90%; height: auto;">
    </div>
  </div>
</div>

<!-- 다음 진료 알림 Section -->
<div class="container py-5">
  <div class="row align-items-center zoom-section">
    <!-- 왼쪽 이미지 -->
    <div class="col-md-6 text-center">
      <img src="img/main4.png" alt="다음 진료 알림" class="img-fluid" style="max-width: 90%; height: auto;">
    </div>

    <!-- 오른쪽 텍스트 -->
    <div class="col-md-6 text-center">
      <h3 class="fw-bold">다음 진료 알림</h3>
      <p>예약일이 다가오면 자동으로 알림을 보내드려 중요한 진료를 놓치지 않도록 도와드립니다.</p>
      <p class="text-muted">
      예약 하루 전과 당일 아침에 문자 또는 앱 푸시로 진료 알림이 전송됩니다.<br>
      진료 일정 변경이나 병원 안내사항도 함께 받아볼 수 있어요.<br>
      재진이 필요한 경우, 6개월 뒤 자동 알림을 통해 편리하게 일정을 관리할 수 있습니다.<br>
      Dr.Plan은 꾸준한 건강관리를 위한 믿을 수 있는 진료 알림 파트너입니다.
      </p>
    </div>
  </div>
</div>

<!-- Footer -->
<footer class="text-center text-muted py-3">
  © 2025 Dr.Plan, Inc
</footer>

</body>
</html>
