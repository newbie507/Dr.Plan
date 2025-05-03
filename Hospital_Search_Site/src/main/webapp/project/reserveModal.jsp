<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    System.out.println("[INFO] Dr.Plan 예약 모달 페이지 호출됨 - " + new java.util.Date());
%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <input type="hidden" id="namehospital" value="병원이름">
        <h5 class="modal-title" id="exampleModalLabel">병원이름</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body">
        <div class="container">
          <input type="hidden" id="idpatient" value="<%= session.getAttribute("memId") %>">

          <h5>예약날짜</h5>
          <div class="input-group date">
            <input type="date" id="reservedate" class="form-control">
          </div>

          <table class="table table-striped mt-3">
            <tbody>
              <tr>
                <td>병원 선택<span>*</span></td>
                <td>
                  <select id="select-hospital" class="form-control">
                    <option value="">병원 선택</option>
                  </select>
                </td>
              </tr>
              <tr>
                <td>예약자 이름<span>*</span></td>
                <td>
                  <input type="text" id="namepatient" class="form-control" value="<%= session.getAttribute("memName") != null ? session.getAttribute("memName") : "" %>">
                </td>
              </tr>
              <tr>
                <td>진료과<span>*</span>
                  <select id="department" class="form-control">
                    <option value="">진료과목 선택</option>
                    <option value="내과">내과</option>
                    <option value="정형외과">정형외과</option>
                    <option value="소아과">소아과</option>
                    <option value="이비인후과">이비인후과</option>
                    <option value="피부과">피부과</option>
                    <option value="안과">안과</option>
                    <option value="치과">치과</option>
                  </select>
                </td>
                <td>예약구분<span>*</span>
                  <select id="reservediv" class="form-control">
                    <option value="">예약 선택</option>
                    <option value="진료">진료</option>
                    <option value="검진">검진</option>
                  </select>
                </td>
              </tr>
              <tr>
                <td>주민번호 뒷자리<span>*</span></td>
                <td>
                  생년월일:
                  <select id="birth_1">
                    <option value="">년도</option>
                    <% for(int y=2025; y>=1930; y--) { %>
                      <option value="<%= y %>"><%= y %></option>
                    <% } %>
                  </select>
                  <select id="birth_2">
                    <option value="">월</option>
                    <% for(int m=1; m<=12; m++) { %>
                      <option value="<%= String.format("%02d", m) %>"><%= m %></option>
                    <% } %>
                  </select>
                  <select id="birth_3">
                    <option value="">일</option>
                    <% for(int d=1; d<=31; d++) { %>
                      <option value="<%= String.format("%02d", d) %>"><%= d %></option>
                    <% } %>
                  </select>
                  <br/>-주민번호 뒷자리:
                  <input type="password" id="registrationBackNumber" size="7" maxlength="7">
                </td>
              </tr>
              <tr>
                <td>증상<span>*</span></td>
                <td>
                  <textarea id="symptom" class="form-control" style="height: 125px;"></textarea>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <div class="modal-footer">
        <button type="button" id="reservesubmitbtn" class="btn btn-primary btn-sm">예약</button>
      </div>
    </div>
  </div>
</div>

<!-- 예약 정보 전달 -->

<script>
function transParam(dutyName, dgidIdName, hpid) {
  $("#namehospital").val(dutyName);
  $("#exampleModalLabel").text(dutyName);
  $("#select-hospital").val(dutyName);
}
</script>

<!-- 예약 버튼 동작 -->
<script>
document.getElementById("reservesubmitbtn").onclick = function () {
  const userId = localStorage.getItem("userId");       // 로그인 시 저장된 ID
  const token = localStorage.getItem("accessToken");   // 로그인 시 저장된 토큰

  if (!userId || !token) {
    alert("로그인이 필요합니다.");
    return;
  }

  // ✅ 예약 시도 로그 (info)
  fetch("logToServer.jsp?type=info&message=" + encodeURIComponent(`[INFO] 예약 시도 - userId=${userId}`));

  const data = {
    accessToken: token,
    event: "reservation",
    id: userId,  // ✅ Lambda에서 요구하는 id 필드
    idpatient: document.getElementById("idpatient").value,
    reservedate: document.getElementById("reservedate").value,
    department: document.getElementById("department").value,
    reservediv: document.getElementById("reservediv").value,
    namepatient: document.getElementById("namepatient").value,
    namehospital: document.getElementById("select-hospital").value,
    birth_1: parseInt(document.getElementById("birth_1").value),
    birth_2: parseInt(document.getElementById("birth_2").value),
    birth_3: parseInt(document.getElementById("birth_3").value),
    registrationBackNumber: document.getElementById("registrationBackNumber").value,
    symptom: document.getElementById("symptom").value
  };

  fetch("https://i0i241i959.execute-api.ap-northeast-2.amazonaws.com/reserve", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "Authorization": `Bearer ${token}`  // ✅ Lambda에서 인증 확인 가능
    },
    body: JSON.stringify(data)
  })
  .then(res => res.json())
  .then(response => {
    if (response.success) {

      // ✅ 예약 성공 로그 (info)
      fetch("logToServer.jsp?type=info&message=" + encodeURIComponent(`[INFO] 예약 성공 - userId=${userId}`));

      alert("예약 성공!");

      console.log("📡 S3 저장 호출 URL:", "https://xawofkopd0.execute-api.ap-northeast-2.amazonaws.com/S3/s3");
      console.log("📦 전송 데이터:", data);

      fetch("https://8m7rc9jsjg.execute-api.ap-northeast-2.amazonaws.com/prod/log", {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify(data)
      })
      .then(res => res.json())
      .then(s3res => {
        console.log("🪣 S3 저장 결과:", s3res);
      })
      .catch(s3err => {
        console.error("S3 저장 실패:", s3err);
      });

      location.reload();
    } else {

      // ✅ 예약 실패 로그 (warn)
      fetch("logToServer.jsp?type=warn&message=" + encodeURIComponent(`[WARN] 예약 실패 - userId=${userId}, 사유=${response.message}`));

      alert("예약 실패: " + response.message);
    }
  })
  .catch(err => {

    // ✅ 예약 에러 로그 (error)
    fetch("logToServer.jsp?type=error&message=" + encodeURIComponent(`[ERROR] 예약 요청 중 에러 발생 - userId=${userId}, 에러=${err}`));

    console.error("예약 오류:", err);
    alert("예약 중 문제가 발생했습니다.");
  });
};
</script>
