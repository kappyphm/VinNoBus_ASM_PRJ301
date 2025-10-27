<%-- 
    Document   : addStation
    Created on : Oct 26, 2025, 2:03:32 PM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm trạm mới</title>
        <style>
            body {
                font-family: 'Segoe UI';
                margin: 40px;
            }
            label {
                display: block;
                margin-top: 10px;
            }
            input {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
            }
            button {
                margin-top: 15px;
                padding: 8px 16px;
            }
            .error {
                color: red;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <h2>Thêm trạm mới</h2>

        <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>

        <form action="StationServlet" method="post">
            <input type="hidden" name="action" value="create">

            <label>Tên trạm:</label>
            <input type="text" name="stationName" required>

            <label>Vị trí:</label>
            <input type="text" name="location" required>

            <label>Giờ mở cửa:</label>
            <input type="time" name="openTime">

            <label>Giờ đóng cửa:</label>
            <input type="time" name="closeTime">

            <button type="submit">Thêm trạm</button>
            <a href="StationServlet?action=list">Hủy</a>
        </form>
    </body>
</html>
