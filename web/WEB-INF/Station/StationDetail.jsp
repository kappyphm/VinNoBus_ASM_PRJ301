<%-- 
    Document   : stationDetail
    Created on : Oct 26, 2025, 1:54:30 PM
    Author     : Admin
--%>

<%@ page import="StationModule.model.Station" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết trạm</title>
        <style>
            body {
                font-family: 'Segoe UI';
                margin: 40px;
            }
            p {
                margin: 8px 0;
            }
            .error {
                color: red;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <h2>Chi tiết trạm</h2>

        <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
        <p><a href="StationServlet?action=list">Quay lại danh sách</a></p>
        <% } else {
            Station s = (Station) request.getAttribute("station");
            if (s != null) {
        %>
        <p><b>ID:</b> <%= s.getStationId() %></p>
        <p><b>Tên trạm:</b> <%= s.getStationName() %></p>
        <p><b>Vị trí:</b> <%= s.getLocation() %></p>
        <p><b>Giờ mở cửa:</b> <%= s.getOpenTime() %></p>
        <p><b>Giờ đóng cửa:</b> <%= s.getCloseTime() %></p>
        <p><b>Tuyến đi qua:</b> <%= s.getRouteNames() != null ? String.join(", ", s.getRouteNames()) : "Không có" %></p>
        <p><a href="StationServlet?action=list">← Quay lại</a></p>
        <% } else { %>
        <p class="error">Không tìm thấy thông tin trạm.</p>
        <% } } %>
    </body>
</html>
