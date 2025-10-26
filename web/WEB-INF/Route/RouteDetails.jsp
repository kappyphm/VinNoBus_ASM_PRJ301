<%-- 
    Document   : RouteDetails
    Created on : Oct 15, 2025, 1:08:32 PM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="RouteModule.model.Route" %>
<%@ page import="StationModule.model.Station" %>

<%
    Route route = (Route) request.getAttribute("route");
    if (route == null) {
%>
<h3 style="text-align:center;color:red;">Không tìm thấy thông tin tuyến đường!</h3>
<%
        return;
    }
    List<Station> stations = route.getStations();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết tuyến đường</title>
        <style>
            body {
                font-family: 'Segoe UI', Arial, sans-serif;
                background: #f4f7fb;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 800px;
                margin: 50px auto;
                background: #fff;
                padding: 30px 40px;
                border-radius: 14px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            }

            h2 {
                text-align: center;
                color: #007bff;
                margin-bottom: 25px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 25px;
            }

            td, th {
                padding: 10px 12px;
                border-bottom: 1px solid #ddd;
                font-size: 15px;
            }

            td.label {
                font-weight: bold;
                color: #333;
                width: 40%;
                background: #f9fbfd;
            }

            th {
                background-color: #007bff;
                color: white;
                text-align: left;
            }

            .actions {
                text-align: center;
                margin-top: 25px;
            }

            .btn {
                padding: 10px 15px;
                border: none;
                border-radius: 6px;
                text-decoration: none;
                font-size: 15px;
                cursor: pointer;
                margin: 0 5px;
                transition: all 0.3s ease;
            }

            .btn-back {
                background: #6c757d;
                color: white;
            }

            .btn-edit {
                background: #ffc107;
                color: black;
            }

            .btn-delete {
                background: #dc3545;
                color: white;
            }

            .btn:hover {
                opacity: 0.9;
            }

            .station-table {
                margin-top: 20px;
            }

            .empty-msg {
                text-align: center;
                color: #666;
                margin-top: 10px;
                font-style: italic;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Chi tiết tuyến đường</h2>

            <table>
                <tr>
                    <td class="label">Mã tuyến đường:</td>
                    <td><%= route.getRouteId() %></td>
                </tr>
                <tr>
                    <td class="label">Tên tuyến đường:</td>
                    <td><%= route.getRouteName() %></td>
                </tr>
                <tr>
                    <td class="label">Loại tuyến:</td>
                    <td><%= route.getType() %></td>
                </tr>
                <tr>
                    <td class="label">Tần suất:</td>
                    <td><%= route.getFrequency() %> phút</td>
                </tr>
                <tr>
                    <td class="label">Tổng thời gian dự kiến:</td>
                    <td><%= route.getEstimatedTime() %> phút</td>
                </tr>
            </table>

            <h3>Danh sách trạm đi qua trong tuyến</h3>
            <% if (stations != null && !stations.isEmpty()) { %>
            <table class="station-table">
                <tr>
                    <th>Mã trạm</th>
                    <th>Tên trạm</th>
                    <th>Vị trí</th>
                    <th>Giờ mở cửa</th>
                    <th>Giờ đóng cửa</th>
                </tr>
                <% for (Station s : stations) { %>
                <tr>
                    <td><%= s.getStationId() %></td>
                    <td><%= s.getStationName() %></td>
                    <td><%= s.getLocation() %></td>
                    <td><%= s.getOpenTime() %></td>
                    <td><%= s.getCloseTime() %></td>
                </tr>
                <% } %>
            </table>
            <% } else { %>
            <div class="empty-msg">Không có trạm nào thuộc tuyến này.</div>
            <% } %>

            <div class="actions">
                <a href="RouteServlet?action=list" class="btn btn-back">⬅ Quay lại</a>
                <a href="RouteServlet?action=edit&id=<%= route.getRouteId() %>" class="btn btn-edit">✏ Sửa</a>
                <a href="RouteServlet?action=delete&id=<%= route.getRouteId() %>"
                   class="btn btn-delete"
                   onclick="return confirm('Bạn có chắc muốn xóa tuyến đường này không?');">🗑 Xóa</a>
            </div>
        </div>
    </body>
</html>
