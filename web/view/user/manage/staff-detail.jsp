<%-- 
    Document   : detail
    Created on : Nov 6, 2025, 11:48:08 PM
    Author     : kappyphm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Staff Info -->
<c:set var="staff" value="${userDetail.staff}" />
<c:if test="${not empty staff}">
    
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
