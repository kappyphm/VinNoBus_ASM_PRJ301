<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />



<ui:layout>
    <jsp:attribute name="title">Danh sách nhân viên</jsp:attribute>
    <jsp:body>
        <main class="max-w-5xl mx-auto px-5 py-8">
            <h1 class="text-2xl font-semibold">Danh sách nhân viên</h1>
            <!-- Form tìm kiếm -->
            <form action="${ctx}/staffs" method="GET" class="mt-4 mb-6 flex flex-wrap gap-3">
                <input type="text" name="search" placeholder="Tim kiem" 
                       value="${search}" 
                       class="px-3 py-2 border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-brand-500 text-sm">
                <button type="submit" 
                        class="px-4 py-2 rounded-xl bg-brand-600 text-white text-sm hover:bg-brand-700 shadow-soft">
                    Tìm kiếm
                </button>



            </form>

            <table class="w-full mt-6 border border-slate-200 rounded-xl overflow-hidden text-sm shadow-soft">
                <thead class="bg-brand-100">
                    <tr>
                        <th class="p-2 border-b">Mã nhân viên</th>
                        <th class="p-2 border-b">Tên</th>
                        <th class="p-2 border-b">Chức vụ</th>
                        <th class="p-2 border-b">Phòng ban</th>
                        <th class="p-2 border-b">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${staffs}">
                        <tr class="hover:bg-slate-50">
                            <td class="p-2 border-b text-center">${user.staff.staffCode}</td>
                            <td class="p-2 border-b text-center">${user.name}</td>
                            <td class="p-2 border-b text-center">${user.staff.position}</td>
                            <td class="p-2 border-b text-center">${user.staff.department}</td>
                            <td class="p-2 border-b space-x-2 text-center">
                                <a href="${ctx}/user?id=${user.userId}" class="text-blue-600 hover:underline">Xem</a>
<!--                                <a href="${ctx}/staff/update?id=${user.userId}" class="text-blue-600 hover:underline">Chỉnh sửa</a>-->
                                <a href="${ctx}/staff/delete?id=${user.userId}" class="text-red-600 hover:underline">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </main>
    </jsp:body>
</ui:layout>
