<%-- 
    Document   : RouteList
    Created on : Oct 14, 2025, 7:11:36 PM
    Author     : Admin
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, RouteModule.model.Route" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách tuyến xe buýt</title>
        <style>
            body {
                font-family: 'Segoe UI', Arial, sans-serif;
                background: #eef2f6;
                margin: 0;
                padding: 0;
                color: #333;
            }

            h2 {
                text-align: center;
                color: #222;
                margin-top: 20px;
                letter-spacing: 0.5px;
            }

            .container {
                width: 90%;
                max-width: 1100px;
                margin: 30px auto;
                background: #fff;
                padding: 25px 30px;
                border-radius: 14px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                transition: box-shadow 0.3s ease;
            }

            .container:hover {
                box-shadow: 0 6px 25px rgba(0, 0, 0, 0.12);
            }

            .search-box {
                margin-bottom: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .search-box input[type="text"] {
                width: 250px;
                padding: 8px 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                outline: none;
                transition: all 0.3s ease;
            }

            .search-box input[type="text"]:focus {
                border-color: #007bff;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.4);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
                border-radius: 10px;
                overflow: hidden;
            }

            th, td {
                padding: 12px 14px;
                text-align: center;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #007bff;
                color: #fff;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-size: 14px;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #eef6ff;
                transition: background-color 0.25s ease;
            }

            .btn {
                padding: 7px 14px;
                border: none;
                border-radius: 6px;
                text-decoration: none;
                font-size: 14px;
                cursor: pointer;
                transition: all 0.3s ease;
                display: inline-block;
            }

            .btn-add {
                background: #28a745;
                color: white;
            }

            .btn-add:hover {
                background: #218838;
            }

            .btn-edit {
                background: #ffc107;
                color: #000;
            }

            .btn-edit:hover {
                background: #e0a800;
            }

            .btn-delete {
                background: #dc3545;
                color: white;
            }

            .btn-delete:hover {
                background: #c82333;
            }

            .pagination {
                text-align: center;
                margin-top: 25px;
            }

            .pagination a {
                text-decoration: none;
                color: #007bff;
                padding: 8px 12px;
                border: 1px solid #007bff;
                margin: 0 3px;
                border-radius: 6px;
                transition: all 0.3s ease;
            }

            .pagination a:hover {
                background: #007bff;
                color: #fff;
            }

            .pagination a.active {
                background: #007bff;
                color: white;
                pointer-events: none;
            }
        </style>

    </head>
    <body>

        <div class="container">
            <h2>📋 Danh sách tuyến xe buýt</h2>

            <div class="search-box">
                <form action="RouteServlet" method="get">
                    <input type="hidden" name="action" value="list">
                    <input type="text" name="search" placeholder="Tìm theo tên..." value="<%= request.getAttribute("search") == null ? "" : request.getAttribute("search") %>">
                    <button type="submit" class="btn btn-add">Tìm kiếm</button>
                </form>
                <a href="RouteServlet?action=add" class="btn btn-add">+ Thêm tuyến</a>
            </div>

            <%
                List<Route> routes = (List<Route>) request.getAttribute("listRoutes");
                if (routes == null || routes.isEmpty()) {
            %>
            <p>Không có tuyến đường nào.</p>
            <%
                } else {
            %>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Tên tuyến</th>
                    <th>Loại tuyến</th>
                    <th>Tần suất (phút)</th>
                    <th>Hành động</th>
                </tr>
                <%
                    for (Route r : routes) {
                %>
                <tr>
                    <td><%= r.getRouteId() %></td>
                    <td><%= r.getRouteName() %></td>
                    <td><%= r.getType() %></td>
                    <td><%= r.getFrequency() %></td>
                    <td>
                        <a href="RouteServlet?action=details&id=<%= r.getRouteId() %>" class="btn btn-add">Chi tiết</a>
                        <a href="RouteServlet?action=edit&id=<%= r.getRouteId() %>" class="btn btn-edit">Sửa</a>
                        <a href="RouteServlet?action=delete&id=<%= r.getRouteId() %>"
                           class="btn btn-delete"
                           onclick="return confirm('Bạn có chắc muốn xóa tuyến này không?');">Xóa</a>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
            <%
                }
            %>

            <!-- Phân trang -->
            <%
                Integer currentPageObj = (Integer) request.getAttribute("currentPage");
                Integer totalPagesObj = (Integer) request.getAttribute("totalPages");

                int currentPage = (currentPageObj != null) ? currentPageObj : 1;
                int totalPages = (totalPagesObj != null) ? totalPagesObj : 1;

                if (totalPages > 1) {
            %>
            <div class="pagination">
                <%
                    for (int i = 1; i <= totalPages; i++) {
                        if (i == currentPage) {
                %>
                <a href="RouteServlet?action=list&page=<%= i %>" class="active"><%= i %></a>
                <%
                        } else {
                %>
                <a href="RouteServlet?action=list&page=<%= i %>"><%= i %></a>
                <%
                        }
                    }
                %>
            </div>
            <%
                }
            %>
        </div>
    </body>
</html>

