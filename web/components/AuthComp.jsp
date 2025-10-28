<%-- 
    Document   : AuthComponent
    Created on : Oct 27, 2025, 8:05:58 AM
    Author     : kappyphm
--%>

<%@page pageEncoding="UTF-8"%>
<div>
    <c:set var="ctx" value="${pageContext.request.contextPath}" />
    <c:choose>
        <c:when test="${not empty sessionScope.user_id}">
            <a href="${ctx}/user/profile" class="px-4 py-2 bg-gray-700 hover:bg-gray-600 rounded-xl shadow-sm transition">
                Trang cá nhân
            </a>
        </c:when>
        <c:otherwise>
            <a href="${ctx}/auth/login" class="px-4 py-2 bg-blue-600 hover:bg-blue-500 rounded-xl shadow-sm transition">
                Đăng nhập
            </a>
        </c:otherwise>
    </c:choose>
</div>
