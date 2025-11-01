<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .navbar {
        background-color: #003366;
        overflow: hidden;
        padding: 10px 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        color: white;
    }
    .navbar h2 {
        margin: 0;
        font-size: 20px;
        color: #ffcc00;
    }
    .nav-links a {
        color: white;
        text-decoration: none;
        margin: 0 12px;
        padding: 6px 10px;
        border-radius: 5px;
        transition: background-color 0.3s;
    }
    .nav-links a:hover {
        background-color: #0059b3;
    }
</style>

<div class="navbar">
    <h2>🚌 Bus Management System</h2>
    <div class="nav-links">
        <a href="trip?action=list">Trips</a>
        <a href="#">Buses</a>
        <a href="#">Routes</a>
        <a href="#">Drivers</a>
        <a href="#">Statistics</a>
    </div>
</div>
<hr>
