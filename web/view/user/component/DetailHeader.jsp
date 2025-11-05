<%-- 
    Document   : FormHeader
    Created on : Nov 6, 2025, 4:16:58 AM
    Author     : kappyphm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Dynamic Title -->
<c:choose>
    <!-- Dynamic Title -->
<c:choose>
    <c:when test="${action == 'create'}">
        <h1 class="text-2xl font-semibold">Đăng ký thông tin người dùng</h1>
        <p class="text-sm text-slate-600 mt-1">Vui lòng điền đầy đủ thông tin để tạo tài khoản mới.</p>
    </c:when>
    <c:when test="${action == 'update'}">
        <h1 class="text-2xl font-semibold">Cập nhật thông tin người dùng</h1>
        <p class="text-sm text-slate-600 mt-1">Chỉnh sửa thông tin hồ sơ cá nhân của bạn.</p>
    </c:when>
    <c:otherwise>
        <h1 class="text-2xl font-semibold">Thông tin người dùng</h1>
        <p class="text-sm text-slate-600 mt-1">Trang quản lý hồ sơ cá nhân.</p>
    </c:otherwise>
</c:choose>

        
</c:choose>
