<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html><html lang="vi"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title><sitemesh:write property="title">Quản trị - Đề 04</sitemesh:write></title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"><link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
<style>body{min-height:100vh;display:flex;flex-direction:column;background:#f4f6f9}.main-content{flex:1}.admin-footer{background:#212529;color:#fff}</style><sitemesh:write property="head"/></head><body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark"><div class="container"><a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/admin/home">ADMIN - ĐỀ 04</a><div class="navbar-nav me-auto">
<a class="nav-link" href="${pageContext.request.contextPath}/home">Trang Chủ</a><a class="nav-link" href="${pageContext.request.contextPath}/videos">Sản phẩm</a><a class="nav-link" href="${pageContext.request.contextPath}/admin/users">Quản lý Users</a><a class="nav-link active" href="${pageContext.request.contextPath}/admin/home">Trang quản trị</a></div>
<div class="navbar-nav"><span class="nav-link text-white">Châu Minh Phát - 24110294 - Đề 04</span><a class="nav-link" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></div></div></nav>
<main class="main-content py-4"><div class="container"><sitemesh:write property="body"/></div></main>
<footer class="admin-footer py-3 text-center"><div><strong>Họ tên:</strong> Châu Minh Phát</div><div><strong>MSSV:</strong> 24110294</div><div><strong>Mã đề:</strong> 04</div></footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script></body></html>

