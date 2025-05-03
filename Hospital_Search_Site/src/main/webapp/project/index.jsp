<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="./css/custom.css">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <script src="https://kit.fontawesome.com/7f5811a0ff.js" crossorigin="anonymous"></script>
  <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ab2bc5c24540617e4235c668b239cd7e&libraries=services"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>

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
          <!-- 병원 정보 삽입 -->
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

<script>
  function transParam(dutyName, dgidIdName, hpid) {
    $("#namehospital").val(dutyName);
    $("#exampleModalLabel").text(dutyName);
    $("#select-hospital").val(dutyName);
  }

  const mapContainer = document.getElementById('map');
  const map = new kakao.maps.Map(mapContainer, {
    center: new kakao.maps.LatLng(37.5665, 126.9780),
    level: 5
  });

  let openedInfowindow = null;
  let allHospitals = []; // 전체 병원 리스트 저장
  let markers = []; // 전체 마커 저장

  const userId = localStorage.getItem("userId");
  const accessToken = localStorage.getItem("accessToken");
  const sessionLogin = "<%= memLogin %>";

  console.log("👤 로그인 사용자:", userId);
  console.log("🔑 토큰 존재 여부:", !!accessToken);
  console.log("🧾 memLogin (세션):", sessionLogin);

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
    console.log("✅ 받아온 병원 데이터:", data);
    fetch("logToServer.jsp?event=HospitalListFetchSuccess&id=" + encodeURIComponent(userId || "unknown"));

    allHospitals = data; // 전체 병원 저장

    data.forEach(item => {
      const lat = item.lat;
      const lng = item.lng;

      if (lat && lng) {
        const nameRaw = item.yadmNm || item.name || '';
        const addressRaw = item.addr || item.address || '';

        const name = nameRaw.trim() || '병원명 없음';
        const address = addressRaw.trim() || '주소 없음';

        const safeName = name.replace(/</g, "&lt;").replace(/>/g, "&gt;");
        const safeAddress = address.replace(/</g, "&lt;").replace(/>/g, "&gt;");

        const position = new kakao.maps.LatLng(lat, lng);
        const marker = new kakao.maps.Marker({
          position: position,
          map: map,
          title: safeName
        });

        const infowindow = new kakao.maps.InfoWindow({
        content: '<div style="padding:10px;font-size:14px;font-weight:bold;word-break:break-word;">'
                + safeName + '<br>' + safeAddress + '</div>'
        });

        kakao.maps.event.addListener(marker, 'click', function() {
          if (openedInfowindow) openedInfowindow.close();
          infowindow.open(map, marker);
          openedInfowindow = infowindow;
          map.panTo(marker.getPosition());
        });

        markers.push({ marker, item }); // ✅ 마커와 병원 매칭 저장
      }
    });

    updateHospitalList(); // ✅ 최초 호출
  })
  .catch(err => {
    console.error("병원 정보 로딩 실패", err);
    fetch("logToServer.jsp?event=HospitalListFetchFailed&id=" + encodeURIComponent(userId || "unknown"));
  });

  // ✅ 지도 이동/줌할 때 현재 범위 안에 있는 병원만 보여줌
  function updateHospitalList() {
    const bounds = map.getBounds();
    const tableBody = document.getElementById('hospital-table-body');
    tableBody.innerHTML = '';

    const visibleMarkers = markers.filter(obj => bounds.contain(obj.marker.getPosition()));

    console.log("🗺️ 현재 지도 안 마커 수:", visibleMarkers.length);

    visibleMarkers.forEach((obj, idx) => {
      const item = obj.item;
      const name = item.yadmNm || item.name || '병원명 없음';
      const phone = item.phone || item.telno || '-';

      const row = document.createElement('tr');

      const noTd = document.createElement('td');
      noTd.textContent = idx + 1;

      const nameTd = document.createElement('td');
      nameTd.textContent = name;

      const phoneTd = document.createElement('td');
      phoneTd.textContent = phone;

      const statusTd = document.createElement('td');
      statusTd.innerHTML = `<span class="badge bg-success">가능</span>`;

      const reserveTd = document.createElement('td');
      const reserveButton = document.createElement('button');
      reserveButton.className = 'btn btn-primary btn-sm';
      reserveButton.textContent = '예약';
      reserveButton.setAttribute('data-bs-toggle', 'modal');
      reserveButton.setAttribute('data-bs-target', '#exampleModal');
      reserveButton.onclick = function() {
        transParam(name, '-', item.hpid || '알수없음');
      };

      reserveTd.appendChild(reserveButton);

      row.appendChild(noTd);
      row.appendChild(nameTd);
      row.appendChild(phoneTd);
      row.appendChild(statusTd);
      row.appendChild(reserveTd);

      tableBody.appendChild(row);
    });
  }

  function updateSelectHospitalOptions() {
    const selectHospital = document.getElementById('select-hospital');
    if (!selectHospital) return;

    selectHospital.innerHTML = '<option value="">병원 선택</option>';

    const bounds = map.getBounds();
    const visibleMarkers = markers.filter(obj => bounds.contain(obj.marker.getPosition()));

    visibleMarkers.forEach(obj => {
      const item = obj.item;
      const name = item.yadmNm || item.name || '병원명 없음';

      const option = document.createElement('option');
      option.value = name;
      option.textContent = name;
      selectHospital.appendChild(option);
    });

    console.log("📋 select-hospital 옵션 갱신 완료:", selectHospital.options.length, "개");
  }

  kakao.maps.event.addListener(map, 'idle', function() {
    console.log("📍 지도 이동 또는 줌 이벤트 발생");
    updateHospitalList();
  });

  const exampleModal = document.getElementById('exampleModal');
  exampleModal.addEventListener('show.bs.modal', function (event) {
    console.log("✨ 모달 열릴 때 병원 목록 새로고침");
    updateSelectHospitalOptions();
  });

  window.onload = function() {
    console.log("🌐 로그인 상태 최종 확인:", userId, accessToken);
  };


</script>

</body>
</html>
