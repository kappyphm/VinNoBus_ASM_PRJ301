<%-- 
    Document   : RouteForm
    Created on : Oct 15, 2025, 1:00:52 PM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="RouteModule.model.Route" %>
<%
    Route route = (Route) request.getAttribute("route");
    boolean isEdit = (route != null);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= isEdit ? "Cập nhật tuyến đường" : "Thêm tuyến đường mới" %></title>

        <style>
            body {
                font-family: 'Segoe UI', Arial, sans-serif;
                background: #eef2f6;
                margin: 0;
                padding: 0;
            }

            .container {
                width: 500px;
                margin: 60px auto;
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

            form {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            label {
                font-weight: 600;
                color: #333;
            }

            input[type="text"],
            input[type="number"],
            select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 6px;
                outline: none;
                transition: all 0.3s ease;
            }

            input[type="text"]:focus,
            input[type="number"]:focus,
            select:focus {
                border-color: #007bff;
                box-shadow: 0 0 5px rgba(0,123,255,0.4);
            }

            .btn {
                padding: 10px 15px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 15px;
                transition: all 0.3s ease;
            }

            .btn-save {
                background: #28a745;
                color: white;
            }

            .btn-save:hover {
                background: #218838;
            }

            .btn-cancel {
                background: #6c757d;
                color: white;
                text-decoration: none;
                text-align: center;
                display: inline-block;
                padding: 10px 15px;
                border-radius: 6px;
            }

            .btn-cancel:hover {
                background: #5a6268;
            }

            .form-actions {
                display: flex;
                justify-content: space-between;
                margin-top: 15px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2><%= isEdit ? "Cập nhật tuyến đường" : "Thêm tuyến đường mới" %></h2>

            <form action="RouteServlet" method="post">
                <input type="hidden" name="action" value="<%= isEdit ? "update" : "insert" %>">
                <% if (isEdit) { %>
                <input type="hidden" name="id" value="<%= route.getRouteId() %>">
                <% } %>

                <label for="routeName">Tên tuyến đường:</label>
                <input type="text" id="routeName" name="routeName" 
                       value="<%= isEdit ? route.getRouteName() : "" %>" required>
                <label for="type">Loại tuyến:</label>
                <input type="text" id="type" name="type" 
                       value="<%= isEdit ? route.getType() : "" %>" required>
                <label for="frequency">Tần suất:</label>
                <input type="text" id="frequency" name="frequency" 
                       value="<%= isEdit ? route.getFrequency() : "" %>" required>          
                <div class="form-actions">
                    <button type="submit" class="btn btn-save">
                        <%= isEdit ? "Lưu thay đổi" : "Thêm tuyến" %>
                    </button>
                    <a href="RouteServlet?action=list" class="btn-cancel">Hủy</a>
                </div>
            </form>
        </div>
    </body>
</html>
