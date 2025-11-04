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

    .btn-delete {
        background: #d32f2f;
        margin-left: 10px;
    }

    .btn-delete:hover {
        background: #a31818;
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
    <h2>Chỉnh sửa chuyến xe</h2>

    <c:if test="${not empty errors}">
        <div class="error">
            <ul>
                <c:forEach var="err" items="${errors}">
                    <li>${err}</li>
                    </c:forEach>
            </ul>
        </div>
    </c:if>

    <form action="TripServlet?action=update" method="post">
        <input type="hidden" name="tripId" value="${trip.tripId}">

        <label for="routeId">Mã tuyến:</label>
        <input type="number" name="routeId" value="${trip.routeId}" required>

        <label for="busId">Mã xe buýt:</label>
        <input type="number" name="busId" value="${trip.busId}" required>

        <label for="driverId">Tài xế xe:</label>
        <input type="text" name="driverId" value="${trip.driverId}" placeholder="Nguyễn Văn A"required>

        <label for="conductorId">Phụ xe:</label>
        <input type="text" name="conductorId" value="${trip.conductorId}" placeholder="Nguyễn Văn B"required>

        <label for="departureTime">Giờ khởi hành:</label>
        <input type="time" name="departureTime" value="${trip.departureTime}" required>

        <label for="arrivalTime">Giờ kết thúc:</label>
        <input type="time" name="arrivalTime" value="${trip.arrivalTime}" required>

        <label for="status">Trạng thái:</label>
        <select name="status">
            <option value="NOT_STARTED" ${trip.status eq 'NOT_STARTED' ? 'selected' : ''}>Chưa bắt đầu</option>
            <option value="IN_PROGRESS" ${trip.status eq 'IN_PROGRESS' ? 'selected' : ''}>Đang chạy</option>
            <option value="COMPLETED" ${trip.status eq 'COMPLETED' ? 'selected' : ''}>Hoàn thành</option>
            <option value="CANCELLED" ${trip.status eq 'CANCELLED' ? 'selected' : ''}>Đã Hủy</option>
        </select>

        <button type="submit" class="btn">Cập nhật</button>
        <a href="TripServlet?action=delete&tripId=${trip.tripId}" class="btn btn-delete" onclick="return confirm('Bạn chắc muốn xóa chuyến này?')">Xóa</a>
        <a href="TripServlet?action=list" style="margin-left:10px; text-decoration:none; color:#0078d7;">← Quay lại</a>
    </form>
</div>

<%@ include file="footer.jsp" %>
