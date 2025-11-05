<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Thông tin người dùng • VinNoBus</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;600;700&display=swap" rel="stylesheet">
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {extend: {
                        fontFamily: {mono: ['Roboto Mono', 'ui-monospace', 'SFMono-Regular']},
                        colors: {brand: {50: '#eff6ff', 100: '#dbeafe', 200: '#bfdbfe', 300: '#93c5fd', 400: '#60a5fa', 500: '#3b82f6', 600: '#2563eb', 700: '#1d4ed8', 800: '#1e40af', 900: '#1e3a8a'}},
                        boxShadow: {soft: '0 8px 24px rgba(2,6,23,.06)'}
                    }}
            }
        </script>
        <style> html{
                font-family:'Roboto Mono',ui-monospace,SFMono-Regular,Menlo,Monaco,Consolas,'Liberation Mono','Courier New',monospace
            } </style>
    </head>
    <body class="bg-brand-50 text-slate-800 min-h-screen">
        <header class="border-b border-slate-200 bg-white">
            <div class="max-w-5xl mx-auto px-5 py-4 flex items-center justify-between">
                <a href="admin.jsp" class="flex items-center gap-2">
                    <div class="w-8 h-8 rounded-xl bg-brand-600 text-white grid place-items-center font-semibold">V</div>
                    <span class="font-semibold">VinNoBus</span>
                </a>
                <a href="info.jsp" class="text-sm text-brand-700 hover:underline">Trang thông tin</a>
            </div>
        </header>

        <main class="max-w-5xl mx-auto px-5 py-8">
            <h1 class="text-2xl font-semibold">Thông tin người dùng</h1>
            <p class="text-sm text-slate-600 mt-1">Chi tiết hồ sơ và trạng thái tài khoản.</p>

            <!-- Avatar + Basic -->
            <div class="mt-6 grid grid-cols-1 md:grid-cols-[180px_1fr] gap-6">
                <div class="rounded-2xl border border-slate-200 bg-white p-4 shadow-soft flex flex-col items-center">
                    <img src="${empty userDetail.avatarUrl ? 'https://ui-avatars.com/api/?name=' += (empty userDetail.name ? 'U' : userDetail.name) : userDetail.avatarUrl}" alt="avatar"
                         class="w-28 h-28 rounded-2xl object-cover border border-slate-200"/>
                    <div class="mt-3 text-sm text-slate-500">User ID</div>
                    <div class="font-medium text-sm ">${empty userDetail.userId ? '—' : userDetail.userId}</div>
                    <div class="mt-2 text-xs ${userDetail.active ? 'text-emerald-600' : 'text-slate-500'}">
                        ${userDetail.active ? 'Đang hoạt động' : 'Chờ duyệt'}
                    </div>
                </div>

                <div class="rounded-2xl border border-slate-200 bg-white p-4 shadow-soft">
                    <div class="grid sm:grid-cols-2 gap-4 text-sm">
                        <div>
                            <div class="text-slate-500">Họ & Tên</div>
                            <div class="font-medium">${empty userDetail.name ? '—' : userDetail.name}</div>
                        </div>
                        <div>
                            <div class="text-slate-500">Email</div>
                            <div class="font-medium">${empty userDetail.email ? '—' : userDetail.email}</div>
                        </div>
                        <div>
                            <div class="text-slate-500">Số điện thoại</div>
                            <div class="font-medium">${empty userDetail.phone ? '—' : userDetail.phone}</div>
                        </div>
                        <div>
                            <div class="text-slate-500">Ngày sinh</div>
                            <div class="font-medium">
                                <c:choose>
                                    <c:when test="${not empty userDetail.dob}"><fmt:formatDate value="${userDetail.dob}" pattern="dd/MM/yyyy"/></c:when>
                                    <c:otherwise>—</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="sm:col-span-2">
                            <div class="text-slate-500">Địa chỉ</div>
                            <div class="font-medium">${empty userDetail.address ? '—' : userDetail.address}</div>
                        </div>
                    </div>

                    <div class="mt-6 flex flex-wrap gap-3">
                        <a href="${ctx}/user/update" class="px-3 py-2 rounded-xl bg-brand-600 text-white text-sm hover:bg-brand-700 shadow-soft">Chỉnh sửa</a>
                        <a href="${ctx}/user" class="px-3 py-2 rounded-xl border border-brand-200 text-brand-700 text-sm hover:bg-brand-100">Danh sách user</a>
                    </div>
                </div>
            </div>
            <!-- Thông tin nhân viên -->
            <c:if test="${not empty staff}">
                <div class="mt-10 rounded-2xl border border-slate-200 bg-white p-5 shadow-soft">
                    <h2 class="text-xl font-semibold text-brand-700 mb-3">Thông tin nhân viên</h2>
                    <div class="grid sm:grid-cols-2 gap-4 text-sm">
                        <div>
                            <div class="text-slate-500">Mã nhân viên</div>
                            <div class="font-medium">${empty staff.staffCode ? '—' : staff.staffCode}</div>
                        </div>
                        <div>
                            <div class="text-slate-500">Chức vụ</div>
                            <div class="font-medium">${empty staff.position ? '—' : staff.position}</div>
                        </div>
                        <div class="sm:col-span-2">
                            <div class="text-slate-500">Phòng ban</div>
                            <div class="font-medium">${empty staff.department ? '—' : staff.department}</div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Thông tin khách hàng -->
            <c:if test="${not empty customer}">
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
    </body>
</html>
