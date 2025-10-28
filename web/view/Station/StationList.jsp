<%-- 
    Document   : stationList
    Created on : Oct 26, 2025, 1:53:42 PM
    Author     : Admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:include page="/header.jsp" />
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách trạm</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
              integrity="sha512-p1M+Pq+3tHvJ5cWy7eohF0uUE9uoF7EN0uXY6x2iVQH+MsvZ9A4uwX9xX7d+4+Nq4U9lBLc1oxgvdYgH3Xv1sA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            /* 🌈 Hiệu ứng fade + slide mượt mà */
            @keyframes fadeSlideUp {
                from {
                    opacity:0;
                    transform: translateY(20px);
                }
                to {
                    opacity:1;
                    transform: translateY(0);
                }
            }
            body {
                font-family: "Segoe UI", Arial, sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #eaf1f9 100%);
                margin:0;
                padding:0;
                animation: fadeSlideUp 0.5s ease;
            }
            .container {
                width:95%;
                max-width:1600px;
                margin:50px auto;
                background:#fff;
                padding:40px 60px;
                border-radius:18px;
                box-shadow:0 12px 30px rgba(0,0,0,0.08);
                animation: fadeSlideUp 0.7s ease;
            }
            h2 {
                text-align:center;
                color:#2c3e50;
                margin-bottom:35px;
                font-size:30px;
                letter-spacing:1px;
                font-weight:700;
                position:relative;
            }
            h2::after {
                content:"";
                display:block;
                width:120px;
                height:4px;
                background: linear-gradient(90deg,#3498db,#2ecc71);
                margin:12px auto 0;
                border-radius:50px;
                box-shadow:0 2px 8px rgba(52,152,219,0.4);
            }
            .toolbar {
                display:flex;
                flex-wrap:wrap;
                justify-content:space-between;
                align-items:center;
                margin-bottom:25px;
                gap:12px;
                animation: fadeSlideUp 0.8s ease;
            }
            .button, button {
                background: linear-gradient(135deg,#3498db,#2ecc71);
                color:white;
                padding:10px 18px;
                border:none;
                border-radius:10px;
                cursor:pointer;
                font-size:14px;
                font-weight:500;
                box-shadow:0 4px 15px rgba(52,152,219,0.3);
                text-decoration:none;
                transition: all 0.25s ease;
            }
            .button:hover, button:hover {
                transform: translateY(-3px);
                filter: brightness(1.1);
            }
            .table-wrapper {
                overflow-x:auto;
                border-radius:14px;
                background:#fff;
                box-shadow:0 2px 15px rgba(0,0,0,0.08);
                animation: fadeSlideUp 0.9s ease;
                width:100%;
            }
            table {
                width:100%;
                border-collapse:collapse;
                text-align:center;
            }
            th, td {
                padding:14px 12px;
                border-bottom:1px solid #eee;
                font-size:15px;
            }
            th {
                background: linear-gradient(90deg,#3498db,#2980b9);
                color:white;
                font-weight:600;
                letter-spacing:0.5px;
            }
            tr {
                transition: all 0.25s ease;
            }
            tr:nth-child(even){
                background:#f9f9f9;
            }
            tr:hover {
                background:#eaf4fd;
                transform:scale(1.01);
                box-shadow:0 2px 10px rgba(52,152,219,0.15);
            }
            td {
                min-width:150px;
            }
            .action {
                padding:8px 14px;
                margin:0 4px;
                border-radius:8px;
                font-size:13px;
                font-weight:500;
                transition: all 0.25s ease;
                display:inline-block;
            }
            .action.detail {
                background:#3498db;
                color:white;
            }
            .action.detail:hover {
                background:#2176b5;
                transform:translateY(-2px);
            }
            .action.edit {
                background:#f39c12;
                color:white;
            }
            .action.edit:hover {
                background:#d68910;
                transform:translateY(-2px);
            }
            .action.delete {
                background:#e74c3c;
                color:white;
            }
            .action.delete:hover {
                background:#c0392b;
                transform:translateY(-2px);
            }
            .alert {
                padding:12px 16px;
                border-radius:8px;
                margin-bottom:15px;
                font-size:15px;
                animation: fadeSlideUp 0.7s ease;
                text-align:center;
            }
            .alert-success {
                background:#d4edda;
                color:#155724;
                border-left:5px solid #2ecc71;
            }
            .alert-error {
                background:#f8d7da;
                color:#721c24;
                border-left:5px solid #e74c3c;
            }
            a {
                text-decoration:none;
            }
            .pagination {
                text-align:center;
                margin-top:30px;
                animation: fadeSlideUp 1s ease;
            }
            .pagination a {
                display:inline-block;
                padding:8px 13px;
                margin:3px;
                text-decoration:none;
                color:#3498db;
                border:1px solid #3498db;
                border-radius:8px;
                transition:0.3s;
                font-weight:500;
            }
            .pagination a:hover {
                background-color:#3498db;
                color:white;
                transform:translateY(-3px);
                box-shadow:0 5px 10px rgba(52,152,219,0.3);
            }
            .pagination .current {
                background-color:#3498db;
                color:white;
                font-weight:600;
                box-shadow:0 3px 8px rgba(52,152,219,0.4);
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Danh sách trạm xe buýt</h2>

            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>

            <div class="toolbar">
                <a class="button" href="StationServlet?action=new">
                    <i class="fa fa-plus"></i> Thêm trạm mới
                </a>
            </div>

            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên trạm</th>
                            <th>Vị trí</th>
                            <th>Giờ mở cửa</th>
                            <th>Giờ đóng cửa</th>
                            <th>Tuyến đi qua</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${not empty stations}">
                            <c:forEach var="s" items="${stations}">
                                <tr>
                                    <td>${s.stationId}</td>
                                    <td><i class="fa fa-bus"></i> ${s.stationName}</td>
                                    <td>${s.location}</td>
                                    <td><i class="fa fa-clock"></i> ${s.openTime}</td>
                                    <td><i class="fa fa-clock"></i> ${s.closeTime}</td>
                                    <td>
                                <c:if test="${not empty s.routeNames}">
                                    <c:forEach var="r" items="${s.routeNames}" varStatus="loop">
                                        ${r}<c:if test="${!loop.last}">, </c:if>
                                    </c:forEach>
                                </c:if>
                                </td>
                                <td>
                                    <a class="action detail" href="StationServlet?action=view&id=${s.stationId}">
                                        <i class="fa fa-eye"></i> Xem
                                    </a>
                                    <a class="action edit" href="StationServlet?action=edit&id=${s.stationId}">
                                        <i class="fa fa-pen"></i> Sửa
                                    </a>
                                    <a class="action delete" href="StationServlet?action=delete&id=${s.stationId}"
                                       onclick="return confirm('Xóa trạm này?');">
                                        <i class="fa fa-trash"></i> Xóa
                                    </a>
                                </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="7">Không có dữ liệu</td></tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>

            <c:if test="${totalPages > 1}">
                <div class="pagination">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <a class="current">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="StationServlet?action=list&page=${i}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </body>
    <jsp:include page="/footer.jsp" />
</html>
