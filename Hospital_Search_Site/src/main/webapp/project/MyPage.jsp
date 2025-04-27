<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>마이페이지 - 예약 내역</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="./css/custom.css">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://kit.fontawesome.com/7f5811a0ff.js" crossorigin="anonymous"></script>
</head>
<body>

<%
  String memLogin = (String)session.getAttribute("memLogin");
  String memId = (String)session.getAttribute("memId");

  if (!"ok".equals(memLogin) || memId == null || memId.isEmpty()) {
    response.sendRedirect("PatientLogin.jsp");
    return;
  }
%>

<!-- Header 분기 -->
<%
  if ("ok".equals(memLogin)) {
%>
  <jsp:include page="module/patientHeader.jsp" flush="false" />
<%
  } else {
%>
  <jsp:include page="module/header.jsp" flush="false" />
<%
  }
%>

<div class="container-fluid">
  <div class="row justify-content-start">
    <jsp:include page="module/MypageSidebar.jsp" flush="false" />
    <div class="col-md-9" style="padding-top: 100px; white-space: nowrap;">
      <section class="container" style="max-width: 760px; padding-top: 20px;">
        <div class="row align-items-center justify-content-between">
          <a class="navbar-brand h1 text-left">
            <span class="text-dark h3">나의 예약</span> <span class="text-primary h3">내역</span>
          </a>
        </div>
        <div class="mt-4">
          <table class="table table-hover">
            <thead>
              <tr>
                <th>#</th>
                <th>예약일</th>
                <th>병원명</th>
                <th>진료과</th>
                <th>취소</th>
              </tr>
            </thead>
            <tbody id="reservationTableBody">
              <!-- JS로 채워짐 -->
            </tbody>
          </table>
        </div>
      </section>
    </div>
  </div>
</div>

<jsp:include page="module/footer.jsp" flush="false" />

<!-- JavaScript -->
<script>
  var patientId = '<%= (memId != null) ? memId : "no-user" %>';
  var API_BASE = "https://i0i241i959.execute-api.ap-northeast-2.amazonaws.com/reserve";
  
  // 예약 목록 불러오기
  function loadReservations() {
    if (!patientId || patientId === "no-user") {
      alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
      location.href = "/PatientLogin.jsp"; 
      return;
    }
  
    console.log("✅ API 호출 URL: " + API_BASE + "?patientId=" + patientId);
  
    fetch(API_BASE + "?patientId=" + patientId)
      .then(function(res) {
        if (!res.ok) {
          return res.text().then(function(text) {
            throw new Error("서버 응답 에러(" + res.status + "): " + text);
          });
        }
        return res.json();
      })
      .then(function(data) {
        var tbody = document.getElementById("reservationTableBody");
        tbody.innerHTML = "";
  
        if (!Array.isArray(data) || data.length === 0) {
          tbody.innerHTML = '<tr><td colspan="5" class="text-center text-muted">예약 내역이 없습니다.</td></tr>';
          return;
        }
  
        for (var i = 0; i < data.length; i++) {
          var item = data[i];
          tbody.innerHTML +=
            '<tr>' +
            '<th scope="row">' + (i + 1) + '</th>' +
            '<td>' + (item.reserveDate || "정보 없음") + '</td>' +
            '<td>' + (item.namehospital || "정보 없음") + '</td>' +
            '<td>' + (item.department || "정보 없음") + '</td>' +
            '<td>' +
              '<button class="btn btn-danger btn-sm" onclick="cancelReservation(\'' + item.reserveID + '\')">취소</button>' +
            '</td>' +
            '</tr>';
        }
      })
      .catch(function(err) {
        console.error("❌ 에러:", err);
        alert("예약 내역을 불러오는 데 실패했습니다:\n" + err.message);
      });
  }
  
  // 예약 취소 요청
  function cancelReservation(reservationId) {
    if (!confirm("정말 예약을 취소하시겠습니까?")) return;
  
    fetch(API_BASE + "?reserveId=" + reservationId, {
      method: "DELETE"
    })
    .then(function(res) {
      if (!res.ok) {
        return res.text().then(function(errText) {
          throw new Error("삭제 실패(" + res.status + "): " + errText);
        });
      }
      alert("예약이 취소되었습니다.");
      loadReservations();
    })
    .catch(function(err) {
      console.error(err);
      alert("예약 취소 중 오류가 발생했습니다:\n" + err.message);
    });
  }
  
  // 초기 로딩 시 실행
  document.addEventListener("DOMContentLoaded", loadReservations);
  </script>
  
</body>
</html>