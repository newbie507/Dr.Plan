<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    String type = request.getParameter("type");  // info, warn, error
    String message = request.getParameter("message"); // 직접 넘긴 메시지
    String event = request.getParameter("event");  // event 방식일 경우
    String id = request.getParameter("id");        // id 방식일 경우
    String email = request.getParameter("email");  // email 방식일 경우

    if (type == null || type.isEmpty()) type = "info";  // 기본 로그 레벨은 info
    String logMessage = "";

    if (message != null) {
        // 1. message 파라미터가 있으면 바로 사용
        logMessage = message;
    } else if (event != null) {
        // 2. event 파라미터 기반으로 메시지 작성
        if ("EmailVerificationRequested".equals(event)) {
            logMessage = "[INFO] 이메일 인증 요청 - " + (email != null ? email : "unknown email");
        } else if ("EmailCodeVerification".equals(event)) {
            logMessage = "[INFO] 이메일 코드 인증 요청 - " + (email != null ? email : "unknown email");
        } else if ("UserRegistrationAttempt".equals(event)) {
            logMessage = "[INFO] 회원가입 시도 - " + (id != null ? id : "unknown id");
        } else if ("UserRegistrationSuccess".equals(event)) {
            logMessage = "[INFO] 회원가입 성공 - " + (id != null ? id : "unknown id");
        } else if ("UserRegistrationFailed".equals(event)) {
            logMessage = "[WARN] 회원가입 실패 - " + (id != null ? id : "unknown id");
        } else if ("HospitalListFetchAttempt".equals(event)) {
            logMessage = "[INFO] 병원 목록 조회 시도 - " + (id != null ? id : "unknown id");
        } else if ("HospitalListFetchSuccess".equals(event)) {
            logMessage = "[INFO] 병원 목록 조회 성공 - " + (id != null ? id : "unknown id");
        } else if ("HospitalListFetchFailed".equals(event)) {
            logMessage = "[ERROR] 병원 목록 조회 실패 - " + (id != null ? id : "unknown id");
        } else if ("ReservationAttempt".equals(event)) {
            logMessage = "[INFO] 예약 시도 - " + (id != null ? id : "unknown id");
        } else if ("ReservationSuccess".equals(event)) {
            logMessage = "[INFO] 예약 성공 - " + (id != null ? id : "unknown id");
        } else if ("ReservationFailed".equals(event)) {
            logMessage = "[WARN] 예약 실패 - " + (id != null ? id : "unknown id");
        }   else if ("MyPageAccess".equals(event)) {
            logMessage = "[INFO] 마이페이지 접근 - " + (id != null ? id : "unknown id");
        } else if ("ReservationCancelAttempt".equals(event)) {
            logMessage = "[INFO] 예약 취소 시도 - " + (id != null ? id : "unknown id");
        } else if ("ReservationCancelSuccess".equals(event)) {
            logMessage = "[INFO] 예약 취소 성공 - " + (id != null ? id : "unknown id");
        } else if ("ReservationCancelFailed".equals(event)) {
            logMessage = "[ERROR] 예약 취소 실패 - " + (id != null ? id : "unknown id");        
        } else {
            logMessage = "[INFO] 알 수 없는 이벤트 발생";
        }        
    } else {
        // 3. 둘 다 없으면 기본 메시지
        logMessage = "[INFO] 알 수 없는 로그 요청";
    }

    // 최종적으로 type에 따라 출력
    switch (type.toLowerCase()) {
        case "info":
            System.out.println(logMessage);
            break;
        case "warn":
            System.out.println("[WARN] " + logMessage);
            break;
        case "error":
            System.out.println("[ERROR] " + logMessage);
            break;
        default:
            System.out.println("[INFO] " + logMessage);
            break;
    }
%>
