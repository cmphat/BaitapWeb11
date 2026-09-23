<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title><sitemesh:write property="title">Đề 04 - Châu Minh Phát</sitemesh:write></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
<style>body{min-height:100vh;display:flex;flex-direction:column;background:#f6f8fb}.main-content{flex:1}.video-poster{height:190px;object-fit:cover}.student-footer{background:#0d6efd;color:#fff}</style>
<sitemesh:write property="head"/></head><body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm"><div class="container">
<a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">ĐỀ 04</a>
<button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#nav"><span class="navbar-toggler-icon"></span></button>
<div class="collapse navbar-collapse" id="nav"><ul class="navbar-nav me-auto">
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Trang Chủ</a></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/videos">Sản phẩm</a></li>
<c:if test="${not empty sessionScope.account and sessionScope.account.admin}"><li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/home">Trang quản trị</a></li></c:if>
</ul><ul class="navbar-nav ms-auto"><c:choose><c:when test="${not empty sessionScope.account}">
<li class="nav-item"><span class="nav-link text-white fw-semibold"><c:out value="${sessionScope.account.fullname}"/></span></li>
<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
</c:when><c:otherwise><li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">Đăng nhập</a></li></c:otherwise></c:choose></ul></div></div></nav>
<main class="main-content py-4"><div class="container"><sitemesh:write property="body"/></div></main>
<footer class="student-footer py-3 text-center"><div class="container"><div><strong>Họ tên:</strong> Châu Minh Phát</div><div><strong>MSSV:</strong> 24110294</div><div><strong>Mã đề:</strong> 04</div></div></footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script></body></html>

