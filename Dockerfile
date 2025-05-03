# 1단계: Tomcat 9 + OpenJDK11 기반의 Alpine 이미지 사용 (경량화 목적)
FROM tomcat:9.0.87-jdk11-temurin

# 2단계: 작업 디렉토리 설정
WORKDIR /usr/local/tomcat

# 3단계: 기본 webapps 제거 (ROOT, docs 등)
RUN rm -rf webapps/*

# 4단계: JDBC 드라이버 복사
COPY Hospital_Search_Site/src/main/webapp/WEB-INF/mysql-connector-java-5.1.49-bin.jar lib/

# 5단계: JSP 웹 프로젝트 복사 (ROOT 컨텍스트에 바로 배포)
COPY Hospital_Search_Site/src/main/webapp/project/ webapps/ROOT/

# 6단계: 환경 변수 설정 (선택적)
ENV TZ=Asia/Seoul

# 7단계: 포트 노출 (기본 HTTP 포트)
EXPOSE 8080

# 8단계: Tomcat 실행
CMD ["catalina.sh", "run"]


