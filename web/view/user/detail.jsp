<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Thông tin người dùng</jsp:attribute>

    <jsp:body>
        <main class="max-w-5xl mx-auto px-5 py-8">

            <h1 class="text-2xl font-semibold">Thông tin người dùng</h1>
            <p class="text-sm text-slate-600 mt-1">Chi tiết hồ sơ và trạng thái tài khoản.</p>

            <!-- Avatar + Basic Info -->
            <div class="mt-6 grid grid-cols-1 md:grid-cols-[180px_1fr] gap-6">
                <c:set var="avatarUrl" value="${empty userDetail.avatarUrl ? 'https://ui-avatars.com/api/?name=' + (empty userDetail.name ? 'U' : userDetail.name) : userDetail.avatarUrl}" />
                <div class="rounded-2xl border border-slate-200 bg-white p-4 shadow-soft flex flex-col items-center">
                    <img src="${avatarUrl}" alt="avatar"
                         class="w-28 h-28 rounded-2xl object-cover border border-slate-200"/>
                    <div class="mt-3 text-sm text-slate-500">User ID</div>
                    <div class="font-medium text-sm">${empty userDetail.userId ? '—' : userDetail.userId}</div>
                    <div class="mt-2 text-xs ${userDetail.active ? 'text-emerald-600' : 'text-slate-500'}">
                        ${userDetail.active ? 'Đang hoạt động' : 'Chờ duyệt'}
                    </div>
                </div>

                <!-- Info Details -->
                <div class="rounded-2xl border border-slate-200 bg-white p-4 shadow-soft">
                    <div class="grid sm:grid-cols-2 gap-4 text-sm">
                        <c:forEach var="field" items="${['name','email','phone','dob','address']}">
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
                        <a href="${ctx}/user/update" class="px-3 py-2 rounded-xl bg-brand-600 text-white text-sm hover:bg-brand-700 shadow-soft">Chỉnh sửa</a>
                        <a href="${ctx}/auth/logout" class="px-3 py-2 rounded-xl border border-red-200 text-red-700 text-sm hover:bg-red-100">Đăng xuất</a>
                    </div>
                </div>
            </div>

            <!-- Staff Info -->
            <c:if test="${not empty userDetail.staff}">
                <c:set var="staff" value="${userDetail.staff}" />
                <div class="mt-10 rounded-2xl border border-slate-200 bg-white p-5 shadow-soft">
                    <h2 class="text-xl font-semibold text-brand-700 mb-3">Thông tin nhân viên</h2>
                    <div class="grid sm:grid-cols-2 gap-4 text-sm">
                        <c:forEach var="field" items="${['staffCode','position','department']}">
                            <div class="${field == 'department' ? 'sm:col-span-2' : ''}">
                                <div class="text-slate-500">
                                    <c:choose>
                                        <c:when test="${field == 'staffCode'}">Mã nhân viên</c:when>
                                        <c:when test="${field == 'position'}">Chức vụ</c:when>
                                        <c:otherwise>Phòng ban</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="font-medium">${empty staff[field] ? '—' : staff[field]}</div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>

            <!-- Customer Info -->
            <c:if test="${not empty userDetail.customer}">
                <c:set var="customer" value="${userDetail.customer}" />
                <div class="mt-10 rounded-2xl border border-slate-200 bg-white p-5 shadow-soft">
                    <h2 class="text-xl font-semibold text-brand-700 mb-3">Thông tin khách hàng</h2>
                    <div class="grid sm:grid-cols-2 gap-4 text-sm">
                        <div>
                            <div class="text-slate-500">Hạng thành viên</div>
                            <div class="font-medium">
                                <c:choose>
                                    <c:when test="${customer.membershipLevel == 'STANDARD'}">Tiêu chuẩn</c:when>
                                    <c:when test="${customer.membershipLevel == 'GOLD'}">Vàng</c:when>
                                    <c:when test="${customer.membershipLevel == 'PLATINUM'}">Bạch kim</c:when>
                                    <c:otherwise>${customer.membershipLevel}</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div>
                            <div class="text-slate-500">Điểm tích lũy</div>
                            <div class="font-medium">${customer.loyaltyPoints}</div>
                        </div>
                    </div>
                </div>
            </c:if>

        </main>
    </jsp:body>
</ui:layout>
