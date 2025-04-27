<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>병원 회원가입</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="./css/custom.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
<jsp:include page="module/header.jsp" flush="false" />

<section class="bg-light" style="min-height: 1000px;">
  <div class="container py-4">
    <div class="row mb-3">
      <a class="navbar-brand col-md-3" href="PatientSignUp.jsp"><span class="text-dark h5">개인 회원가입</span></a>
      <a class="navbar-brand col-md-3" href="OrganSignUp.jsp"><span class="text-dark h5">병원 회원가입</span></a>
    </div>  

    <form id="orgSignUpForm" onsubmit="return submitOrgSignup(event)">
      <div class="mb-3">
        <label for="orgId" class="form-label">E-mail</label>
        <input type="email" class="form-control" id="orgId" required>
      </div>
      <div class="mb-3">
        <label for="orgPass" class="form-label">비밀번호</label>
        <input type="password" class="form-control" id="orgPass" required>
      </div>
      <div class="mb-3">
        <label for="orgRePass" class="form-label">비밀번호 확인</label>
        <input type="password" class="form-control" id="orgRePass" required>
      </div>
      <div class="mb-3">
        <label for="orgName" class="form-label">병원명</label>
        <input type="text" class="form-control" id="orgName" required>
      </div>
      <div class="mb-3">
        <label for="orgTel" class="form-label">전화번호</label>
        <input type="text" class="form-control" id="orgTel" required>
      </div>
      <div class="mb-3">
        <label class="form-label">주소</label>
        <div class="row g-2 mb-2">
          <div class="col-md-4">
            <input type="text" class="form-control" id="org_postcode" placeholder="우편번호">
          </div>
          <div class="col-md-4">
            <input type="button" class="form-control" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
          </div>
        </div>
        <input type="text" class="form-control mb-2" id="org_address" placeholder="주소">
        <input type="text" class="form-control mb-2" id="org_detailAddress" placeholder="상세주소">
        <input type="text" class="form-control" id="org_extraAddress" placeholder="참고항목">
      </div>
      <div class="d-grid">
        <button type="submit" class="btn btn-primary btn-lg">가입하기</button>
      </div>
    </form>
  </div>
</section>

<jsp:include page="module/footer.jsp" flush="false" />

<script>
function sample6_execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      const addr = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
      document.getElementById('org_postcode').value = data.zonecode;
      document.getElementById("org_address").value = addr;
      document.getElementById("org_extraAddress").value = data.buildingName || '';
      document.getElementById("org_detailAddress").focus();
    }
  }).open();
}

function submitOrgSignup(event) {
  event.preventDefault();

  const id = document.getElementById("orgId").value;
  const password = document.getElementById("orgPass").value;
  const rePass = document.getElementById("orgRePass").value;
  const name = document.getElementById("orgName").value;
  const tel = document.getElementById("orgTel").value;

  const post = document.getElementById("org_postcode").value;
  const addr = document.getElementById("org_address").value;
  const detail = document.getElementById("org_detailAddress").value;
  const extra = document.getElementById("org_extraAddress").value;

  if (password !== rePass) {
    alert("비밀번호가 일치하지 않습니다.");
    return false;
  }

  const fullAddress = `${post} ${addr} ${detail} ${extra}`;

  const payload = {
    id: id,
    password: password,
    name: name,
    tel: tel,
    address: fullAddress
  };

  fetch("https://i0i241i959.execute-api.ap-northeast-2.amazonaws.com/user", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(payload)
  })
  .then(response => {
    if (!response.ok) throw new Error("회원가입 실패");
    return response.json();
  })
  .then(data => {
    alert("병원 회원가입이 완료되었습니다.");
    window.location.href = "PatientLogin.jsp";
  })
  .catch(err => {
    console.error(err);
    alert("가입 처리 중 오류가 발생했습니다.");
  });

  return false;
}
</script>
</body>
</html>
