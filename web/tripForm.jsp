<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>

<style>
    body {
        font-family: 'Segoe UI', Roboto, sans-serif;
        background: #f4f6f9;
        padding: 20px;
    }

    .container {
        max-width: 600px;
        margin: 0 auto;
        background: white;
        border-radius: 10px;
        padding: 25px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    h2 {
        text-align: center;
        color: #0078d7;
        margin-bottom: 25px;
    }

    label {
        display: block;
        font-weight: 600;
        margin-bottom: 5px;
    }

    input, select {
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border-radius: 6px;
        border: 1px solid #ccc;
        font-size: 14px;
    }

    input:focus {
        outline: none;
        border-color: #0078d7;
        box-shadow: 0 0 3px #0078d7;
    }

    .btn {
        background: #0078d7;
        color: white;
        padding: 10px 18px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        transition: 0.25s;
    }

    .btn:hover {
        background: #005fa3;
    }

    .message {
        background: #e1f5fe;
        border-left: 4px solid #0078d7;
        padding: 10px;
        color: #333;
        margin-bottom: 10px;
    }

    .error {
        background: #ffebee;
        border-left: 4px solid #d32f2f;
        padding: 10px;
        color: #d32f2f;
        margin-bottom: 10px;
    }
</style>

<div class="container">
    <h2>Thêm chuyến xe mới</h2>

    <!-- Hiển thị lỗi -->
    <c:if test="${not empty errors}">
        <div class="error">
            <ul>
                <c:forEach var="err" items="${errors}">
                    <li>${err}</li>
                    </c:forEach>
            </ul>
        </div>
    </c:if>

    <!-- Thông báo thành công -->
    <c:if test="${not empty success}">
        <div class="message">${success}</div>
    </c:if>

    <form action="TripServlet?action=add" method="post">

        <label for="routeId">Mã tuyến:</label>
        <input type="number" name="routeId" required>

        <label for="busId">Mã xe buýt:</label>
        <input type="number" name="busId" required>

        <label for="driverId">Tài xế xe:</label>
        <input type="text" name="driverId" placeholder="Nguyễn Văn A"required>

        <label for="conductorId">Phụ xe:</label>
        <input type="text" name="conductorId" placeholder="Nguyễn Văn B"required>

        <label for="departureTime">Giờ khởi hành:</label>
        <input type="datetime-local" name="departureTime" >

        <label for="arrivalTime">Giờ kết thúc:</label>
        <input type="datetime-local" name="arrivalTime" >

        <button type="submit" class="btn">Thêm chuyến</button>
        <a href="TripServlet?action=list" style="margin-left:10px; text-decoration:none; color:#0078d7;">← Quay lại danh sách</a>
    </form>
</div>

<%@ include file="footer.jsp" %>
