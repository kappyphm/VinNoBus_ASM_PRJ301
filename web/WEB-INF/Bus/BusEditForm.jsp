<%-- 
    Document   : BusForm
    Created on : Oct 14, 2025, 7:59:04 AM
    Author     : Admin
--%>
<%-- 
    Document   : BusEditForm
    Created on : Oct 14, 2025
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    <head>
        <title>Chỉnh sửa thông tin Xe Bus</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                padding: 0;
            }

            .container {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            .form-box {
                background-color: white;
                width: 420px;
                padding: 30px 40px;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            h2 {
                text-align: center;
                color: #1f3a93;
                margin-bottom: 25px;
            }

            label {
                display: block;
                font-weight: 500;
                color: #333;
                margin-top: 15px;
            }

            input[type="text"], input[type="number"] {
                width: 100%;
                padding: 10px 12px;
                margin-top: 6px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 15px;
                transition: border-color 0.2s;
            }

            input[type="text"]:focus, input[type="number"]:focus {
                border-color: #1f3a93;
                outline: none;
            }

            .message {
                color: green;
                text-align: center;
                margin-bottom: 10px;
            }

            .error {
                color: red;
                text-align: center;
                margin-bottom: 10px;
            }

            .actions {
                display: flex;
                justify-content: space-between;
                margin-top: 25px;
            }

            button {
                padding: 10px 18px;
                background-color: #1f3a93;
                color: white;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: 0.3s;
                font-weight: 500;
            }

            button:hover {
                background-color: #0d2b66;
            }

            a.back-btn {
                text-decoration: none;
                padding: 10px 18px;
                border: 1px solid #ccc;
                border-radius: 6px;
                color: #333;
                background-color: #f8f9fa;
                transition: 0.3s;
            }

            a.back-btn:hover {
                background-color: #e2e6ea;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <div class="form-box">
                <h2>Chỉnh sửa Xe Bus</h2>

                <c:if test="${not empty message}">
                    <div class="message">${message}</div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="error">${error}</div>
                </c:if>

                <form action="BusServlet" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="bus_id" value="${bus.busId}">

                    <label>Biển số xe:</label>
                    <input type="text" name="plate_number" value="${bus.plateNumber}" required>

                    <label>Sức chứa:</label>
                    <input type="number" name="capacity" value="${bus.capacity}" min="1" required>

                    <div class="actions">
                        <a class="back-btn" href="BusServlet?action=list">← Quay lại</a>
                        <button type="submit">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>

    </body>
</html>
