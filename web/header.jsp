<%-- 
    Document   : Header
    Created on : Oct 16, 2025, 3:32:33 PM
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" %>

<style>
    /* ===== Reset & Global ===== */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        transition: all 0.3s ease;
    }

    body {
        font-family: "Segoe UI", Arial, sans-serif;
        background: linear-gradient(135deg, #e6efff, #f8fbff);
        color: #333;
        min-height: 100vh;
        animation: fadeIn 1s ease forwards;
    }

    /* ===== Header ===== */
    header {
        position: sticky;
        top: 0;
        z-index: 10;
        background: rgba(0, 98, 204, 0.9);
        backdrop-filter: blur(10px);
        color: white;
        padding: 18px 50px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 4px 15px rgba(0,0,0,0.15);
    }

    .logo {
        font-size: 24px;
        font-weight: bold;
        letter-spacing: 1px;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    /* ===== Navigation ===== */
    nav ul {
        list-style: none;
        display: flex;
        gap: 30px;
    }

    nav ul li a {
        color: white;
        text-decoration: none;
        font-weight: 500;
        position: relative;
        padding-bottom: 4px;
    }

    nav ul li a::after {
        content: "";
        position: absolute;
        width: 0%;
        height: 2px;
        bottom: 0;
        left: 0;
        background-color: #ffdd57;
        transition: width 0.3s ease;
    }

    nav ul li a:hover::after {
        width: 100%;
    }

    nav ul li a:hover {
        color: #ffdd57;
    }

    /* ===== Animations ===== */
    @keyframes fadeIn {
        from {
            opacity: 0;
        }
        to {
            opacity: 1;
        }
    }

    @media (max-width: 768px) {
        header {
            flex-direction: column;
            gap: 15px;
            text-align: center;
        }

        nav ul {
            flex-wrap: wrap;
            justify-content: center;
            gap: 15px;
        }
    }
</style>
<header>
    <div class="logo" onclick="window.location.href = 'index.html';" style="cursor: pointer;">
        🚌 <span>Bus Management System</span>
    </div>
    <nav>
        <ul>
            <li><a href="BusServlet?action=list">Xe Bus</a></li>
            <li><a href="RouteServlet?action=list">Tuyến Đường</a></li>
            <li><a href="TripServlet?action=list">Chuyến Xe</a></li>
            <li><a href="DriverServlet?action=list">Tài Xế</a></li>
        </ul>
    </nav>
</header>
