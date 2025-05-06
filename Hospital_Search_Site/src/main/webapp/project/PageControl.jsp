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
            session.setAttribute("memId", id);
            session.setAttribute("memPw", password);
            session.setAttribute("memLogin", "ok"); // 로그인 상태 설정
%>
            <script>
                // JSP에서 반환된 JSON을 JavaScript로 처리하기 위해 안전하게 변환
                const resultString = "<%= result %>"; // JSP 변수 그대로 전달
                const result = JSON.parse(resultString);  // JSON 문자열을 JavaScript 객체로 변환

                // 로컬스토리지에 사용자 정보 저장
                localStorage.setItem("userId", "<%= id %>");
                localStorage.setItem("accessToken", result.accessToken);
                localStorage.setItem("idToken", result.idToken);

                alert("로그인 성공");
                window.location.href = "main.jsp";  // 성공 시 메인 페이지로 리디렉션
            </script>
<%
        } else {
            out.println("<script>alert('로그인 실패'); history.back();</script>");
        }
    } else if ("sessionOnly".equals(action)) {
        // JavaScript로 넘어온 세션 설정용 요청
        String id = request.getParameter("id");
        String password = request.getParameter("password");

        session.setAttribute("memId", id);
        session.setAttribute("memPw", password);
        session.setAttribute("memLogin", "ok");

        // ✅ main.jsp로 리다이렉션
        response.sendRedirect("main.jsp");
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

