<%-- 
    Document   : admin
    Created on : Oct 26, 2025, 7:57:25 AM
    Author     : kappyphm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>admin</h1>
        <a href="${ctx}/admin/users">User</a>
        <a href="${ctx}/admin/staffs">Staff</a>
        <a href="${ctx}/admin/customers">Customer</a>
        <a href="${ctx}/admin/buses">Bus</a>
        <a href="${ctx}/admin/routes">Route</a>
        <a href="${ctx}/admin/trips">Trip</a>
        <a href="${ctx}/admin/tickets">Ticket</a>
        
        
    </body>
</html>
