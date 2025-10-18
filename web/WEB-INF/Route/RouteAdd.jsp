<%-- 
    Document   : RouteAdd
    Created on : Oct 18, 2025, 12:21:03 PM
    Author     : Admin
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Thêm Tuyến Mới</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f5f7fa;
                margin: 0;
                padding: 0;
            }
            .container {
                width: 60%;
                margin: 50px auto;
                background: #fff;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 0 8px rgba(0,0,0,0.1);
            }
            h2 {
                text-align: center;
                color: #333;
            }
            form {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }
            input, select, button {
                padding: 10px;
                font-size: 15px;
            }
            button {
                background: #28a745;
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
            }
            button:hover {
                background: #218838;
            }
            a {
                text-decoration: none;
                color: #555;
            }
            .message, .errorMessage {
                text-align: center;
                padding: 12px;
                border-radius: 8px;
                margin-bottom: 15px;
                animation: fadeIn 0.5s;
            }
            .message {
                background: #d4edda;
                color: #155724;
            }
            .errorMessage {
                background: #f8d7da;
                color: #721c24;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-5px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>➕ Thêm Tuyến Mới</h2>
            <%
                String message = (String) session.getAttribute("message");
                String error = (String) request.getAttribute("errorMessage");
                if (message != null) {
            %>
            <div class="message"><%= message %></div>
            <%
                    session.removeAttribute("message");
                }
                if (error != null) {
            %>
            <div class="errorMessage"><%= error %></div>
            <%
                }
            %>
            <form action="RouteServlet?action=add" method="post">
                <label>Tên tuyến:</label>
                <input type="text" name="routeName" required>
                <label>Loại tuyến:</label>
                <select name="type" required>
                    <option value="">-- Chọn loại --</option>
                    <option value="CIRCULAR">CIRCULAR</option>
                    <option value="ROUND_TRIP">ROUND_TRIP</option>
                </select>
                <label>Tần suất (chuyến/ngày):</label>
                <input type="number" name="frequency" min="1" required>
                <button type="submit">Thêm Tuyến</button>
                <a href="RouteServlet?action=list">⬅ Quay lại danh sách</a>
            </form>
        </div>
    </body>
</html>
