FROM tomcat:10.1-jdk17-temurin

# Xóa các ứng dụng mặc định của Tomcat để tiết kiệm RAM
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy file war của dự án vào và đặt tên là ROOT.war để chạy trực tiếp tại đường dẫn gốc (/)
COPY tiendat-anthropic.com.war /usr/local/tomcat/webapps/ROOT.war

# Giới hạn RAM phù hợp với Render Free Tier (512MB RAM)
ENV JAVA_OPTS="-Xms128m -Xmx256m"

# Port mặc định
EXPOSE 8080

# Tự động đồng bộ cổng với biến môi trường PORT của Render khi khởi chạy
CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT:-8080}\\\"/g\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]
