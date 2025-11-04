<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page pageEncoding="UTF-8" %>
<jsp:include page="/header.jsp" />

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách tuyến xe buýt</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <style>
            @keyframes fadeSlideUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
    </head>
    <body class="font-sans bg-gradient-to-br from-[#f5f7fa] to-[#eaf1f9] animate-[fadeSlideUp_0.5s_ease]"
          style="font-family: 'Segoe UI', 'Segoe UI Emoji', 'Noto Color Emoji', sans-serif;">

        <div class="w-[90%] max-w-[1200px] mx-auto my-[60px] bg-white p-[40px_50px] rounded-[18px] shadow-[0_12px_30px_rgba(0,0,0,0.08)]
             hover:shadow-[0_18px_40px_rgba(0,0,0,0.1)] transition-shadow duration-300 animate-[fadeSlideUp_0.7s_ease]">

            <h2 class="text-center text-[#2c3e50] mb-[35px] text-[28px] tracking-[1px] font-semibold relative after:content-['']
                after:block after:w-[120px] after:h-[4px] after:bg-gradient-to-r from-[#3498db] to-[#2ecc71]
                after:mx-auto after:mt-[12px] after:rounded-full after:shadow-[0_2px_8px_rgba(52,152,219,0.4)]">
                📋 Danh sách tuyến xe buýt
            </h2>

            <!-- ✅ Thông báo -->
            <c:if test="${not empty sessionScope.message}">
                <div class="bg-[#d4edda] text-[#155724] border-l-[5px] border-[#2ecc71] rounded-[8px] mb-[15px] p-[12px_16px] text-[15px] animate-[fadeSlideUp_0.7s_ease]">
                    ${sessionScope.message}
                </div>
                <c:remove var="message" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="bg-[#f8d7da] text-[#721c24] border-l-[5px] border-[#e74c3c] rounded-[8px] mb-[15px] p-[12px_16px] text-[15px] animate-[fadeSlideUp_0.7s_ease]">
                    ${sessionScope.errorMessage}
                </div>
                <c:remove var="errorMessage" scope="session"/>
            </c:if>

            <!-- ✅ Thanh công cụ -->
            <div class="flex justify-between items-center mb-[25px] gap-[12px] animate-[fadeSlideUp_0.8s_ease]">
                <a href="RouteServlet?action=add"
                   class="bg-gradient-to-tr from-[#3498db] to-[#2ecc71] text-white py-[10px] px-[18px] rounded-[10px] shadow-[0_4px_15px_rgba(52,152,219,0.3)]
                   text-[14px] font-medium transition-all duration-200 hover:-translate-y-[3px] hover:brightness-110 hover:shadow-[0_8px_20px_rgba(52,152,219,0.4)]">
                    + Thêm tuyến
                </a>

                <form action="RouteServlet" method="get" class="flex items-center gap-[10px]" accept-charset="UTF-8">
                    <input type="hidden" name="action" value="list">
                    <input type="text" name="search" placeholder="Tìm theo tên..."
                           value="${search}"
                           class="py-[10px] px-[14px] border border-[#ccc] rounded-[10px] text-[14px] bg-[#f9f9f9] text-center
                           transition-all duration-200 focus:border-[#3498db] focus:shadow-[0_0_8px_rgba(52,152,219,0.3)] focus:bg-white focus:outline-none">
                    <button type="submit"
                            class="bg-gradient-to-tr from-[#3498db] to-[#2ecc71] text-white py-[10px] px-[18px] rounded-[10px] shadow-[0_4px_15px_rgba(52,152,219,0.3)]
                            text-[14px] font-medium transition-all duration-200 hover:-translate-y-[3px] hover:brightness-110 hover:shadow-[0_8px_20px_rgba(52,152,219,0.4)]">
                        Tìm kiếm
                    </button>
                </form>
            </div>

            <!-- ✅ Bảng dữ liệu tuyến xe buýt -->
            <div class="overflow-x-auto rounded-xl shadow-xl border border-gray-200 animate-[fadeSlideUp_0.9s_ease]">
                <table class="w-full border-collapse text-center text-[15px]">
                    <thead>
                        <tr class="bg-gradient-to-r from-[#3498db] via-[#2980b9] to-[#2ecc71] text-white uppercase text-sm">
                            <th class="py-3 px-4 border border-gray-200">ID</th>
                            <th class="py-3 px-4 border border-gray-200">Tên tuyến</th>
                            <th class="py-3 px-4 border border-gray-200">Loại tuyến</th>
                            <th class="py-3 px-4 border border-gray-200">Tần suất (phút)</th>
                            <th class="py-3 px-4 border border-gray-200">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${listRoutes}">
                            <tr class="even:bg-gray-50 odd:bg-white hover:bg-[#e8f4fd] transition duration-300">
                                <td class="py-3 px-4 border border-gray-200">${r.routeId}</td>
                                <td class="py-3 px-4 border border-gray-200">${r.routeName}</td>
                                <td class="py-3 px-4 border border-gray-200">${r.type}</td>
                                <td class="py-3 px-4 border border-gray-200">${r.frequency}</td>
                                <td class="py-3 px-4 border border-gray-200 flex flex-wrap justify-center gap-2">
                                    <a href="RouteServlet?action=details&id=${r.routeId}" 
                                       class="bg-gradient-to-r from-[#3498db] to-[#2980b9] text-white px-3 py-1.5 rounded-md hover:opacity-90 transition">📄 Chi tiết</a>
                                    <a href="RouteServlet?action=edit&id=${r.routeId}" 
                                       class="bg-gradient-to-r from-[#f39c12] to-[#f1c40f] text-white px-3 py-1.5 rounded-md hover:opacity-90 transition">✏️ Sửa</a>
                                    <a href="RouteServlet?action=delete&id=${r.routeId}" onclick="return confirm('Bạn có chắc muốn xóa tuyến này không?');"
                                       class="bg-gradient-to-r from-[#e74c3c] to-[#c0392b] text-white px-3 py-1.5 rounded-md hover:opacity-90 transition">🗑️ Xóa</a>
                                    <a href="RouteServlet?action=assign&id=${r.routeId}"
                                       class="bg-gradient-to-r from-[#2ecc71] to-[#27ae60] text-white px-3 py-1.5 rounded-md hover:opacity-90 transition">
                                        🏁 Gán trạm
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Phân trang RouteList.jsp -->
            <div class="text-center mt-8 animate-[fadeSlideUp_1s_ease]">
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <a href="RouteServlet?action=list&page=${i}&search=${search}&type=${type}&sortColumn=${sortColumn}&sortOrder=${sortOrder}"
                               class="inline-block bg-gradient-to-r from-[#3498db] to-[#2ecc71] text-white font-semibold px-3 py-2 rounded-md shadow hover:scale-105 mx-1">
                                ${i}
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="RouteServlet?action=list&page=${i}&search=${search}&type=${type}&sortColumn=${sortColumn}&sortOrder=${sortOrder}"
                               class="inline-block border border-[#3498db] text-[#3498db] font-medium px-3 py-2 rounded-md hover:bg-gradient-to-r hover:from-[#3498db] hover:to-[#2ecc71] hover:text-white hover:shadow transition mx-1">
                                ${i}
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>

        </div>
    </body>
    <jsp:include page="/footer.jsp" />
</html>
