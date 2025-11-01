<%-- 
    Document   : TripAdd
    Created on : Nov 1, 2025, 12:57:54 PM
    Author     : ADMIN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <jsp:include page="header.jsp"/>
<html>
<head>
    <title>Add Trip</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; }
        input { display: block; margin: 8px 0; padding: 5px; width: 250px; }
        button { margin-top: 10px; padding: 7px 15px; }
        .error { color: red; }
    </style>
</head>
<body>
<h2>➕ Add New Trip</h2>

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
    <input type="hidden" name="action" value="add">

    Route ID: <input type="number" name="routeId" required>
    Bus ID: <input type="number" name="busId" required>
    Driver ID (UUID): <input type="text" name="driverId" required>
    Conductor ID (UUID): <input type="text" name="conductorId" required>
    Departure Time (HH:mm:ss): <input type="text" name="departureTime" required>
    Arrival Time (HH:mm:ss): <input type="text" name="arrivalTime" required>

    <button type="submit">Add Trip</button>
    <a href="trip?action=list">Cancel</a>
</form>

</body>
</html>

<%@ include file="footer.jsp" %>