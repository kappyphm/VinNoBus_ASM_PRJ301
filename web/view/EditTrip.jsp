<%-- 
    Document   : EditTrip
    Created on : Nov 1, 2025, 1:14:45 PM
    Author     : ADMIN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <jsp:include page="header.jsp"/>
<html>
<head>
    <title>Edit Trip</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        input, select { display: block; margin: 8px 0; padding: 5px; width: 250px; }
        .error { color: red; }
    </style>
</head>
<body>
<h2>✏️ Edit Trip</h2>

<c:if test="${not empty error}">
    <div class="error">
        <ul>
            <c:forEach var="e" items="${error}">
                <li>${e}</li>
            </c:forEach>
        </ul>
    </div>
</c:if>

<form action="trip" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="tripId" value="${trip.tripId}">

    Trip ID: <input type="text" value="${trip.tripId}" readonly>
    Route ID: <input type="text" value="${trip.routeId}" readonly>
    Bus ID: <input type="text" value="${trip.busId}" readonly>
    Driver ID: <input type="text" value="${trip.driverId}" readonly>
    Conductor ID: <input type="text" value="${trip.conductorId}" readonly>
    Departure: <input type="text" value="${trip.departureTime}" readonly>
    Arrival: <input type="text" value="${trip.arrivalTime}" readonly>

    Status:
    <select name="status" required>
        <option value="">-- Select --</option>
        <option value="NOT_STARTED" ${trip.status=="NOT_STARTED"?"selected":""}>NOT_STARTED</option>
        <option value="RUNNING" ${trip.status=="RUNNING"?"selected":""}>RUNNING</option>
        <option value="COMPLETED" ${trip.status=="COMPLETED"?"selected":""}>COMPLETED</option>
        <option value="CANCELLED" ${trip.status=="CANCELLED"?"selected":""}>CANCELLED</option>
    </select>

    <button type="submit">Update</button>
    <a href="trip?action=list">Cancel</a>
</form>

</body>
</html>
<%@ include file="footer.jsp" %>