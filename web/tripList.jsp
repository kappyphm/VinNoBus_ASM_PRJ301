<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="header.jsp" %>

<style>
    body {
        font-family: 'Segoe UI', Roboto, sans-serif;
        background: #f4f6f9;
        margin: 0;
        padding: 20px;
    }

    h1 {
        text-align: center;
        color: #0078d7;
        margin-bottom: 20px;
    }

    /* --- Thanh trên cùng --- */
    .top-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background: white;
        padding: 12px 20px;
        border-radius: 10px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        margin-bottom: 20px;
    }

    .top-bar h2 {
        margin: 0;
        color: #333;
    }

    .add-btn {
        display: inline-block;
        padding: 10px 18px;
        background-color: #0078d7;
        color: white;
        text-decoration: none;
        border-radius: 8px;
        font-weight: 500;
        transition: 0.25s;
    }

    .add-btn:hover {
        background-color: #005fa3;
        transform: translateY(-2px);
    }

    /* --- Form lọc --- */
    form.search-form {
        background: white;
        padding: 15px 20px;
        border-radius: 10px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        align-items: center;
        justify-content: center;
        margin-bottom: 25px;
    }

    form label {
        font-weight: 600;
        color: #333;
    }

    form select, form input[type=text], form button {
        padding: 8px 10px;
        border-radius: 6px;
        border: 1px solid #ccc;
        font-size: 14px;
    }

    form select:focus, form input:focus {
        outline: none;
        border-color: #0078d7;
        box-shadow: 0 0 3px #0078d7;
    }

    form button {
        background-color: #0078d7;
        color: white;
        border: none;
        cursor: pointer;
        transition: 0.25s;
    }

    form button:hover {
        background-color: #005fa3;
    }

    /* --- Bảng dữ liệu --- */
    table {
        width: 100%;
        border-collapse: collapse;
        background: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    th {
        background: #0078d7;
        color: white;
        text-align: center;
        padding: 10px;
    }

    td {
        text-align: center;
        padding: 10px;
        border-bottom: 1px solid #eee;
    }

    tr:hover {
        background-color: #f1f8ff;
        transition: 0.2s;
    }

    .action-links a {
        text-decoration: none;
        color: #0078d7;
        font-weight: 500;
        margin: 0 4px;
    }

    .action-links a:hover {
        text-decoration: underline;
    }

    p.total {
        margin-top: 15px;
        font-weight: 600;
        text-align: right;
        color: #333;
    }

    /* --- Phân trang --- */
    .pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 8px;
        margin-top: 20px;
    }

    .pagination a {
        padding: 6px 12px;
        text-decoration: none;
        border: 1px solid #0078d7;
        color: #0078d7;
        border-radius: 6px;
        transition: 0.2s;
        font-weight: 500;
    }

    .pagination a:hover {
        background: #0078d7;
        color: white;
    }

    .pagination .active {
        background: #0078d7;
        color: white;
        pointer-events: none;
    }

    /* --- Responsive --- */
    @media (max-width: 900px) {
        table, thead, tbody, th, td, tr {
            display: block;
        }

        th {
            display: none;
        }

        td {
            text-align: right;
            padding-left: 50%;
            position: relative;
        }

        td::before {
            content: attr(data-label);
            position: absolute;
            left: 15px;
            width: 45%;
            text-align: left;
            font-weight: bold;
            color: #0078d7;
        }
    }
</style>

<h1>Danh sách chuyến xe</h1>

<div class="top-bar">
    <h2>Quản lý chuyến</h2>
    <a href="TripServlet?action=add" class="add-btn">➕ Tạo chuyến mới</a>
</div>

<form class="search-form" action="TripServlet" method="get">
    <input type="hidden" name="action" value="search">
    
    <label>Lọc theo:</label>
    <select name="filter">
        <option value="">-- Chọn --</option>
        <option value="tripId" ${param.filter == 'tripId' ? 'selected' : ''}>Mã chuyến</option>
        <option value="busId" ${param.filter == 'busId' ? 'selected' : ''}>Mã xe buýt</option>
        <option value="routeId" ${param.filter == 'routeId' ? 'selected' : ''}>Mã tuyến</option>
        <option value="driverId" ${param.filter == 'driverId' ? 'selected' : ''}>Tài xế</option>
        <option value="conductorId" ${param.filter == 'conductorId' ? 'selected' : ''}>Phụ xe</option>
    </select>

    <label>Tìm kiếm:</label>
    <input type="text" name="search" value="${param.search}" placeholder="Nhập từ khóa...">

    <label>Sắp xếp:</label>
    <select name="sort">
        <option value="">-- Không --</option>
        <option value="asc" ${param.sort == 'asc' ? 'selected' : ''}>Tăng dần</option>
        <option value="desc" ${param.sort == 'desc' ? 'selected' : ''}>Giảm dần</option>
    </select>

    <button type="submit">Tìm</button>
</form>

<c:choose>
    <c:when test="${empty trips}">
        <p style="text-align:center; color:#777; font-style:italic;">Không có chuyến xe nào để hiển thị.</p>
    </c:when>
    <c:otherwise>
        <table>
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Mã chuyến</th>
                    <th>Mã tuyến</th>
                    <th>Mã xe buýt</th>
                    <th>Tài xế</th>
                    <th>Phụ xe</th>
                    <th>Giờ khởi hành</th>
                    <th>Giờ kết thúc</th>
                    <th>Trạng thái</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="index" value="1" />
                <c:forEach var="t" items="${trips}">
                    <tr>
                        <td data-label="STT">${index}</td>
                        <td data-label="Mã chuyến">${t.tripId}</td>
                        <td data-label="Mã tuyến">${t.routeId}</td>
                        <td data-label="Mã xe buýt">${t.busId}</td>
                        <td data-label="Tài xế">${t.driverId}</td>
                        <td data-label="Phụ xe">${t.conductorId}</td>
                        <td data-label="Giờ khởi hành"><fmt:formatDate value="${t.departureTime}" pattern="HH:mm:ss"/></td>
                        <td data-label="Giờ kết thúc"><fmt:formatDate value="${t.arrivalTime}" pattern="HH:mm:ss"/></td>
                        <td data-label="Trạng thái">
                            <c:choose>
                                <c:when test="${t.status eq 'IN_PROGRESS'}"><span style="color:#e69138;font-weight:600;">Đang chạy</span></c:when>
                                <c:when test="${t.status eq 'COMPLETED'}"><span style="color:#6aa84f;font-weight:600;">Hoàn thành</span></c:when>
                                <c:otherwise><span style="color:#999;">Chưa bắt đầu</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="action-links" data-label="Hành động">
                            <a href="TripServlet?action=detail&tripId=${t.tripId}">Chi tiết</a> |
                            <a href="TripServlet?action=edit&tripId=${t.tripId}">Sửa</a> |
                            <a href="TripServlet?action=delete&tripId=${t.tripId}" 
                               onclick="return confirm('Bạn có chắc muốn xóa chuyến này không?')">Xóa</a>
                        </td>
                    </tr>
                    <c:set var="index" value="${index + 1}" />
                </c:forEach>
            </tbody>
        </table>
        <p class="total">Tổng số chuyến: <strong>${total}</strong></p>

        <!-- Phân trang -->
        <c:if test="${total > 0}">
            <c:set var="pageSize" value="10" />
            <c:set var="totalPages" value="${(total + pageSize - 1) / pageSize}" />
            <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />

            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="TripServlet?page=${currentPage - 1}&action=list&search=${param.search}&filter=${param.filter}&sort=${param.sort}">«</a>
                </c:if>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <a href="TripServlet?page=${i}&action=list&search=${param.search}&filter=${param.filter}&sort=${param.sort}" 
                       class="${i == currentPage ? 'active' : ''}">${i}</a>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="TripServlet?page=${currentPage + 1}&action=list&search=${param.search}&filter=${param.filter}&sort=${param.sort}">»</a>
                </c:if>
            </div>
        </c:if>
    </c:otherwise>
</c:choose>

<%@ include file="footer.jsp" %>
