<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


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

