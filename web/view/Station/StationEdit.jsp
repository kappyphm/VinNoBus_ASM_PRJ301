<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Cập nhật trạm</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                margin: 40px;
                background-color: #f9f9f9;
            }
            h2 {
                margin-bottom: 20px;
            }
            label {
                display: block;
                margin-top: 10px;
                font-weight: bold;
            }
            input {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                box-sizing: border-box;
            }
            button {
                margin-top: 15px;
                padding: 8px 16px;
            }
            .error {
                color: red;
                font-weight: bold;
            }
            a {
                margin-left: 10px;
            }
            form {
                max-width: 400px;
            }
        </style>
    </head>
    <body>
        <h2>Cập nhật thông tin trạm</h2>

        <!-- Hiển thị lỗi nếu có -->
        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>

        <!-- Nếu có station -->
        <c:choose>
            <c:when test="${not empty station}">
                <form action="StationServlet" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="stationId" value="${station.stationId}">

                    <label>Tên trạm:</label>
                    <input type="text" name="stationName" value="${station.stationName}" required>

                    <label>Vị trí:</label>
                    <input type="text" name="location" value="${station.location}" required>

                    <label>Giờ mở cửa:</label>
                    <input type="time" name="openTime" value="${station.openTime}">

                    <label>Giờ đóng cửa:</label>
                    <input type="time" name="closeTime" value="${station.closeTime}">

                    <button type="submit">Cập nhật</button>
                    <a href="StationServlet?action=list">Hủy</a>
                </form>
            </c:when>
            <c:otherwise>
                <p class="error">Không có dữ liệu để chỉnh sửa.</p>
                <a href="StationServlet?action=list">Quay lại</a>
            </c:otherwise>
        </c:choose>
    </body>
</html>
