<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Dr.Plan 병원검색</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    .hospital-card {
      border: 1px solid #ccc;
      padding: 15px;
      border-radius: 5px;
      margin-bottom: 10px;
    }
  </style>
</head>
<body>
  <div class="container mt-4">
    <h2 class="mb-4">365 병원 목록 (반경 1km 이내)</h2>
    <div id="hospital-container">
      <!-- 병원 정보가 여기 채워집니다 -->
    </div>
  </div>

  <script>
    document.addEventListener("DOMContentLoaded", function () {
      fetch("https://i0i241i959.execute-api.ap-northeast-2.amazonaws.com/prod/hospital-list")
        .then(response => {
          if (!response.ok) throw new Error("API 호출 실패");
          return response.json();
        })
        .then(data => {
          const container = document.getElementById("hospital-container");
          container.innerHTML = "";

          data.forEach((hospital, index) => {
            const div = document.createElement("div");
            div.className = "hospital-card";
            div.innerHTML = `
              <h4>${hospital.name}</h4>
              <p><strong>전화번호:</strong> ${hospital.phone || "-"}</p>
              <p><strong>진료과:</strong> ${hospital.department || "-"}</p>
              <p><strong>기관 ID:</strong> ${hospital.hpid}</p>
            `;
            container.appendChild(div);
          });
          
        })
        .catch(error => {
          console.error("에러:", error);
          alert("병원 데이터를 불러오는 데 실패했습니다.");
        });
    });
  </script>
</body>
</html>
