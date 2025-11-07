<%-- 
    Document   : TicketHistory
    Created on : Nov 2, 2025, 10:57:42 PM
    Author     : Tham
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Lịch Sử Vé</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 40px;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ccc;
                padding: 8px;
                text-align: center;
            }
            th {
                background-color: #4CAF50;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            .error {
                color: red;
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            a.button {
                text-decoration: none;
                background: #4CAF50;
                color: white;
                padding: 6px 12px;
                border-radius: 6px;
            }
            a.button:hover {
                background: #45a049;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <h2>Lịch Sử Vé</h2>
            <a href="TicketServlet?action=sell" class="button">← Quay lại bán vé</a>
        </div>

        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>

        <c:if test="${empty tickets}">
            <p>Không có vé nào được tìm thấy.</p>
        </c:if>

        <c:if test="${not empty tickets}">
            <table>
                <thead>
                    <tr>
                        <th>Mã Vé</th>
                        <th>Khách Hàng</th>
                        <th>Giá</th>
                        <th>Ngày Mua</th>
                        <th>Ngày Hết Hạn</th>
                        <th>Loại Vé</th>
                        <th>Người Tạo</th>
                        <th>Mã Hóa Đơn</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="t" items="${tickets}">
                        <tr>
                            <td>${t.ticketId}</td>
                            <td>${t.customerId}</td>
                            <td>${t.price}</td>
                            <td>${t.issueDate}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${t.expiryDate != null}">${t.expiryDate}</c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${t.routeId != 0}">Vé Tháng</c:when>
                                    <c:otherwise>Vé Lượt</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${t.createdBy}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${t.invoiceId != null}">${t.invoiceId}</c:when>
                                    <c:otherwise>-</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </body>
</html>