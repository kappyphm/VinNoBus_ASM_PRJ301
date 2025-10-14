<%-- 
    Document   : BusAdd
    Created on : Oct 14, 2025, 8:01:23 AM
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    <head>
        <title>Thêm Xe Bus Mới</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 30px;
                background-color: #f9f9f9;
            }

            h2 {
                color: #333;
            }

            form {
                background-color: white;
                padding: 20px;
                border-radius: 10px;
                width: 400px;
                box-shadow: 0 0 8px rgba(0,0,0,0.1);
            }

            label {
                display: block;
                margin-top: 10px;
                font-weight: bold;
            }

            input[type="text"],
            input[type="number"] {
                width: 95%;
                padding: 8px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            button {
                background-color: #4CAF50;
                color: white;
                padding: 10px 18px;
                border: none;
                border-radius: 5px;
                margin-top: 15px;
                cursor: pointer;
            }

            button:hover {
                background-color: #45a049;
            }

            a {
                display: inline-block;
                margin-top: 15px;
                text-decoration: none;
                color: #333;
            }

            .message {
                color: green;
                margin-bottom: 15px;
            }

            .error {
                color: red;
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>

        <h2>Thêm Xe Bus Mới</h2>

        <!-- Hiển thị thông báo -->
        <c:if test="${not empty message}">
            <div class="message">${message}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <form action="BusServlet" method="post">
            <input type="hidden" name="action" value="add">

            <label>Biển số xe:</label>
            <input type="text" name="plate_number" placeholder="VD: 29B-123.45" required>

            <label>Sức chứa:</label>
            <input type="number" name="capacity" placeholder="VD: 40" min="1" required>

            <button type="submit">Thêm Xe Bus</button>
            <a href="BusServlet?action=list">← Quay lại danh sách</a>
        </form>

    </body>
</html>
