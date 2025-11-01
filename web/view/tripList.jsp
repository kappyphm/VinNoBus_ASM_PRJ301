<%-- 
    Document   : tripList
    Created on : Nov 1, 2025, 12:02:36 PM
    Author     : ADMIN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="header.jsp" %>

<html>
<head>
    <title>Trip List</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px 40px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: center; }
        th { background-color: #f2f2f2; }
        .add-btn { background-color: #4CAF50; color: white; padding: 7px 15px; border: none; cursor: pointer; }
        .action-btn { margin: 0 4px; padding: 5px 10px; }
        .top-bar { display: flex; justify-content: space-between; align-items: center; }
    </style>
</head>
<body>
<div class="top-bar">
    <h2>Trip List</h2>
    <a href="trip?action=add" class="add-btn">+ Add Trip</a>
</div>

<form method="get" action="trip">
    <input type="hidden" name="action" value="search">
    <input type="text" name="search" placeholder="Search..." value="${param.search}">
    <button type="submit">Search</button>
</form>

<table>
    <tr>
        <th>ID</th><th>Route</th><th>Bus</th><th>Driver</th>
        <th>Conductor</th><th>Departure</th><th>Arrival</th><th>Status</th><th>Action</th>
    </tr>
    <c:forEach var="trip" items="${trips}">
        <tr>
            <td>${trip.tripId}</td>
            <td>${trip.routeId}</td>
            <td>${trip.busId}</td>
            <td>${trip.driverId}</td>
            <td>${trip.conductorId}</td>
            <td>${trip.departureTime}</td>
            <td>${trip.arrivalTime}</td>
            <td>${trip.status}</td>
            <td>
                <a href="trip?action=detail&tripId=${trip.tripId}">Detail</a> |
                <a href="trip?action=edit&tripId=${trip.tripId}">Edit</a> |
                <form action="trip" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="tripId" value="${trip.tripId}">
                    <button type="submit" style="color:red;">Delete</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

<p>Total trips: ${total}</p>

</body>
</html>

<%@ include file="footer.jsp" %>
