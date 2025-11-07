<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="rounded-2xl border border-slate-200 bg-white p-5 shadow-soft mt-6">
    <h2 class="text-xl font-semibold text-brand-700 mb-3">Thông tin cá nhân</h2>
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
                        <c:otherwise>${empty userDetail[field] ? '—' : userDetail[field]}</c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
    </div>
    <div class="mt-4">
        <a href="${ctx}/profile/update?id=${userDetail.userId}" class="px-3 py-2 rounded-xl bg-brand-600 text-white text-sm hover:bg-brand-700 shadow-soft">
            Chỉnh sửa thông tin cá nhân
        </a>
    </div>
</div>
