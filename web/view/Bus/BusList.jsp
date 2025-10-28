<%-- 
    Document   : BusList.jsp
    Created on : Oct 14, 2025, 7:58:57 AM
    Author     : Admin
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/header.jsp" />

<html>
    <head>
        <title>Danh sách Bus</title>
        <style>
            /* 🌈 Hiệu ứng fade + slide mượt mà */
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

            body {
                font-family: "Segoe UI", Arial, sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #eaf1f9 100%);
                margin: 0;
                padding: 0;
                animation: fadeSlideUp 0.5s ease;
            }

            .container {
                width: 90%;
                margin: 60px auto;
                background: #fff;
                padding: 40px 50px;
                border-radius: 18px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.08);
                animation: fadeSlideUp 0.7s ease;
            }

            h2 {
                text-align: center;
                color: #333;
                margin-bottom: 35px;
                font-size: 28px;
                letter-spacing: 1px;
                position: relative;
                font-weight: 600;
            }

            h2::after {
                content: "";
                display: block;
                width: 100px;
                height: 3px;
                background: #3498db;
                margin: 12px auto 0;
                border-radius: 20px;
                box-shadow: 0 2px 6px rgba(52,152,219,0.4);
            }

            /* 🎯 Toolbar */
            .toolbar {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
                gap: 12px;
                animation: fadeSlideUp 0.8s ease;
            }

            .toolbar form {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .toolbar input[type="text"],
            .toolbar select {
                padding: 10px 14px;
                border: 1px solid #ccc;
                border-radius: 10px;
                font-size: 14px;
                transition: 0.3s;
                text-align: center;
                background: #f9f9f9;
            }

            .toolbar input[type="text"]:focus,
            .toolbar select:focus {
                border-color: #3498db;
                box-shadow: 0 0 8px rgba(52,152,219,0.3);
                background: #fff;
                outline: none;
            }

            /* ✨ Nút hành động */
            .button, button {
                background: #3498db;
                color: white;
                padding: 10px 18px;
                border: none;
                border-radius: 10px;
                text-decoration: none;
                cursor: pointer;
                font-size: 14px;
                transition: all 0.25s ease;
                text-align: center;
                font-weight: 500;
                box-shadow: 0 3px 10px rgba(52,152,219,0.3);
            }

            .button:hover, button:hover {
                background: #2176b5;
                transform: translateY(-3px);
                box-shadow: 0 6px 15px rgba(52,152,219,0.4);
            }

            .sort-btn {
                background-color: #16a085;
                box-shadow: 0 3px 10px rgba(22,160,133,0.3);
            }

            .sort-btn:hover {
                background-color: #12876f;
                transform: translateY(-3px);
                box-shadow: 0 6px 15px rgba(22,160,133,0.4);
            }

            /* 🧾 Bảng */
            .table-wrapper {
                overflow-x: auto;
                border-radius: 14px;
                background: #fff;
                box-shadow: 0 0 15px rgba(0,0,0,0.05);
                animation: fadeSlideUp 0.9s ease;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
                text-align: center;
            }

            th, td {
                padding: 14px 12px;
                border-bottom: 1px solid #eee;
                vertical-align: middle;
                font-size: 15px;
            }

            th {
                background: #3498db;
                color: white;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #ecf6fd;
                transform: scale(1.01);
                transition: 0.25s ease;
            }

            td {
                color: #333;
            }

            /* 🪄 Nút trong bảng */
            .action {
                padding: 8px 14px;
                margin: 0 4px;
                border-radius: 8px;
                font-size: 13px;
                display: inline-block;
                transition: all 0.25s ease;
                font-weight: 500;
            }

            .action.edit {
                background-color: #f39c12;
                color: white;
            }
            .action.edit:hover {
                background-color: #d68910;
                transform: translateY(-2px);
            }

            .action.delete {
                background-color: #e74c3c;
                color: white;
            }
            .action.delete:hover {
                background-color: #c0392b;
                transform: translateY(-2px);
            }

            .action.assign {
                background-color: #2ecc71;
                color: white;
            }
            .action.assign:hover {
                background-color: #27ae60;
                transform: translateY(-2px);
            }

            .action.detail {
                background-color: #3498db;
                color: white;
            }
            .action.detail:hover {
                background-color: #2176b5;
                transform: translateY(-2px);
            }

            /* 🔢 Phân trang */
            .pagination {
                text-align: center;
                margin-top: 30px;
                animation: fadeSlideUp 1s ease;
            }

            .pagination a {
                display: inline-block;
                padding: 8px 13px;
                margin: 3px;
                text-decoration: none;
                color: #3498db;
                border: 1px solid #3498db;
                border-radius: 8px;
                transition: 0.3s;
                font-weight: 500;
            }

            .pagination a:hover {
                background-color: #3498db;
                color: white;
                transform: translateY(-3px);
                box-shadow: 0 5px 10px rgba(52,152,219,0.3);
            }

            .pagination .current {
                background-color: #3498db;
                color: white;
                font-weight: 600;
                box-shadow: 0 3px 8px rgba(52,152,219,0.4);
            }

            /* ✅ Thông báo */
            .alert {
                padding: 12px 16px;
                border-radius: 8px;
                margin-bottom: 15px;
                font-size: 15px;
                animation: fadeSlideUp 0.7s ease;
            }

            .alert-success {
                background:#d4edda;
                color:#155724;
                border-left: 5px solid #2ecc71;
            }

            .alert-error {
                background:#f8d7da;
                color:#721c24;
                border-left: 5px solid #e74c3c;
            }
            /* 🌈 Hiệu ứng fade + slide mượt mà */
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

            body {
                font-family: "Segoe UI", Arial, sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #eaf1f9 100%);
                margin: 0;
                padding: 0;
                animation: fadeSlideUp 0.5s ease;
            }

            /* 🧩 Container chính */
            .container {
                width: 90%;
                margin: 60px auto;
                background: #fff;
                padding: 40px 50px;
                border-radius: 18px;
                box-shadow: 0 12px 30px rgba(0,0,0,0.08);
                animation: fadeSlideUp 0.7s ease;
                transition: box-shadow 0.3s ease;
            }

            .container:hover {
                box-shadow: 0 18px 40px rgba(0,0,0,0.1);
            }

            /* 🌟 Tiêu đề */
            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 35px;
                font-size: 30px;
                letter-spacing: 1px;
                font-weight: 700;
                position: relative;
            }

            h2::after {
                content: "";
                display: block;
                width: 120px;
                height: 4px;
                background: linear-gradient(90deg, #3498db, #2ecc71);
                margin: 12px auto 0;
                border-radius: 50px;
                box-shadow: 0 2px 8px rgba(52,152,219,0.4);
            }

            /* 🎯 Toolbar */
            .toolbar {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
                gap: 12px;
                animation: fadeSlideUp 0.8s ease;
            }

            .toolbar form {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .toolbar input[type="text"],
            .toolbar select {
                padding: 10px 14px;
                border: 1px solid #ccc;
                border-radius: 10px;
                font-size: 14px;
                transition: all 0.3s ease;
                background: #f9f9f9;
            }

            .toolbar input[type="text"]:focus,
            .toolbar select:focus {
                border-color: #3498db;
                box-shadow: 0 0 10px rgba(52,152,219,0.3);
                background: #fff;
                outline: none;
            }

            /* ✨ Nút hành động */
            .button, button {
                background: linear-gradient(135deg, #3498db, #2ecc71);
                color: white;
                padding: 10px 18px;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                font-size: 14px;
                transition: all 0.25s ease;
                font-weight: 500;
                box-shadow: 0 4px 15px rgba(52,152,219,0.3);
            }

            .button:hover, button:hover {
                transform: translateY(-3px);
                filter: brightness(1.1);
                box-shadow: 0 8px 20px rgba(52,152,219,0.4);
            }

            /* 🔄 Nút sắp xếp riêng */
            .sort-btn {
                background: linear-gradient(135deg, #16a085, #1abc9c);
                box-shadow: 0 4px 15px rgba(22,160,133,0.3);
            }
            .sort-btn:hover {
                filter: brightness(1.1);
                transform: translateY(-3px);
                box-shadow: 0 8px 20px rgba(22,160,133,0.4);
            }

            /* 🧾 Bảng */
            .table-wrapper {
                overflow-x: auto;
                border-radius: 14px;
                background: #fff;
                box-shadow: 0 0 15px rgba(0,0,0,0.05);
                animation: fadeSlideUp 0.9s ease;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                text-align: center;
            }

            th, td {
                padding: 14px 12px;
                border-bottom: 1px solid #eee;
                vertical-align: middle;
                font-size: 15px;
            }

            th {
                background: linear-gradient(90deg, #3498db, #2980b9);
                color: white;
                font-weight: 600;
                letter-spacing: 0.5px;
            }

            tr {
                transition: all 0.25s ease;
            }
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            tr:hover {
                background-color: #eaf4fd;
                transform: scale(1.01);
                box-shadow: 0 2px 10px rgba(52,152,219,0.15);
            }

            /* 🪄 Nút trong bảng */
            .action {
                padding: 8px 14px;
                margin: 0 4px;
                border-radius: 8px;
                font-size: 13px;
                transition: all 0.25s ease;
                font-weight: 500;
            }

            .action.edit {
                background: #f39c12;
            }
            .action.edit:hover {
                background: #e67e22;
                transform: translateY(-2px);
            }

            .action.delete {
                background: #e74c3c;
            }
            .action.delete:hover {
                background: #c0392b;
                transform: translateY(-2px);
            }

            .action.assign {
                background: #2ecc71;
            }
            .action.assign:hover {
                background: #27ae60;
                transform: translateY(-2px);
            }

            .action.detail {
                background: #3498db;
            }
            .action.detail:hover {
                background: #2176b5;
                transform: translateY(-2px);
            }

            /* 🔢 Phân trang */
            .pagination {
                text-align: center;
                margin-top: 30px;
                animation: fadeSlideUp 1s ease;
            }

            .pagination a {
                display: inline-block;
                padding: 8px 13px;
                margin: 3px;
                text-decoration: none;
                color: #3498db;
                border: 1px solid #3498db;
                border-radius: 8px;
                transition: all 0.3s;
                font-weight: 500;
            }

            .pagination a:hover {
                background-color: #3498db;
                color: white;
                transform: translateY(-3px);
                box-shadow: 0 5px 10px rgba(52,152,219,0.3);
            }

            .pagination .current {
                background-color: #3498db;
                color: white;
                font-weight: 600;
                box-shadow: 0 3px 8px rgba(52,152,219,0.4);
            }

            /* ✅ Thông báo */
            .alert {
                padding: 12px 16px;
                border-radius: 8px;
                margin-bottom: 15px;
                font-size: 15px;
                animation: fadeSlideUp 0.7s ease;
            }
            .alert-success {
                background:#d4edda;
                color:#155724;
                border-left: 5px solid #2ecc71;
            }
            .alert-error {
                background:#f8d7da;
                color:#721c24;
                border-left: 5px solid #e74c3c;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                text-align: center;
                table-layout: auto; /* Cho cột co giãn theo nội dung */
            }

            th, td {
                padding: 12px 10px;
                font-size: 15px;
                border: 1px solid #ddd;
                vertical-align: middle;
                white-space: nowrap; /* Không xuống dòng nếu nội dung ngắn */
            }

            td .action {
                display: inline-flex;
                align-items: center;
                gap: 6px; /* Khoảng cách icon và chữ */
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #eaf4fd;
                transform: scale(1.01);
                box-shadow: 0 2px 10px rgba(52,152,219,0.15);
            }

            /* Các nút hành động trong ô */
            .action {
                padding: 6px 12px;
                margin: 0 2px;
                border-radius: 6px;
                font-size: 13px;
                font-weight: 500;
                transition: all 0.25s ease;
                display: inline-block;
            }

            /* Màu nút */
            .action.edit {
                background: #f39c12;
                color: white;
            }
            .action.edit:hover {
                background: #e67e22;
                transform: translateY(-2px);
            }
            .action.delete {
                background: #e74c3c;
                color: white;
            }
            .action.delete:hover {
                background: #c0392b;
                transform: translateY(-2px);
            }
            .action.assign {
                background: #2ecc71;
                color: white;
            }
            .action.assign:hover {
                background: #27ae60;
                transform: translateY(-2px);
            }
            .action.detail {
                background: #3498db;
                color: white;
            }
            .action.detail:hover {
                background: #2176b5;
                transform: translateY(-2px);
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Danh sách Bus</h2>
            <% if (request.getAttribute("message") != null) { %>
            <div class="alert alert-success">
                <%= request.getAttribute("message") %>
            </div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <%= request.getAttribute("error") %>
            </div>
            <% } %>
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
                        <option value="capacity ASC" ${param.sort == 'capacity ASC' ? 'selected' : ''}>Chỗ ngồi tăng</option>
                        <option value="capacity DESC" ${param.sort == 'capacity DESC' ? 'selected' : ''}>Chỗ ngồi giảm</option>
                    </select>
                    <button type="submit" class="sort-btn">Sắp xếp</button>
                </form>
            </div>
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Biển số</th>
                            <th>Số chỗ ngồi</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="bus" items="${busList}">
                            <tr>
                                <td>${bus.busId}</td>
                                <td>${bus.plateNumber}</td>
                                <td>${bus.capacity}</td>
                                <td>
                                    <a class="button action edit" href="BusServlet?action=edit&id=${bus.busId}">✏️ Edit</a>
                                    <a class="button action delete" href="BusServlet?action=delete&id=${bus.busId}" onclick="return confirm('Bạn có chắc muốn xóa?');">🗑️ Delete</a>
                                    <a class="button action assign" href="BusServlet?action=assign&id=${bus.busId}">👤 Assign</a>
                                    <a class="button action detail" href="BusServlet?action=detail&id=${bus.busId}">🚍 Details</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
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
    <jsp:include page="/footer.jsp" />
</html>
