# Используем официальный образ с JDK 21
FROM openjdk:21-jdk-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем собранный JAR-файл в контейнер
COPY target/lernwortspiel-0.0.1-SNAPSHOT.jar /app/app.jar

# Копируем TLS сертификаты
COPY ssl/keystore.p12 /root/ssl/keystore.p12

# Открываем порт, который использует Spring Boot (по умолчанию 8080)
EXPOSE 443

# Запускаем приложение
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
