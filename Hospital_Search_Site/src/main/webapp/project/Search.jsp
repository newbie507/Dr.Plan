<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Dr.Plan - 병원 검색</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <!-- 외부 리소스 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link rel="stylesheet" href="./css/custom.css">
  <script src="https://kit.fontawesome.com/7f5811a0ff.js" crossorigin="anonymous"></script>
  <script async defer src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ab2bc5c24540617e4235c668b239cd7e&libraries=services"></script>
</head>

<body>
<jsp:include page="module/header.jsp" flush="false" />

<!-- 검색 바 -->
<div class="container my-4">
  <form class="row" id="searchBar" onsubmit="return false;">
    <div class="col-md-3 py-2">
      <input type="radio" name="search" value="hosname" checked> 병원명
      <input type="radio" name="search" value="department"> 진료과
    </div>
    <div class="col-md-6 py-2">
      <input type="text" name="keyword" class="form-control" placeholder="검색어 입력">
    </div>
    <div class="col-md-3 py-2">
      <button class="btn btn-primary w-100" type="button" onclick="clickBtn()">검색</button>
    </div>
  </form>
</div>

<!-- 병원 리스트 + 지도 -->
<div class="container py-3">
  <div class="row">
    <!-- 병원 리스트 -->
    <div class="col-md-6" style="overflow-y: scroll; height: 500px;">
      <table class="table table-hover">
        <thead>
          <tr>
            <th>#</th><th>병원명</th><th>전화번호</th><th>진료과</th><th>예약</th>
          </tr>
        </thead>
        <tbody id="hospitalTable"></tbody>
      </table>
    </div>

    <!-- 지도 -->
    <div class="col-md-6">
      <div id="map" style="width:100%;height:500px;"></div>
    </div>
  </div>
</div>

<!-- 예약 모달 -->
<jsp:include page="module/reserveModal.jsp" flush="false" />

<!-- 병원 목록 추가 테이블 (API 연동용) -->
<div class="container mt-5">
  <h3 class="mb-3">병원 목록 (API 연동)</h3>
  <table class="table table-bordered">
    <thead>
      <tr>
        <th>번호</th>
        <th>병원명</th>
        <th>전화번호</th>
        <th>진료과</th>
        <th>진료여부</th>
        <th>예약</th>
      </tr>
    </thead>
    <tbody id="hospital-table-body">
      <!-- 병원 정보가 여기에 삽입됩니다 -->
    </tbody>
  </table>
</div>

<script>
  // 병원 정보 받아오기 (Lambda API 연동)
  fetch("https://i0i241i959.execute-api.ap-northeast-2.amazonaws.com/prod/hospital-list")
    .then(res => res.json())
    .then(data => {
      const tableBody = document.getElementById('hospital-table-body');
      tableBody.innerHTML = '';
      data.forEach((item, index) => {
        const row = document.createElement('tr');
        row.innerHTML = `
          <td>${index + 1}</td>
          <td>${item.name}</td>
          <td>${item.phone || '-'}</td>
          <td>${item.department || '-'}</td>
          <td><span class="badge bg-success">가능</span></td>
          <td><button class="btn btn-primary btn-sm">예약</button></td>
        `;
        tableBody.appendChild(row);
      });
    })
    .catch(err => {
      console.error("병원 정보 로딩 실패", err);
    });
</script>

</body>
</html>


