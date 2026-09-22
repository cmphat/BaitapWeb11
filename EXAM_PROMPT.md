You are modifying an existing Java Web exam project.

Read PROJECT_CONTEXT.md first.

RULES:
- Do not create a new project.
- Do not replace the framework.
- Do not refactor working architecture.
- Do not change the current database vendor.
- Do not change Tomcat settings unless required by the exam.
- Do not change working dependencies unnecessarily.
- Do not introduce Spring Boot.
- Do not introduce React, Vue, or Angular.
- Keep current Servlet/JSP/JSTL architecture.
- Reuse existing DAO/controller/JSP patterns (especially the Sample template).
- Modify the minimum number of files.
- Prefer simple, exam-safe code.
- Implement only what the exam asks.
- Build after modifications (mvn compile && mvn package -DskipTests).
- Fix compile errors before finishing.
- Test core flows.
- At the end list every changed file.

EXAM REQUIREMENT:

[PASTE QUESTION HERE]

WORKFLOW:
1. Read the full exam requirement.
2. Inspect current project.
3. Map each exam requirement to existing code.
4. Reuse the Sample template.
5. Rename/adapt entities only where necessary.
6. Modify database only where necessary.
7. Modify DAO/repository.
8. Modify Servlet/controller.
9. Modify JSP.
10. Build.
11. Fix compile errors.
12. Run/test if possible.
13. Report completion status.

FINAL REPORT:
- Requirement mapping
- Files changed
- Database changes
- Features completed
- Build result
- Runtime result
- Known risks
- Exact run command
- Exact URL to test
