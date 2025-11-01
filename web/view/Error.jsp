<%-- 
    Document   : Erorr
    Created on : Nov 1, 2025, 1:16:09 PM
    Author     : ADMIN
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <jsp:include page="header.jsp"/>
<html>
<head>
    <title>Error</title>
    <style>
        body { font-family: Arial, sans-serif; color: #e74c3c; text-align: center; margin-top: 100px; }
        a { color: #2c3e50; }
    </style>
</head>
<body>
    <h2>⚠️ Something went wrong!</h2>
    <p>${errorMessage}</p>
    <br>
    <a href="trip?action=list">⬅ Back to Trip List</a>
</body>
</html>
<%@ include file="footer.jsp" %>
