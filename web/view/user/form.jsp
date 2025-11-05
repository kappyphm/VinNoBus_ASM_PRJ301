<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Cập nhật người dùng • VinNoBus</title>

        <!-- Font & Tailwind -->
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
        <style>
            html {
                font-family: 'Roboto Mono', ui-monospace, SFMono-Regular;
            }
        </style>
    </head>
    <body class="bg-brand-50 text-slate-800 min-h-screen">
        <header class="border-b border-slate-200 bg-white">
            <div class="max-w-4xl mx-auto px-5 py-4 flex items-center justify-between">
                <a href="${ctx}/" class="flex items-center gap-2">
                    <div class="w-8 h-8 rounded-xl bg-brand-600 text-white grid place-items-center font-semibold">V</div>
                    <span class="font-semibold">VinNoBus</span>
                </a>
                <a href="${ctx}/user" class="text-sm text-brand-700 hover:underline">Quản lý người dùng</a>
            </div>
        </header>

        <main class="max-w-4xl mx-auto px-5 py-8">
            <!-- Dynamic Title -->
            <jsp:include page="/view/user/component/DetailHeader.jsp"  />
            <form action="${ctx}/user/${action}" method="POST"
                  class="mt-6 bg-white border border-slate-200 rounded-2xl shadow-soft p-6 space-y-5">

                <!-- Avatar -->
                <div class="flex items-center gap-4">
                    <img src="${not empty userDetail.avatarUrl ? userDetail.avatarUrl : googleUser.picture}"
                         alt="Avatar" class="w-20 h-20 rounded-2xl object-cover border border-slate-200">
                    <div>
                        <div class="text-sm text-slate-500 mb-1">Ảnh đại diện</div>
                        <input type="hidden" name="avatarUrl"
                               value="${not empty userDetail.avatarUrl ? userDetail.avatarUrl : googleUser.picture}">
                        <div class="text-xs text-slate-400">Ảnh được lấy từ hồ sơ hoặc Google.</div>
                    </div>
                </div>

                <!-- User Info -->
                <div class="grid sm:grid-cols-2 gap-5 text-sm">
                    <div>
                        <label class="text-slate-500">User ID</label>
                        <input type="text" name="userId" readonly
                               value="${not empty userDetail.userId ? userDetail.userId : googleUser.sub}"
                               class="mt-1 w-full border border-slate-200 rounded-xl px-3 py-2 bg-slate-50 text-slate-700 focus:outline-none focus:ring-2 focus:ring-brand-500">
                    </div>

                    <!-- Chỉ hiển thị nếu có staff trong session -->
                    <c:if test="${not empty sessionScope.staff}">
                        <div class="flex items-center gap-2 mt-6 sm:mt-0">
                            <input type="checkbox" name="active" id="active"
                                   class="w-4 h-4 text-brand-600 border-slate-300 rounded focus:ring-brand-500"
                                   <c:if test="${userDetail.active}">checked</c:if>>
                                   <label for="active" class="text-slate-700 text-sm">Kích hoạt tài khoản</label>
                            </div>
                    </c:if>

                    <div>
                        <label class="text-slate-500">Họ & Tên</label>
                        <input type="text" name="name" required
                               value="${not empty userDetail.name ? userDetail.name : googleUser.name}"
                               class="mt-1 w-full border border-slate-200 rounded-xl px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500">
                    </div>

                    <div>
                        <label class="text-slate-500">Email</label>
                        <input type="email" name="email" readonly
                               value="${not empty userDetail.email ? userDetail.email : googleUser.email}"
                               class="mt-1 w-full border border-slate-200 rounded-xl px-3 py-2 bg-slate-50 text-slate-700">
                    </div>

                    <div>
                        <label class="text-slate-500">Số điện thoại</label>
                        <input type="tel" name="phone" required
                               value="${userDetail.phone}"
                               class="mt-1 w-full border border-slate-200 rounded-xl px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500">
                    </div>

                    <div>
                        <label class="text-slate-500">Ngày sinh</label>
                        <input type="date" name="dob" required
                               value="<fmt:formatDate value='${userDetail.dob}' pattern='yyyy-MM-dd'/>"
                               class="mt-1 w-full border border-slate-200 rounded-xl px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500">
                    </div>

                    <div class="sm:col-span-2">
                        <label class="text-slate-500">Địa chỉ</label>
                        <input type="text" name="address" required
                               value="${not empty userDetail.address ? userDetail.address : googleUser.local}"
                               class="mt-1 w-full border border-slate-200 rounded-xl px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500">
                    </div>
                </div>

                <!-- Actions -->
                <div class="pt-4 flex gap-3">
                    <button type="submit"
                            class="px-4 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 shadow-soft">
                        Lưu thay đổi
                    </button>
                    <a href="${ctx}/${action=='create'?'/':'/user/'}"
                       class="px-4 py-2 rounded-xl border border-brand-200 text-brand-700 text-sm hover:bg-brand-100">
                        Hủy
                    </a>
                </div>
            </form>
        </main>
    </body>
</html>
