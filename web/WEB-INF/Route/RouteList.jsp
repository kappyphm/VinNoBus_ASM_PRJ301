<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, RouteModule.model.Route" %>
<jsp:include page="/header.jsp" />

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách tuyến xe buýt</title>
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

            body {
                font-family: "Segoe UI", Arial, sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #eaf1f9 100%);
                margin: 0;
                padding: 0;
                animation: fadeSlideUp 0.5s ease;
            }

            .container {
                width: 90%;
                max-width: 1200px;
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

            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 35px;
                font-size: 28px;
                letter-spacing: 1px;
                font-weight: 600;
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

            .toolbar {
                display: flex;
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

            .toolbar input[type="text"] {
                padding: 10px 14px;
                border: 1px solid #ccc;
                border-radius: 10px;
                font-size: 14px;
                transition: 0.3s;
                background: #f9f9f9;
                text-align: center;
            }

            .toolbar input[type="text"]:focus {
                border-color: #3498db;
                box-shadow: 0 0 8px rgba(52,152,219,0.3);
                background: #fff;
                outline: none;
            }

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

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            tr:hover {
                background-color: #eaf4fd;
                transform: scale(1.01);
                box-shadow: 0 2px 10px rgba(52,152,219,0.15);
                transition: all 0.25s ease;
            }

            .action {
                padding: 6px 12px;
                margin: 0 2px;
                border-radius: 6px;
                font-size: 13px;
                font-weight: 500;
                transition: all 0.25s ease;
                display: inline-block;
            }
            .action.detail {
                background: #3498db;
                color: #fff;
            }
            .action.detail:hover {
                background: #2176b5;
                transform: translateY(-2px);
            }

            .action.edit {
                background: #f39c12;
                color: #fff;
            }
            .action.edit:hover {
                background: #e67e22;
                transform: translateY(-2px);
            }

            .action.delete {
                background: #e74c3c;
                color: #fff;
            }
            .action.delete:hover {
                background: #c0392b;
                transform: translateY(-2px);
            }

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
            a, .button, button {
                text-decoration: none;
            }
            .action {
                text-decoration: none;
            }
            .pagination a {
                text-decoration: none;
            }
            .table-wrapper {
                overflow-x: auto;
                border-radius: 14px;
                background: #fff;
                box-shadow: 0 0 15px rgba(0,0,0,0.05);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                table-layout: auto; /* Cho cột co giãn theo nội dung */
            }

            th, td {
                padding: 12px 10px;
                font-size: 15px;
                border: 1px solid #ddd; /* Thanh chia ô */
                text-align: center;
                vertical-align: middle;
                white-space: nowrap; /* Không xuống dòng nếu nội dung ngắn */
            }

            /* Header */
            th {
                background-color: #3498db;
                color: white;
                font-weight: 600;
                text-transform: uppercase;
            }

            /* Hàng chẵn lẻ */
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #eaf4fd;
                transform: scale(1.01);
                box-shadow: 0 2px 10px rgba(52,152,219,0.15);
            }

            /* Nút trong bảng */
            .action {
                padding: 6px 12px;
                margin: 0 2px;
                border-radius: 6px;
                font-size: 13px;
                font-weight: 500;
                transition: all 0.25s ease;
                display: inline-block;
                text-decoration: none; /* Bỏ gạch chân */
            }

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

            .action.detail {
                background: #3498db;
                color: white;
            }
            .action.detail:hover {
                background: #2176b5;
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
            td .action {
                display: inline-flex;
                align-items: center;
                gap: 6px; /* Khoảng cách giữa emoji và chữ */
            }

        </style>
    </head>
    <body>
        <div class="container">
            <h2>📋 Danh sách tuyến xe buýt</h2>

            <%-- Hiển thị thông báo --%>
            <%
                String message = (String) session.getAttribute("message");
                String errorMessage = (String) session.getAttribute("errorMessage");
                if (message == null) message = (String) request.getAttribute("message");
                if (errorMessage == null) errorMessage = (String) request.getAttribute("errorMessage");
                if (message != null) { %>
            <div class="alert alert-success"><%= message %></div>
            <% session.removeAttribute("message"); }
       if (errorMessage != null) { %>
            <div class="alert alert-error"><%= errorMessage %></div>
            <% session.removeAttribute("errorMessage"); } %>

            <div class="toolbar">
                <a href="RouteServlet?action=add" class="button">+ Thêm tuyến</a>
                <form action="RouteServlet" method="get">
                    <input type="hidden" name="action" value="list">
                    <input type="text" name="search" placeholder="Tìm theo tên..." value="<%= request.getAttribute("search") != null ? request.getAttribute("search") : "" %>">
                    <button type="submit" class="button">Tìm kiếm</button>
                </form>
            </div>

            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên tuyến</th>
                            <th>Loại tuyến</th>
                            <th>Tần suất (phút)</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Route> routes = (List<Route>) request.getAttribute("listRoutes");
                            if (routes != null && !routes.isEmpty()) {
                                for (Route r : routes) {
                        %>
                        <tr>
                            <td><%= r.getRouteId() %></td>
                            <td><%= r.getRouteName() %></td>
                            <td><%= r.getType() %></td>
                            <td><%= r.getFrequency() %></td>
                            <td>
                                <a href="RouteServlet?action=details&id=<%= r.getRouteId() %>" class="action detail">📄 Chi tiết</a>
                                <a href="RouteServlet?action=edit&id=<%= r.getRouteId() %>" class="action edit">✏️ Sửa</a>
                                <a href="RouteServlet?action=delete&id=<%= r.getRouteId() %>" class="action delete"
                                   onclick="return confirm('Bạn có chắc muốn xóa tuyến này không?');">🗑️ Xóa</a>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr><td colspan="5">Không có tuyến nào.</td></tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <%-- Phân trang --%>
            <%
                Integer currentPageObj = (Integer) request.getAttribute("currentPage");
                Integer totalPagesObj = (Integer) request.getAttribute("totalPages");
                int currentPage = currentPageObj != null ? currentPageObj : 1;
                int totalPages = totalPagesObj != null ? totalPagesObj : 1;

                if (totalPages > 1) {
            %>
            <div class="pagination">
                <%
                    for (int i = 1; i <= totalPages; i++) {
                        if (i == currentPage) { %>
                <a class="current" href="#"><%= i %></a>
                <%      } else { %>
                <a href="RouteServlet?action=list&page=<%= i %>"><%= i %></a>
                <%      }
                    }
                %>
            </div>
            <% } %>
        </div>
    </body>
    <jsp:include page="/footer.jsp" />
</html>
