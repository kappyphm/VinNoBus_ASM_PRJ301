<%-- 
    Document   : BusList.jsp
    Created on : Oct 14, 2025, 7:58:57 AM
    Author     : Admin
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>Danh sách Bus</title>
        <style>
            body {
                font-family: "Segoe UI", Arial, sans-serif;
                background-color: #f5f7fa;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 85%;
                margin: 40px auto;
                background: #fff;
                padding: 25px 40px;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            }

            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            .toolbar {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                gap: 10px;
            }

            .toolbar form {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .toolbar input[type="text"],
            .toolbar select {
                padding: 8px 10px;
                border: 1px solid #ccc;
                border-radius: 8px;
                font-size: 14px;
                text-align: center; /* Căn giữa text trong ô */
            }

            .button, button {
                background: #3498db;
                color: white;
                padding: 8px 14px;
                border: none;
                border-radius: 8px;
                text-decoration: none;
                cursor: pointer;
                font-size: 14px;
                transition: 0.2s;
                text-align: center; /* Căn giữa text trong nút */
            }

            .button:hover, button:hover {
                background: #2176b5;
            }

            .sort-btn {
                background-color: #16a085;
            }

            .sort-btn:hover {
                background-color: #12876f;
            }

            .table-wrapper {
                overflow-x: auto;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
                text-align: center; /* Căn giữa text trong bảng */
            }

            th, td {
                border-bottom: 1px solid #eee;
                padding: 10px;
                vertical-align: middle;
            }

            th {
                background: #3498db;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .action {
                padding: 6px 12px;
                margin: 0 4px;
                border-radius: 6px;
                font-size: 13px;
                text-align: center; /* Căn giữa text trong nút hành động */
            }

            .action.edit {
                background-color: #f39c12;
            }

            .action.edit:hover {
                background-color: #d68910;
            }

            .action.delete {
                background-color: #e74c3c;
            }

            .action.delete:hover {
                background-color: #c0392b;
            }

            .action.assign {
                background-color: #2ecc71;
            }

            .action.assign:hover {
                background-color: #27ae60;
            }

            .pagination {
                text-align: center;
                margin-top: 25px;
            }

            .pagination a {
                display: inline-block;
                padding: 8px 12px;
                margin: 3px;
                text-decoration: none;
                color: #3498db;
                border: 1px solid #3498db;
                border-radius: 6px;
                transition: 0.2s;
                text-align: center; /* Căn giữa số trang */
            }

            .pagination a:hover {
                background-color: #3498db;
                color: white;
            }

            .pagination .current {
                background-color: #3498db;
                color: white;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Danh sách Bus</h2>

            <div class="toolbar">
                <a class="button" href="BusServlet?action=add">+ Thêm Xe Bus</a>

                <form method="get" action="BusServlet">
                    <input type="hidden" name="action" value="list"/>
                    <input type="text" name="search" value="${param.search}" placeholder="Nhập biển số..."/>
                    <button type="submit">Tìm kiếm</button>
                </form>

                <form method="get" action="BusServlet">
                    <input type="hidden" name="action" value="list"/>
                    <select name="sort">
                        <option value="bus_id ASC" ${param.sort == 'bus_id ASC' ? 'selected' : ''}>ID tăng dần</option>
                        <option value="bus_id DESC" ${param.sort == 'bus_id DESC' ? 'selected' : ''}>ID giảm dần</option>
                        <option value="plate_number ASC" ${param.sort == 'plate_number ASC' ? 'selected' : ''}>Biển số A-Z</option>
                        <option value="plate_number DESC" ${param.sort == 'plate_number DESC' ? 'selected' : ''}>Biển số Z-A</option>
                        <option value="capacity ASC" ${param.sort == 'capacity ASC' ? 'selected' : ''}>Dung lượng tăng</option>
                        <option value="capacity DESC" ${param.sort == 'capacity DESC' ? 'selected' : ''}>Dung lượng giảm</option>
                    </select>
                    <button type="submit" class="sort-btn">Sắp xếp</button>
                </form>
            </div>

            <div class="table-wrapper">
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Biển số</th>
                        <th>Số chỗ ngồi</th>
                        <th>Hành động</th>
                    </tr>
                    <c:forEach var="bus" items="${busList}">
                        <tr>
                            <td>${bus.busId}</td>
                            <td>${bus.plateNumber}</td>
                            <td>${bus.capacity}</td>
                            <td>
                                <a class="button action edit" href="BusServlet?action=edit&id=${bus.busId}">Edit</a>
                                <a class="button action delete" href="BusServlet?action=delete&id=${bus.busId}" onclick="return confirm('Bạn có chắc muốn xóa?');">Delete</a>
                                <a class="button action assign" href="BusServlet?action=assign&id=${bus.busId}">Assign</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

            <div class="pagination">
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <a class="current" href="BusServlet?action=list&page=${i}&search=${param.search}&sort=${param.sort}">${i}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="BusServlet?action=list&page=${i}&search=${param.search}&sort=${param.sort}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
        </div>
    </body>
</html>
