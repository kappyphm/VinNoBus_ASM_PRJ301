<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="header.jsp" %>

<style>
    body {
        font-family: 'Segoe UI', Roboto, sans-serif;
        background: #f4f6f9;
        padding: 20px;
    }

    .card {
        max-width: 600px;
        margin: 0 auto;
        background: white;
        border-radius: 10px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        padding: 25px;
    }

    h2 {
        text-align: center;
        color: #0078d7;
        margin-bottom: 25px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    td {
        padding: 10px;
        border-bottom: 1px solid #eee;
    }

    td:first-child {
        font-weight: 600;
        color: #0078d7;
        width: 40%;
    }

    .btn-back {
        display: block;
        text-align: center;
        margin-top: 20px;
        text-decoration: none;
        color: white;
        background: #0078d7;
        padding: 10px;
        border-radius: 6px;
    }

    .btn-back:hover {
        background: #005fa3;
    }
</style>

<div class="card">
    <h2>Chi tiết chuyến xe</h2>
    <table>
        <tr><td>Mã chuyến:</td><td>${trip.tripId}</td></tr>
        <tr><td>Mã tuyến:</td><td>${trip.routeId}</td></tr>
        <tr><td>Mã xe buýt:</td><td>${trip.busId}</td></tr>
        <tr><td>Tài xế:</td><td>${trip.driverId}</td></tr>
        <tr><td>Phụ xe:</td><td>${trip.conductorId}</td></tr>
        <tr><td>Giờ khởi hành:</td><td><fmt:formatDate value="${trip.departureTime}" pattern="HH:mm:ss"/></td></tr>
        <tr><td>Giờ kết thúc:</td><td><fmt:formatDate value="${trip.arrivalTime}" pattern="HH:mm:ss"/></td></tr>
        <tr><td>Trạng thái:</td><td>${trip.status}</td></tr>
    </table>

    <a href="TripServlet?action=list" class="btn-back">← Quay lại danh sách</a>
</div>

<%@ include file="footer.jsp" %>
