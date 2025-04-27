<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String memLogin = (String) session.getAttribute("memLogin");

    if ("ok".equals(memLogin)) { // 환자 로그인 상태
%>
    <jsp:include page="module/patientHeader.jsp" flush="false" />
<%
    } else if ("hos".equals(memLogin)) { // 병원 로그인 상태
%>
    <jsp:include page="module/hospitalHeader.jsp" flush="false" />
<%
    } else { // 비로그인 상태
%>
    <jsp:include page="module/header.jsp" flush="false" />
<%
    }
%>

<%
    System.out.println("[INFO] Dr.Plan 인덱스(병원 검색) 페이지 호출됨 - " + new java.util.Date());
%>

<!DOCTYPE html>
<html>
<head>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Dr.Plan</title>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
  <link rel="stylesheet" href="./css/custom.css">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://kit.fontawesome.com/7f5811a0ff.js" crossorigin="anonymous"></script>
  <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ab2bc5c24540617e4235c668b239cd7e&libraries=services"></script>
</head>

<body>
<!-- 검색 바 -->
  <div class="container mt-4">
    <form class="row" id="searchForm">
      <div class="col-md-9">
        <input type="text" id="searchInput" class="form-control" placeholder="병원명으로 검색해보세요 :)">
      </div>
      <div class="col-md-3">
        <button type="submit" class="btn btn-primary w-100">검색</button>
      </div>
    </form>
  </div>

<!-- 병원 목록 + 지도 -->
<div class="container mt-5 mb-5">
  <div class="row">
    <div class="col-md-6" style="max-height: 500px; overflow-y: scroll;">
      <h3 class="mb-3">병원 목록</h3>
      <table class="table table-bordered">
        <thead>
          <tr>
            <th>번호</th>
            <th>병원명</th>
            <th>전화번호</th>
            <th>진료여부</th>
            <th>예약</th>
          </tr>
        </thead>
        <tbody id="hospital-table-body">
          <!-- 병원 정보가 여기에 삽입됩니다 -->
        </tbody>
      </table>
    </div>

    <div class="col-md-6">
      <h3 class="mb-3">병원 지도</h3>
      <div id="map" style="width:100%; height:500px;"></div>
    </div>
  </div>
</div>

<jsp:include page="reserveModal.jsp" />

<!-- 지도 마커 및 테이블 처리 -->
<script>
  const mapContainer = document.getElementById('map');
  const map = new kakao.maps.Map(mapContainer, {
    center: new kakao.maps.LatLng(37.5665, 126.9780),
    level: 5
  });

  let openedInfowindow = null;
  const userId = localStorage.getItem("userId");
  const accessToken = localStorage.getItem("accessToken");

  const sessionLogin = "<%= memLogin %>";
  const isSessionLoggedIn = sessionLogin === "ok";

  console.log("👤 로그인 사용자:", userId);
  console.log("🔑 토큰 존재 여부:", !!accessToken);
  console.log("🧾 memLogin (세션):", sessionLogin);

  // 로그인 정보가 없으면 로그인 페이지로 리디렉션
  if (!accessToken || !userId) {
    console.warn("⚠️ 로그인 정보가 없습니다. 다시 로그인하세요.");
    window.location.href = "PatientLogin.jsp";
  } else {
    console.log("✅ 로그인 유지 중");
  }

  fetch("logToServer.jsp?event=HospitalListFetchAttempt&id=" + encodeURIComponent(userId || "unknown"));
  fetch("https://i0i241i959.execute-api.ap-northeast-2.amazonaws.com/prod/hospital-list")
  .then(res => res.json())
  .then(data => {
    console.log("✅   받아온 병원 데이터:", data)

    fetch("logToServer.jsp?event=HospitalListFetchSuccess&id=" + encodeURIComponent(userId || "unknown"));  // ✅ 성공 로그 추가

    const tableBody = document.getElementById('hospital-table-body');
    tableBody.innerHTML = '';

    const selectHospital = document.getElementById("select-hospital");
    if (selectHospital) {
      selectHospital.innerHTML = '<option value="">병원 선택</option>'; // 기존 옵션 초기화
    }

    data.forEach((item, index) => {
      const nameRaw = item.yadmNm || item.name || '';
      const addressRaw = item.addr || item.address || '';
      const name = nameRaw.trim() || '병원명 없음';
      const address = addressRaw.trim() || '주소 없음';
      const nameSafe = (name || '병원명 없음').replace(/</g, "&lt;").replace(/>/g, "&gt;");
      const addressSafe = (address || '주소 없음').replace(/</g, "&lt;").replace(/>/g, "&gt;");
      const phone = item.phone || item.telno || '-';
      const department = item.department || item.dgsbjtCd || '-';
      const lat = item.lat;
      const lng = item.lng;

      // 병원 목록 렌더링
      const row = document.createElement('tr');

      const noCell = document.createElement('td');
      noCell.textContent = index + 1;

      const nameCell = document.createElement('td');
      nameCell.textContent = name;

      const phoneCell = document.createElement('td');
      phoneCell.textContent = phone;

      const statusCell = document.createElement('td');
      statusCell.innerHTML = `<span class="badge bg-success">가능</span>`;

      const reserveCell = document.createElement('td');
        reserveCell.innerHTML = `
          <button class="btn btn-primary btn-sm" 
            data-bs-toggle="modal" 
            data-bs-target="#exampleModal"
            onclick="transParam('${nameSafe}', '-', '${item.hpid || '알수없음'}')">
            예약
          </button>`;

          row.appendChild(noCell);
          row.appendChild(nameCell);
          row.appendChild(phoneCell);
          row.appendChild(statusCell);
          row.appendChild(reserveCell);

          tableBody.appendChild(row);

      // 병원 select 옵션 추가
      if (selectHospital) {
        const option = document.createElement("option");
        option.value = nameSafe;
        option.textContent = nameSafe;
        selectHospital.appendChild(option);
      }

      // 지도 마커 + 인포윈도우
      if (lat && lng) {
        const marker = new kakao.maps.Marker({
          map: map,
          position: new kakao.maps.LatLng(lat, lng),
          title: nameSafe
        });

        const infowindow = new kakao.maps.InfoWindow({
          content: '<div style="padding:10px;font-size:14px;font-weight:bold;font-family:Arial,Helvetica,sans-serif;color:#000;background-color:#fff;border:2px solid #333;border-radius:5px;max-width:250px;word-break:break-word;line-height:1.5;display:block;">'
          + '<strong>' + nameSafe + '</strong><br>' + addressSafe + '</div>'
        });

        kakao.maps.event.addListener(marker, 'click', function () {
          if (openedInfowindow) openedInfowindow.close();
          infowindow.open(map, marker);
          openedInfowindow = infowindow;
        });
      }
    });
  })
  .catch(err => {
    console.error("병원 정보 로딩 실패", err);

    fetch("logToServer.jsp?event=HospitalListFetchFailed&id=" + encodeURIComponent(userId || "unknown"));  // ✅ 실패 로그 추가
  });
</script>

<script>
  window.onload = function () {
    const userId = localStorage.getItem("userId");
    const accessToken = localStorage.getItem("accessToken");

    console.log("🌐 로그인 상태 확인 (onload):");
    console.log("🧑‍💻 userId:", userId);
    console.log("🔐 accessToken:", accessToken);

    if (!accessToken || !userId) {
      console.warn("⚠️ 로그인 정보가 없습니다. 다시 로그인하세요.");
    } else {
      console.log("✅ 로그인 유지 중");
    }
  };
</script>

<jsp:include page="reserveModal.jsp" />

</body>
</html>
