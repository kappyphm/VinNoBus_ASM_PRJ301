
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<c:choose>
    <c:when test="${empty sessionScope.user}">
        <a class="px-3 py-2 rounded-xl bg-brand-600 text-white text-sm hover:bg-brand-700 shadow-soft" href="${ctx}/auth/login">Đăng nhập</a>
    </c:when>

    <c:otherwise>
        <a class="px-3 py-2 rounded-xl bg-brand-600 text-white text-sm hover:bg-brand-700 shadow-soft" href="${ctx}/me">Hồ sơ</a>
    </c:otherwise>
</c:choose>

