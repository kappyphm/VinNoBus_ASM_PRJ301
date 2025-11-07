<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<ui:layout>
    <jsp:attribute name="title">Gán quyền nhân viên</jsp:attribute>
    <jsp:body>
        <main class="max-w-3xl mx-auto px-5 py-8">
            <h1 class="text-2xl font-semibold">Gán quyền/ nhiệm vụ</h1>
            <form action="${ctx}/staff/assign" method="post" class="mt-6 space-y-4">
                <input type="hidden" name="userId" value="${userId}" readonly/>
                <div>
                    <label class="block text-slate-500 text-sm">Chức vụ</label>
                    <input type="text" name="position" value="${position}" class="w-full mt-1 p-2 border border-slate-300 rounded-xl"/>
                </div>
                <div>
                    <label class="block text-slate-500 text-sm">Phòng ban</label>
                    <input type="text" name="department" value="${department}" class="w-full mt-1 p-2 border border-slate-300 rounded-xl"/>
                </div>
                <button type="submit" class="px-4 py-2 bg-brand-600 text-white rounded-xl hover:bg-brand-700 shadow-soft">Gán</button>
            </form>
        </main>
    </jsp:body>
</ui:layout>
