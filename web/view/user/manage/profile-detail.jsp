<%-- 
    Document   : profile-detail
    Created on : Nov 7, 2025, 8:17:55 AM
    Author     : kappyphm
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Avatar + Basic Info -->
<div class="mt-6 grid grid-cols-1 md:grid-cols-[180px_1fr] gap-6">
    <c:set var="avatarUrl" value="${empty userDetail.avatarUrl ? 'https://ui-avatars.com/api/?name=' + (empty userDetail.name ? 'U' : userDetail.name) : userDetail.avatarUrl}" />
    <div class="rounded-2xl border border-slate-200 bg-white p-4 shadow-soft flex flex-col items-center">
        <img src="${avatarUrl}" alt="avatar"
             class="w-28 h-28 rounded-2xl object-cover border border-slate-200"/>
        <div class="mt-3 text-sm text-slate-500">User ID</div>
        <div class="truncate max-w-24 font-medium text-sm">${empty userDetail.userId ? '—' : userDetail.userId}</div>
        <div class="mt-2 text-xs ${userDetail.active ? 'text-emerald-600' : 'text-slate-500'}">
            ${userDetail.active ? 'Đang hoạt động' : 'Chờ duyệt'}
        </div>
    </div>

    <!-- Info Details -->
    <div class="rounded-2xl border border-slate-200 bg-white p-4 shadow-soft">
        <div class="grid sm:grid-cols-2 gap-4 text-sm">

            <c:forEach  items="${['name','email','phone','dob','address']}" var="field">
                <c:set var="label" value="${field == 'name' ? 'Họ & Tên' : field == 'email' ? 'Email' : field == 'phone' ? 'Số điện thoại' : field == 'dob' ? 'Ngày sinh' : 'Địa chỉ'}"/>
                <div class="${field == 'address' ? 'sm:col-span-2' : ''}">
                    <div class="text-slate-500">${label}</div>
                    <div class="font-medium">
                        <c:choose>
                            <c:when test="${field == 'dob'}">
                                <c:choose>
                                    <c:when test="${not empty userDetail.dob}">
                                        <fmt:formatDate value="${userDetail.dob}" pattern="dd/MM/yyyy"/>
                                    </c:when>
                                    <c:otherwise>—</c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                ${empty userDetail[field] ? '—' : userDetail[field]}
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Actions -->
        <div class="mt-6 flex flex-wrap gap-3">
            <c:choose>
                <c:when test="${not empty sessionScope.user.staff}">
                    <a href="${ctx}/profile/update?id=${userDetail.userId}" class="px-3 py-2 rounded-xl bg-brand-600 text-white text-sm hover:bg-brand-700 shadow-soft">Chỉnh sửa</a>
                    <a href="${ctx}/user/delete?id=${userDetail.userId}" class="px-3 py-2 rounded-xl bg-red-600 text-white text-sm hover:bg-red-700 shadow-soft">Xóa</a>
                </c:when>
                <c:when test="${not empty sessionScope.user.staff}">
                    <a href="${ctx}/profile/update" class="px-3 py-2 rounded-xl bg-brand-600 text-white text-sm hover:bg-brand-700 shadow-soft">Chỉnh sửa</a>
                </c:when>
                <c:when test="${sessionScope.user.userId==userDetail.userId}">
                    <a href="${ctx}/profile/update" class="px-3 py-2 rounded-xl bg-brand-600 text-white text-sm hover:bg-brand-700 shadow-soft">Chỉnh sửa</a>
                    <a href="${ctx}/auth/logout" class="px-3 py-2 rounded-xl bg-red-600 text-white text-sm hover:bg-red-700 shadow-soft">Đăng xuất</a>
                </c:when>
            </c:choose>
        </div>
    </div>
</div>

