<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Dr.Plan - 예약 관리</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <link rel="stylesheet" href="./css/custom.css">
</head>

<body>
  <!-- 헤더 영역 -->
  <jsp:include page="module/header.jsp" flush="false" />

  <div class="container my-4">
    <h2 class="mb-4">📝 예약 등록</h2>
    <div class="row g-2 mb-3">
      <div class="col-md-3">
        <input type="text" class="form-control" id="patientName" placeholder="환자 이름">
      </div>
      <div class="col-md-3">
        <input type="text" class="form-control" id="hospitalName" placeholder="병원 이름">
      </div>
      <div class="col-md-3">
        <input type="date" class="form-control" id="reserveDate">
      </div>
      <div class="col-md-2">
        <input type="time" class="form-control" id="reserveTime">
      </div>
      <div class="col-md-1">
        <button class="btn btn-primary w-100" onclick="registerReservation()">등록</button>
      </div>
    </div>

    <h2 class="mt-5">📋 예약 목록</h2>
    <table class="table table-hover">
      <thead class="table-light">
        <tr>
          <th>#</th>
          <th>예약 날짜</th>
          <th>환자 이름</th>
          <th>병원명</th>
          <th>예약 시간</th>
          <th>삭제</th>
        </tr>
      </thead>
      <tbody id="reservationTable">
        <!-- JavaScript로 채워짐 -->
      </tbody>
    </table>
  </div>

  <script>
    const API_BASE = "https://i0i241i959.execute-api.ap-northeast-2.amazonaws.com/reserve";

    function registerReservation() {
      const payload = {
        patientName: document.getElementById("patientName").value,
        hospitalName: document.getElementById("hospitalName").value,
        reserveDate: document.getElementById("reserveDate").value,
        reserveTime: document.getElementById("reserveTime").value
      };

      fetch(`${API_BASE}/reservations`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload)
      })
      .then(res => {
        if (!res.ok) throw new Error("예약 실패");
        alert("예약이 완료되었습니다.");
        loadReservations();
      })
      .catch(err => alert("에러: " + err.message));
    }

    function loadReservations() {
      fetch(`${API_BASE}/reservations?hospitalId=123`)
        .then(res => res.json())
        .then(data => {
          const table = document.getElementById("reservationTable");
          table.innerHTML = "";

          data.forEach((item, idx) => {
            const row = document.createElement("tr");
            row.innerHTML = `
              <td>${idx + 1}</td>
              <td>${item.reserveDate}</td>
              <td>${item.patientName}</td>
              <td>${item.hospitalName}</td>
              <td>${item.reserveTime}</td>
              <td><button class="btn btn-danger btn-sm" onclick="deleteReservation('${item.id}')">삭제</button></td>
            `;
            table.appendChild(row);
          });
        })
        .catch(err => console.error("조회 에러:", err));
    }

    function deleteReservation(reservationId) {
      if (!confirm("정말 삭제하시겠습니까?")) return;

      fetch(`${API_BASE}/reservations/${reservationId}`, {
        method: "DELETE"
      })
      .then(res => {
        if (!res.ok) throw new Error("삭제 실패");
        alert("삭제되었습니다.");
        loadReservations();
      })
      .catch(err => alert("삭제 중 에러 발생: " + err.message));
    }

    // 페이지 로딩 시 예약 목록 자동 조회
    document.addEventListener("DOMContentLoaded", loadReservations);
  </script>

  <!-- Footer -->
  <jsp:include page="module/footer.jsp" flush="false" />
</body>
</html>
