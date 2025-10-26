<%-- 
    Document   : stationList
    Created on : Oct 26, 2025, 1:53:42 PM
    Author     : Admin
--%>
<%@ page import="java.util.*, StationModule.model.Station" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Danh sách trạm</title>
        <style>
            body {
                font-family: 'Segoe UI';
                margin: 30px;
            }
            h2 {
                color: #0078D7;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ccc;
                padding: 8px;
            }
            th {
                background-color: #0078D7;
                color: white;
            }
            a {
                text-decoration: none;
                color: #0078D7;
            }
            a:hover {
                text-decoration: underline;
            }
            .error {
                color: red;
                font-weight: bold;
            }
            .message {
                color: green;
            }
        </style>
    </head>
    <body>
        <h2>Danh sách trạm xe buýt</h2>

        <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
        <% } else if (request.getAttribute("message") != null) { %>
        <p class="message"><%= request.getAttribute("message") %></p>
        <% } %>

        <p><a href="StationServlet?action=new">+ Thêm trạm mới</a></p>

        <table>
            <tr>
                <th>ID</th>
                <th>Tên trạm</th>
                <th>Vị trí</th>
                <th>Giờ mở cửa</th>
                <th>Giờ đóng cửa</th>
                <th>Tuyến đi qua</th>
                <th>Thao tác</th>
            </tr>
            <%
                List<Station> stations = (List<Station>) request.getAttribute("stations");
                if (stations != null && !stations.isEmpty()) {
                    for (Station s : stations) {
            %>
            <tr>
                <td><%= s.getStationId() %></td>
                <td><%= s.getStationName() %></td>
                <td><%= s.getLocation() %></td>
                <td><%= s.getOpenTime() %></td>
                <td><%= s.getCloseTime() %></td>
                <td><%= s.getRouteNames() != null ? String.join(", ", s.getRouteNames()) : "" %></td>
                <td>
                    <a href="StationServlet?action=view&id=<%= s.getStationId() %>">Xem</a> |
                    <a href="StationServlet?action=edit&id=<%= s.getStationId() %>">Sửa</a> |
                    <a href="StationServlet?action=delete&id=<%= s.getStationId() %>" onclick="return confirm('Xóa trạm này?');">Xóa</a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr><td colspan="7" style="text-align:center;">Không có dữ liệu</td></tr>
            <% } %>
        </table>
    </body>
</html>

