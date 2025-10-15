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
            /* Full màn hình và scroll */
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                overflow-y: auto; /* Cho phép vuốt dọc */
            }

            .container {
                min-height: 100%;
                padding: 20px 40px;
                display: flex;
                flex-direction: column;
            }

            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }

            /* Toolbar */
            .toolbar {
                display: flex;
                align-items: center;
                justify-content: space-between;
                flex-wrap: wrap;
                gap: 15px;
                margin-bottom: 20px;
            }

            .toolbar a.button {
                background-color: #4CAF50;
                color: white;
                padding: 8px 15px;
                border-radius: 5px;
                text-decoration: none;
                text-align: center;
                font-weight: bold;
            }

            .toolbar form {
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .toolbar input[type="text"], .toolbar select {
                padding: 8px 10px;
                border-radius: 5px;
                border: 1px solid #ccc;
                outline: none;
            }

            .toolbar button {
                padding: 8px 15px;
                border-radius: 5px;
                border: 1px solid #4CAF50;
                background-color: #4CAF50;
                color: white;
                cursor: pointer;
                font-weight: bold;
            }

            .toolbar .sort-btn {
                border: 1px solid #2196F3;
                background-color: #2196F3;
            }

            /* Table full width */
            table {
                width: 100%;
                border-collapse: collapse;
                background-color: white;
            }

            table, th, td {
                border: 1px solid #ccc;
            }

            th, td {
                padding: 12px;
                text-align: center;
            }

            th {
                background-color: #f2f2f2;
            }

            a.button.action {
                text-decoration: none;
                padding: 5px 10px;
                border-radius: 4px;
                color: white;
                font-weight: bold;
            }

            a.button.edit {
                background-color: #4CAF50;
            }
            a.button.delete {
                background-color: #f44336;
            }
            a.button.assign {
                background-color: #2196F3;
            }

            /* Phân trang */
            .pagination {
                margin-top: 20px;
                text-align: center;
            }

            .pagination a {
                margin: 0 5px;
                text-decoration: none;
                padding: 5px 10px;
                border: 1px solid #333;
                border-radius: 4px;
                color: #333;
            }

            .pagination a.current {
                background-color: #4CAF50;
                color: white;
            }

            /* Cho bảng vuốt dọc nếu quá dài */
            .table-wrapper {
                flex-grow: 1; /* chiếm phần còn lại */
                overflow-y: auto;
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
