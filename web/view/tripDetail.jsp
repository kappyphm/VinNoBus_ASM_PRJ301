<%-- 
    Document   : tripDetail
    Created on : Nov 1, 2025, 12:04:26 PM
    Author     : ADMIN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <jsp:include page="header.jsp"/>
<html>
<head>
    <title>Trip Detail</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        table { border-collapse: collapse; width: 50%; }
        td, th { padding: 8px; border: 1px solid #ddd; }
    </style>
</head>
<body>
<h2>👁 Trip Detail</h2>

<table>
    <tr><th>ID</th><td>${trip.tripId}</td></tr>
    <tr><th>Route ID</th><td>${trip.routeId}</td></tr>
    <tr><th>Bus ID</th><td>${trip.busId}</td></tr>
    <tr><th>Driver ID</th><td>${trip.driverId}</td></tr>
    <tr><th>Conductor ID</th><td>${trip.conductorId}</td></tr>
    <tr><th>Departure</th><td>${trip.departureTime}</td></tr>
    <tr><th>Arrival</th><td>${trip.arrivalTime}</td></tr>
    <tr><th>Status</th><td>${trip.status}</td></tr>
</table>

<br>
<a href="trip?action=list">Back to List</a>

</body>
</html>

<%@ include file="footer.jsp" %>