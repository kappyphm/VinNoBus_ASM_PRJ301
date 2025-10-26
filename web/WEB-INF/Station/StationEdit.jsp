<%-- 
    Document   : updateStation
    Created on : Oct 26, 2025, 2:04:06 PM
    Author     : Admin
--%>
<%@ page import="StationModule.model.Station" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Cập nhật trạm</title>
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
        <h2>Cập nhật thông tin trạm</h2>

        <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>

        <%
            Station s = (Station) request.getAttribute("station");
            if (s != null) {
        %>
        <form action="StationServlet" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="stationId" value="<%= s.getStationId() %>">

            <label>Tên trạm:</label>
            <input type="text" name="stationName" value="<%= s.getStationName() %>" required>

            <label>Vị trí:</label>
            <input type="text" name="location" value="<%= s.getLocation() %>" required>

            <label>Giờ mở cửa:</label>
            <input type="time" name="openTime" value="<%= s.getOpenTime() %>">

            <label>Giờ đóng cửa:</label>
            <input type="time" name="closeTime" value="<%= s.getCloseTime() %>">

            <button type="submit">Cập nhật</button>
            <a href="StationServlet?action=list">Hủy</a>
        </form>
        <% } else { %>
        <p class="error">Không có dữ liệu để chỉnh sửa.</p>
        <a href="StationServlet?action=list">Quay lại</a>
        <% } %>
    </body>
</html>
