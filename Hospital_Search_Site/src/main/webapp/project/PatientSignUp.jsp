<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인 회원가입</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./css/custom.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>

<jsp:include page="module/header.jsp" flush="false" />

<%
    System.out.println("[INFO] Dr.Plan 개인 회원가입 페이지 호출됨 - " + new java.util.Date());
%>

<section class="bg-light" style="min-height: 1000px;">
<div class="container py-4">
  <div class="row mb-3">
    <a class="navbar-brand col-md-3" href="PatientSignUp.jsp"><span class="text-dark" style="font-size: 18px;">개인 회원가입</span></a>
    <a class="navbar-brand col-md-3" href="OrganSignUp.jsp"><span class="text-dark" style="font-size: 18px;">병원 회원가입</span></a>
  </div>

  <form id="patientSignUp" method="post" onsubmit="return false;">
    <div class="mb-3">
      <label for="userId" class="form-label">E-mail</label>
      <div class="d-flex">
        <input type="email" class="form-control" id="userId" required>
        <button type="button" class="btn btn-outline-secondary" onclick="sendEmailVerification()">이메일 인증</button>
      </div>
    </div>
    <div class="mb-3">
      <label for="verifyCode" class="form-label">인증 코드</label>
      <div class="d-flex">
        <input type="text" class="form-control me-2" id="verifyCode" placeholder="인증 코드를 입력하세요">
        <button type="button" class="btn btn-outline-success" onclick="verifyEmailCode()">확인</button>
      </div>
    </div>
    <div class="mb-3">
      <label for="userPass" class="form-label">비밀번호</label>
      <input type="password" class="form-control" id="userPass" required>
    </div>
    <div class="mb-3">
      <label for="userRePass" class="form-label">비밀번호 재확인</label>
      <input type="password" class="form-control" id="userRePass" required>
    </div>
    <div class="mb-3">
      <label for="name" class="form-label">이름</label>
      <input type="text" class="form-control" id="name" required>
    </div>
    <div class="mb-3">
      <label>생년월일</label>
      <div class="d-flex">
        <input type="text" class="form-control me-1" id="yy" placeholder="년(4자)" maxlength="4" required>
        <input type="text" class="form-control me-1" id="mm" placeholder="월(2자)" maxlength="2" required>
        <input type="text" class="form-control" id="dd" placeholder="일(2자)" maxlength="2" required>
      </div>
    </div>
    <div class="mb-3">
      <label for="exampleSelect1" class="form-label">성별</label>
      <select class="form-select" id="exampleSelect1">
        <option>남자</option>
        <option>여자</option>
      </select>
    </div>
    <div class="mb-3">
      <label class="form-label">주소</label>
      <div class="row g-2 mb-2">
        <div class="col-md-4">
          <input type="text" class="form-control" id="sample6_postcode" placeholder="우편번호">
        </div>
        <div class="col-md-4">
          <input type="button" class="form-control" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
        </div>
      </div>
      <input type="text" class="form-control mb-1" id="sample6_address" placeholder="주소">
      <input type="text" class="form-control mb-1" id="sample6_detailAddress" placeholder="상세주소">
      <input type="text" class="form-control" id="sample6_extraAddress" placeholder="참고항목">
    </div>

    <div class="d-grid">
      <button type="button" id="submitBtn" class="btn btn-primary btn-lg" disabled onclick="submitUserRegistration()">가입하기</button>
    </div>
  </form>
</div>
</section>

<jsp:include page="module/footer.jsp" flush="false" />

<script>
function sample6_execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      var addr = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
      document.getElementById('sample6_postcode').value = data.zonecode;
      document.getElementById("sample6_address").value = addr;
      document.getElementById("sample6_extraAddress").value = data.buildingName || '';
      document.getElementById("sample6_detailAddress").focus();
    }
  }).open();
}

function sendEmailVerification() {
  const email = document.getElementById("userId").value;
  if (!email) {
    alert("이메일을 입력해주세요.");
    return;
  }

  fetch("logToServer.jsp?event=EmailVerificationRequested&email=" + encodeURIComponent(email));

  fetch("https://8e36s31r5f.execute-api.ap-northeast-2.amazonaws.com/prod/cognito-signup", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      email: email,
      action: "signup"  // ✅ 요걸 반드시 포함해야 Lambda가 회원가입으로 인식함
    })
  })
  .then(response => {
    if (!response.ok) throw new Error("이메일 전송 실패");
    return response.json();
  })
  .then(data => {
    alert("인증 이메일을 전송했습니다.");
  })
  .catch(error => {
    console.error("❌ 인증 오류:", error);
    alert("인증 이메일 전송에 실패했습니다.");
  });
}

function verifyEmailCode() {
  const email = document.getElementById("userId").value;
  const code = document.getElementById("verifyCode").value;

  if (!email || !code) {
    alert("이메일과 인증 코드를 모두 입력해주세요.");
    return;
  }

  fetch("logToServer.jsp?event=EmailCodeVerification&email=" + encodeURIComponent(email));

  fetch("https://8e36s31r5f.execute-api.ap-northeast-2.amazonaws.com/prod/cognito-signup", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      email: email,
      code: code,
      action: "confirm"
    })
  })
  .then(response => response.json())
  .then(data => {
    if (data.verified) {
      alert("이메일 인증 성공!");
      localStorage.setItem("emailVerified", "true");
      document.getElementById("submitBtn").disabled = false;
    } else {
      alert("인증 실패. 코드가 잘못되었거나 만료되었습니다.");
    }
  })
  .catch(error => {
    console.error("❌ 인증 확인 중 에러:", error);
    alert("서버 오류로 인증 확인에 실패했습니다.");
  });
}

function submitUserRegistration() {
  if (localStorage.getItem("emailVerified") !== "true") {
    alert("이메일 인증을 먼저 완료해주세요.");
    return;
  }

  const email = document.getElementById("userId").value;
  const password = document.getElementById("userPass").value;
  const rePassword = document.getElementById("userRePass").value;
  const name = document.getElementById("name").value;
  const yy = document.getElementById("yy").value;
  const mm = document.getElementById("mm").value.padStart(2, '0');
  const dd = document.getElementById("dd").value.padStart(2, '0');
  const birthdate = yy + mm + dd;
  const sex = document.getElementById("exampleSelect1").value;
  const postcode = document.getElementById("sample6_postcode").value;
  const addr = document.getElementById("sample6_address").value;
  const detail = document.getElementById("sample6_detailAddress").value;
  const extra = document.getElementById("sample6_extraAddress").value;
  const address = `${postcode} ${addr} ${detail} ${extra}`;

  if (password !== rePassword) {
    alert("비밀번호가 일치하지 않습니다.");
    return;
  }

   // ✅ 서버로 회원가입 시도 로그 전송
  fetch("logToServer.jsp?event=UserRegistrationAttempt&id=" + encodeURIComponent(email));

  fetch("https://8e36s31r5f.execute-api.ap-northeast-2.amazonaws.com/prod/cognito-signup", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      action: "register",
      id: email,
      password: password,
      name: name,
      birthdate: birthdate,
      sex: sex,
      address: address
    })
  })
  .then(response => response.json())
  .then(data => {
    if (data.success) {

      // ✅ 서버로 회원가입 성공 로그 전송
      fetch("logToServer.jsp?event=UserRegistrationSuccess&id=" + encodeURIComponent(email));

      alert("회원가입이 완료되었습니다!");
      localStorage.removeItem("emailVerified");
      window.location.href = "PatientLogin.jsp";
    } else {

      // ✅ 서버로 회원가입 실패 로그 전송
      fetch("logToServer.jsp?event=UserRegistrationFailed&id=" + encodeURIComponent(email));
    
      alert("회원가입에 실패했습니다: " + data.message);
    }
  })
  .catch(error => {

    // ✅ 서버로 회원가입 실패 로그 전송
    fetch("logToServer.jsp?event=UserRegistrationFailed&id=" + encodeURIComponent(email));

    console.error("❌ 가입 처리 중 에러:", error);
    alert("서버 오류로 회원가입에 실패했습니다.");
  });
}
</script>

</body>
</html>
