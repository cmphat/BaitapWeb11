# EXAM PROJECT RUNBOOK

Tài liệu hướng dẫn vận hành, build, chạy và kiểm tra môi trường cho bài thi Java Web.

**THƯ MỤC DỰ ÁN CHÍNH (REAL PROJECT PATH):**
`E:\Web\New folder\BaitapWeb\HomeWorkWeb_Chau_Minh_Phat`

---

## 1. JAVA CHECK
Kiểm tra phiên bản Java máy phòng thi:
```powershell
java -version
```
*Môi trường thực tế:* Java 26 (Oracle JDK 26.0.2.1, `C:\Program Files\Java\jdk-26.0.2.1`).

---

## 2. MAVEN CHECK
Kiểm tra phiên bản Maven:
```powershell
mvn -version
```
*Môi trường thực tế:* Apache Maven 3.9.11 (`E:\Web\Tool\apache-maven-3.9.11-bin\apache-maven-3.9.11`).

---

## 3. BUILD & PACKAGE (CHẠY TẠI THƯ MỤC Ổ E)
```powershell
# Chuyển vào thư mục dự án trên ổ E nếu cần
cd "E:\Web\New folder\BaitapWeb\HomeWorkWeb_Chau_Minh_Phat"

# Clean project
mvn clean

# Compile project
mvn compile

# Build WAR package
mvn clean package -DskipTests
```
*Output file:* `E:\Web\New folder\BaitapWeb\HomeWorkWeb_Chau_Minh_Phat\target\Exercise.war`

---

## 4. TOMCAT RUN & DEPLOY
### Tomcat Info
- Thư mục Tomcat: `E:\Web\Tool\apache-tomcat-10.1.44`
- HTTP Port: `8080`
- Context Path: `/Exercise`

### Deploy WAR vào Tomcat:
```powershell
Copy-Item "E:\Web\New folder\BaitapWeb\HomeWorkWeb_Chau_Minh_Phat\target\Exercise.war" -Destination "E:\Web\Tool\apache-tomcat-10.1.44\webapps\Exercise.war" -Force
```

### Khởi động Tomcat độc lập:
```powershell
E:\Web\Tool\apache-tomcat-10.1.44\bin\startup.bat
```

### Dừng Tomcat:
```powershell
E:\Web\Tool\apache-tomcat-10.1.44\bin\shutdown.bat
```

### Chạy qua IDE (Eclipse / STS):
1. Mở Spring Tool Suite / Eclipse.
2. Servers tab -> Chuột phải vào Tomcat 10.1 Server -> Add and Remove... -> Add `Exercise`.
3. Bấm **Start** (hoặc Debug).

---

## 5. APP URLS
- Trang chủ: [http://localhost:8080/Exercise/](http://localhost:8080/Exercise/)
- Trang Login: [http://localhost:8080/Exercise/login](http://localhost:8080/Exercise/login)
- Sample CRUD (Exam Starter): [http://localhost:8080/Exercise/sample?action=list](http://localhost:8080/Exercise/sample?action=list)
- Category JPA List: [http://localhost:8080/Exercise/admin/categories](http://localhost:8080/Exercise/admin/categories)
- Product List: [http://localhost:8080/Exercise/admin/products](http://localhost:8080/Exercise/admin/products)

---

## 6. DATABASE (MICROSOFT SQL SERVER)
- **Host / Port:** `localhost:1433`
- **Database name:** `ExerciseWeb`
- **Username:** `sa`
- **Password:** `1504`
- **JDBC Driver:** `com.microsoft.sqlserver.jdbc.SQLServerDriver`
- **JDBC URL:** `jdbc:sqlserver://localhost:1433;databaseName=ExerciseWeb;encrypt=true;trustServerCertificate=true`

### Kiểm tra service SQL Server:
```powershell
Get-Service -Name MSSQLSERVER
```

### Khởi động SQL Server nếu đang tắt:
```powershell
Start-Service -Name MSSQLSERVER
```

### Kiểm tra kết nối nhanh bằng sqlcmd:
```powershell
sqlcmd -S localhost -U sa -P 1504 -d ExerciseWeb -Q "SELECT @@VERSION;"
```

### Chạy script tạo dữ liệu mẫu thi:
```powershell
sqlcmd -S localhost -U sa -P 1504 -d ExerciseWeb -i "E:\Web\New folder\BaitapWeb\HomeWorkWeb_Chau_Minh_Phat\database\exam_template.sql"
```

### Reset dữ liệu thi về ban đầu:
```powershell
sqlcmd -S localhost -U sa -P 1504 -d ExerciseWeb -i "E:\Web\New folder\BaitapWeb\HomeWorkWeb_Chau_Minh_Phat\database\reset_exam_data.sql"
```
