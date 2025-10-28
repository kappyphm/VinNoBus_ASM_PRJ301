<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/header.jsp" />

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách tuyến xe buýt</title>
        <style>
            /* Giữ nguyên toàn bộ style gốc */
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
        </style>
    </head>
    <body>
        <div class="container">
            <h2>📋 Danh sách tuyến xe buýt</h2>

            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error">${errorMessage}</div>
            </c:if>

            <div class="toolbar">
                <a href="RouteServlet?action=add" class="button">+ Thêm tuyến</a>
                <form action="RouteServlet" method="get">
                    <input type="hidden" name="action" value="list">
                    <input type="text" name="search" placeholder="Tìm theo tên..." value="${search}">
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
                    <c:choose>
                        <c:when test="${not empty listRoutes}">
                            <c:forEach var="r" items="${listRoutes}">
                                <tr>
                                    <td>${r.routeId}</td>
                                    <td>${r.routeName}</td>
                                    <td>${r.type}</td>
                                    <td>${r.frequency}</td>
                                    <td>
                                        <a href="RouteServlet?action=details&id=${r.routeId}" class="action detail">📄 Chi tiết</a>
                                        <a href="RouteServlet?action=edit&id=${r.routeId}" class="action edit">✏️ Sửa</a>
                                        <a href="RouteServlet?action=delete&id=${r.routeId}" class="action delete"
                                           onclick="return confirm('Bạn có chắc muốn xóa tuyến này không?');">🗑️ Xóa</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="5">Không có tuyến nào.</td></tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>

            <c:if test="${totalPages > 1}">
                <div class="pagination">
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <a class="current" href="#">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="RouteServlet?action=list&page=${i}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </body>
    <jsp:include page="/footer.jsp" />
</html>
