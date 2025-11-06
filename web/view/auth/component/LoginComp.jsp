<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : LoginComp
    Created on : Nov 6, 2025, 10:33:21 AM
    Author     : kappyphm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<c:choose>
    <c:when test="${empty sessionScope.user}">
        <a class="px-3 py-2 rounded-xl bg-brand-600 text-white text-sm hover:bg-brand-700 shadow-soft" href="${ctx}/auth/login">Đăng nhập</a>
    </c:when>
    <c:otherwise>
        <a class="px-3 py-2 rounded-xl bg-brand-600 text-white text-sm hover:bg-brand-700 shadow-soft" href="${ctx}/user/detail">Hồ sơ</a>
    </c:otherwise>
</c:choose>

