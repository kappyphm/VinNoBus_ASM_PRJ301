<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<c:set var="actor" value="me" scope="request" />

<ui:layout>
    <jsp:attribute name="title">Thông tin cá nhân</jsp:attribute>
    <jsp:body>
        <main class="max-w-5xl mx-auto px-5 py-8">
            <c:set var="avatarUrl" value="${empty userDetail.avatarUrl ? 'https://ui-avatars.com/api/?name=' + userDetail.name : userDetail.avatarUrl}" />
            <div class="rounded-2xl border border-slate-200 bg-white p-4 shadow-soft flex items-center gap-6 relative">
                <img src="${avatarUrl}" class="w-28 h-28 rounded-2xl object-cover border border-slate-200"/>
                <div class="flex-1">
                    <div class="text-lg font-semibold">${userDetail.name}</div>
                    <div class="text-sm text-slate-500">${userDetail.email}</div>
                    <div class="mt-1 text-xs ${userDetail.active ? 'text-emerald-600' : 'text-slate-500'}">
                        ${userDetail.active ? 'Đang hoạt động' : 'Chờ duyệt'}
                    </div>
                </div>

                <!-- Nút đăng xuất -->
                <a href="${ctx}/auth/logout" 
                   class="px-3 py-2 rounded-xl bg-red-600 text-white text-sm hover:bg-red-700 shadow-soft absolute top-4 right-4">
                    Đăng xuất
                </a>
            </div>


            <%-- Include các phần chi tiết --%>
            <jsp:include page="/view/include/profile.jsp"/>
            <jsp:include page="/view/include/staff.jsp"/>
            <jsp:include page="/view/include/customer.jsp"/>
        </main>
    </jsp:body>
</ui:layout>
