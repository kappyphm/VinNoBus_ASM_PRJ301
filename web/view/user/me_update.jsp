<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Cập nhật thông tin cá nhân</jsp:attribute>

    <jsp:body>
        <main class="max-w-4xl mx-auto px-5 py-8">

            <!-- Dynamic Header -->
            <h1 class="text-2xl font-semibold">Cập nhật thông tin cá nhân</h1>

            <c:set var="avatarUrl" value="${userDetail.avatarUrl}" />
            <c:set var="displayName" value="${userDetail.name}" />
            <c:set var="displayEmail" value="${userDetail.email}" />
            <c:set var="displayAddress" value="${userDetail.address}" />
            <c:set var="userIdValue" value="${  userDetail.userId}" />

            <form action="${ctx}/me/update" method="POST"
                  class="mt-6 bg-white border border-slate-200 rounded-2xl shadow-soft p-6 space-y-5">

                <!-- Avatar -->
                <div class="flex items-center gap-4">
                    <img src="${avatarUrl}" alt="Avatar"
                         class="w-20 h-20 rounded-2xl object-cover border border-slate-200">
                    <div>
                        <div class="text-sm text-slate-500 mb-1">Ảnh đại diện</div>
                        <input type="hidden" name="avatarUrl" value="${avatarUrl}">
                        <input type="hidden" name="active"  value="${userDetail.active}">
                        <div class="text-xs text-slate-400">Ảnh được lấy từ hồ sơ hoặc Google.</div>
                    </div>
                </div>

                <!-- User Info -->
                <div class="grid sm:grid-cols-2 gap-5 text-sm">

                    <div>
                        <label class="text-slate-500">User ID</label>
                        <input type="text" name="userId" readonly
                               value="${userIdValue}"
                               class="mt-1 w-full border border-slate-200 rounded-xl px-3 py-2 bg-slate-50 text-slate-700 focus:outline-none focus:ring-2 focus:ring-brand-500">
                    </div>

                    <div>
                        <label class="text-slate-500">Họ & Tên</label>
                        <input type="text" name="name" required
                               value="${displayName}"
                               class="mt-1 w-full border border-slate-200 rounded-xl px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500">
                    </div>

                    <div>
                        <label class="text-slate-500">Email</label>
                        <input type="email" name="email" readonly
                               value="${displayEmail}"
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
                               value="${displayAddress}"
                               class="mt-1 w-full border border-slate-200 rounded-xl px-3 py-2 focus:outline-none focus:ring-2 focus:ring-brand-500">
                    </div>



                </div>

                <!-- Actions -->
                <div class="pt-4 flex gap-3">
                    <button type="submit"
                            class="px-4 py-2 rounded-xl bg-brand-600 text-white text-sm font-medium hover:bg-brand-700 shadow-soft">
                        Lưu
                    </button>
                    <a href="${ctx}/me" 
                       class="px-4 py-2 rounded-xl border border-brand-200 text-brand-700 text-sm hover:bg-brand-100">
                        Hủy
                    </a>
                </div>

            </form>
        </main>
    </jsp:body>
</ui:layout>
