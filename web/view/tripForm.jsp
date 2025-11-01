<%-- 
    Document   : tripForm
    Created on : Nov 1, 2025, 12:05:15 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<h2>${trip == null ? "Add New Trip" : "Edit Trip"}</h2>

<c:if test="${not empty error}">
    <ul style="color:red;">
        <c:forEach var="err" items="${error}">
            <li>${err}</li>
        </c:forEach>
    </ul>
</c:if>

<form method="post" action="trip">
    <input type="hidden" name="action" value="${trip == null ? 'add' : 'update'}">
    <input type="hidden" name="tripId" value="${trip.tripId}" />

    <label>Route:</label>
    <select name="routeId" required>
        <option value="">-- Select Route --</option>
        <c:forEach var="r" items="${routes}">
            <option value="${r.routeId}" ${trip.route.routeId == r.routeId ? "selected" : ""}>${r.routeName}</option>
        </c:forEach>
    </select>
    <br><br>

    <label>Bus:</label>
    <select name="busId" required>
        <option value="">-- Select Bus --</option>
        <c:forEach var="b" items="${buses}">
            <option value="${b.busId}" ${trip.bus.busId == b.busId ? "selected" : ""}>${b.licensePlate}</option>
        </c:forEach>
    </select>
    <br><br>

    <label>Driver:</label>
    <select name="driverId" required>
        <option value="">-- Select Driver --</option>
        <c:forEach var="d" items="${drivers}">
            <option value="${d.employeeId}" ${trip.driver.employeeId == d.employeeId ? "selected" : ""}>${d.fullName}</option>
        </c:forEach>
    </select>
    <br><br>

    <label>Conductor:</label>
    <select name="conductorId" required>
        <option value="">-- Select Conductor --</option>
        <c:forEach var="c" items="${conductors}">
            <option value="${c.employeeId}" ${trip.conductor.employeeId == c.employeeId ? "selected" : ""}>${c.fullName}</option>
        </c:forEach>
    </select>
    <br><br>

    <label>Departure Time:</label>
    <input type="time" name="departureTime" value="${trip.departureTime}" required>
    <br><br>

    <label>Arrival Time:</label>
    <input type="time" name="arrivalTime" value="${trip.arrivalTime}" required>
    <br><br>

    <label>Status:</label>
    <select name="status">
        <option value="NOT_STARTED">Not Started</option>
        <option value="ONGOING">Ongoing</option>
        <option value="COMPLETED">Completed</option>
    </select>
    <br><br>

    <button type="submit">Save</button>
    <a href="trip?action=list">Cancel</a>
</form>

<jsp:include page="footer.jsp" />
