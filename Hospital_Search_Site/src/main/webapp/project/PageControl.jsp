<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*, java.util.*" %>
<%
    request.setCharacterEncoding("utf-8");
    String action = request.getParameter("action");

    if ("login".equals(action)) {
        String id = request.getParameter("id");
        String password = request.getParameter("password");

        String jsonBody = String.format("{\"id\":\"%s\", \"password\":\"%s\"}", id, password);
        String endpoint = "https://8e36s31r5f.execute-api.ap-northeast-2.amazonaws.com/prod/cognito-login";

        String result = callApi(endpoint, "POST", jsonBody);

        if (result.contains("\"success\":true")) {
%>
            <script>
                const resultString = `<%= result %>`;  // JSON 문자열로 그대로 전달
                const result = JSON.parse(resultString);  // JavaScript 객체로 파싱

                // 로컬스토리지에 사용자 정보 저장
                localStorage.setItem("userId", "<%= id %>");
                localStorage.setItem("accessToken", result.accessToken);
                localStorage.setItem("idToken", result.idToken);
                localStorage.setItem("refreshToken", result.refreshToken);

                alert("로그인 성공! ✨");
                window.location.href = "index.jsp";
            </script>
<%
        } else {
%>
            <script>
                alert("❌ 로그인 실패. 아이디 또는 비밀번호를 확인하세요.");
                history.back();
            </script>
<%
        }
    }
%>

<%! 
// API 호출 공통 함수
public String callApi(String endpoint, String method, String body) throws Exception {
    URL url = new URL(endpoint);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod(method);
    conn.setRequestProperty("Content-Type", "application/json");
    conn.setDoOutput(true);

    if (body != null && !body.isEmpty()) {
        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = body.getBytes("utf-8");
            os.write(input, 0, input.length);
        }
    }

    BufferedReader br = new BufferedReader(new InputStreamReader(
        conn.getResponseCode() < 400 ? conn.getInputStream() : conn.getErrorStream(), "utf-8"
    ));

    StringBuilder response = new StringBuilder();
    String responseLine;
    while ((responseLine = br.readLine()) != null) {
        response.append(responseLine.trim());
    }

    br.close();
    conn.disconnect();
    return response.toString();
}
%>

