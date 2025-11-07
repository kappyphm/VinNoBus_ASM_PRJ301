<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:if test="${not empty userDetail.staff}">
    <div class="rounded-2xl border border-slate-200 bg-white p-5 shadow-soft mt-6">
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
                    <div class="font-medium">${empty userDetail.staff[field] ? '—' : userDetail.staff[field]}</div>
                </div>
            </c:forEach>
        </div>
        <div class="mt-4">
            <a href="${ctx}/staff/update?id=${userDetail.userId}" class="px-3 py-2 rounded-xl bg-brand-600 text-white text-sm hover:bg-brand-700 shadow-soft">
                Chỉnh sửa thông tin nhân viên
            </a>
        </div>
    </div>
</c:if>
