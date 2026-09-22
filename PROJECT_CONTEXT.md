# PROJECT CONTEXT

REAL PROJECT PATH: E:\Web\New folder\BaitapWeb\ProjectWeb_ChauMinhPhat_24110294
PROJECT TYPE: Java Web Application (Jakarta EE 10 / Servlet 6.0 / JSP 3.1 / JSTL 3.0 / Hibernate 6 JPA)
JAVA VERSION: 26 (Oracle JDK 26.0.2.1, maven.compiler.release = 26)
BUILD TOOL: Apache Maven 3.9.11
SERVER: Apache Tomcat 10.1.44 (E:\Web\Tool\apache-tomcat-10.1.44)
PORT: 8080 (HTTP)
CONTEXT PATH: /Exercise
DATABASE: Microsoft SQL Server 2022 (localhost:1433, service MSSQLSERVER)
DATABASE NAME: ExerciseWeb (User: sa, Password: 1504)
JDBC/JPA: 
- JDBC Driver: com.microsoft.sqlserver.jdbc.SQLServerDriver (mssql-jdbc:12.8.1.jre11)
- JPA Implementation: Hibernate Core 6.6.1.Final (persistence unit: jpa-hibernate-sqlserver)
- Connection Helper: vn.iotstar.connection.DBConnection
- JPA Helper: vn.iotstar.config.JpaConfig
DECORATOR / UI: SiteMesh 3.3.0-RC1 (WEB-INF/decorators/main.jsp) + Bootstrap 5.3.3 + Bootstrap Icons 1.11.3
ARCHITECTURE: MVC 3-Tier Architecture
- Controller: HttpServlet with @WebServlet (vn.iotstar.controller.*)
- Service: Business logic interfaces & implementations (vn.iotstar.service.*, vn.iotstar.service.impl.*)
- DAO: Data Access Object using EntityManager / JDBC (vn.iotstar.dao.*, vn.iotstar.dao.impl.*)
- Entity/Model: JPA @Entity and POJOs (vn.iotstar.entity.*, vn.iotstar.model.*)
- Views: JSP pages with JSTL tags <%@ taglib prefix="c" uri="jakarta.tags.core" %> (src/main/webapp/views/*)
PACKAGE ROOT: vn.iotstar
MAIN CRUD FLOW:
- URL: /sample?action=list -> SampleServlet -> SampleServiceImpl -> SampleDao (EntityManager) -> /views/sample/sample-list.jsp
- URL: /sample?action=add / edit -> SampleServlet -> /views/sample/sample-form.jsp -> POST -> redirect /sample?action=list
- URL: /sample?action=detail&id=X -> SampleServlet -> /views/sample/sample-detail.jsp
- URL: /sample?action=delete&id=X -> SampleServlet -> SampleServiceImpl -> redirect /sample?action=list

IMPORTANT RULES FOR AI:
- REAL PROJECT DIRECTORY: E:\Web\New folder\BaitapWeb\ProjectWeb_ChauMinhPhat_24110294
- All commands, builds, and edits must be executed in E:\Web\New folder\BaitapWeb\ProjectWeb_ChauMinhPhat_24110294.
- Do not create a new project.
- Do not change framework.
- Do not change port (keep Tomcat 8080).
- Do not change DB vendor (keep Microsoft SQL Server localhost:1433, sa / 1504).
- Do not change working dependencies unless required.
- Do not refactor working code unnecessarily.
- Keep Servlet/JSP/JSTL architecture.
- Prefer minimum changes.
- Build before finishing (mvn clean compile && mvn package -DskipTests).
- Fix compile errors immediately.
- Report all changed files.
