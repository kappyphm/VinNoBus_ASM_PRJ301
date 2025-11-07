<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:if test="${not empty userDetail.customer}">
    <div class="rounded-2xl border border-slate-200 bg-white p-5 shadow-soft mt-6">
        <h2 class="text-xl font-semibold text-brand-700 mb-3">Thông tin khách hàng</h2>
        <div class="grid sm:grid-cols-2 gap-4 text-sm">
            <div>
                <div class="text-slate-500">Hạng thành viên</div>
                <div class="font-medium">
                    <c:choose>
                        <c:when test="${userDetail.customer.membershipLevel == 'STANDARD'}">Tiêu chuẩn</c:when>
                        <c:when test="${userDetail.customer.membershipLevel == 'GOLD'}">Vàng</c:when>
                        <c:when test="${userDetail.customer.membershipLevel == 'PLATINUM'}">Bạch kim</c:when>
                        <c:otherwise>${userDetail.customer.membershipLevel}</c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div>
                <div class="text-slate-500">Điểm tích lũy</div>
                <div class="font-medium">${userDetail.customer.loyaltyPoints}</div>
            </div>
        </div>
        <div class="mt-4">
            <a href="${ctx}/customer/update?id=${userDetail.userId}" class="px-3 py-2 rounded-xl bg-brand-600 text-white text-sm hover:bg-brand-700 shadow-soft">
                Chỉnh sửa thông tin khách hàng
            </a>
        </div>
    </div>
</c:if>
