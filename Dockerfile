# 1. Tomcat 9 기반 이미지 사용
FROM tomcat:9.0-jdk11

# 2. 작업 디렉터리 설정
WORKDIR /usr/local/tomcat

# 3. 기존 webapps 디렉토리 제거 (필요한 경우)
RUN rm -rf webapps/*

# 4. JDBC 드라이버 복사
COPY Hospital_Search_Site/src/main/webapp/WEB-INF/mysql-connector-java-5.1.49-bin.jar lib/

# 5. JSP 프로젝트 복사
COPY Hospital_Search_Site/src/main/webapp/project/ ./webapps/ROOT/

# 6. 포트 노출
EXPOSE 8080

# 7. Tomcat 실행
CMD ["catalina.sh", "run"]
