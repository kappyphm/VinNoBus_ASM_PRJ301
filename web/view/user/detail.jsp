<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<jsp:include page="/header.jsp" />



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
                <a href="${ctx}/auth/logout" class="px-3 py-2 rounded-xl border border-red-200 text-red-700 text-sm hover:bg-red-100">Đăng xuất</a>
            </div>
        </div>
    </div>
    <!-- Thông tin nhân viên -->
    <c:set var="staff" value="${userDetail.staff}" />
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
    <c:set var="customer" value="${userDetail.customer}" />
    <c:if test="${not empty userDetail.customer}">
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
<jsp:include page="/footer.jsp" />
