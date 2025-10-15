<%-- 
    Document   : RouteAdd
    Created on : Oct 15, 2025, 1:15:28 PM
    Author     : Admin
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm Tuyến Đường</title>
        <style>
            body {
                font-family: "Segoe UI", Arial, sans-serif;
                background: #f4f6f9;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 600px;
                margin: 60px auto;
                background: #fff;
                padding: 35px 40px;
                border-radius: 12px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            h2 {
                text-align: center;
                color: #007bff;
                margin-bottom: 25px;
            }

            label {
                font-weight: 600;
                display: block;
                margin-bottom: 6px;
                color: #333;
            }

            input[type="text"], input[type="number"], select {
                width: 100%;
                padding: 10px;
                border-radius: 6px;
                border: 1px solid #ccc;
                margin-bottom: 15px;
                font-size: 15px;
                transition: 0.3s;
            }

            input:focus, select:focus {
                border-color: #007bff;
                outline: none;
            }

            .btn {
                padding: 10px 16px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 15px;
                text-decoration: none;
                margin-right: 5px;
                transition: 0.3s;
            }

            .btn-submit {
                background: #28a745;
                color: white;
            }

            .btn-cancel {
                background: #6c757d;
                color: white;
            }

            .btn:hover {
                opacity: 0.9;
            }

            .error {
                color: red;
                font-size: 14px;
                text-align: center;
                margin-bottom: 10px;
            }

        </style>
    </head>
    <body>
        <div class="container">
            <h2>Thêm Tuyến Đường Mới</h2>

            <% 
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) { 
            %>
            <div class="error"><%= errorMessage %></div>
            <% } %>

            <form action="RouteServlet?action=add" method="post">
                <label for="routeName">Tên tuyến đường:</label>
                <input type="text" id="routeName" name="routeName" required placeholder="Nhập tên tuyến đường">

                <label for="type">Loại tuyến:</label>
                <select id="type" name="type" required>
                    <option value="">-- Chọn loại tuyến --</option>
                    <option value="CIRCULAR">CIRCULAR</option>
                    <option value="ROUND_TRIP">ROUND_TRIP</option>
                </select>
                <label for="frequency">Tần suất (chuyến/ngày):</label>
                <input type="number" id="frequency" name="frequency" min="1" required placeholder="Nhập tần suất">
                <div style="text-align: center; margin-top: 20px;">
                    <button type="submit" class="btn btn-submit">➕ Thêm tuyến</button>
                    <a href="RouteServlet?action=list" class="btn btn-cancel">⬅ Quay lại</a>
                </div>
            </form>
        </div>
    </body>
</html>

