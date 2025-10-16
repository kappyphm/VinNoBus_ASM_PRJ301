<%-- 
    Document   : BusDetails
    Created on : Oct 16, 2025, 2:27:27 PM
    Author     : Admin
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết Xe Bus</title>
        <style>
            /* ===== Reset & Global ===== */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                transition: all 0.3s ease;
            }
            body {
                font-family: 'Segoe UI', sans-serif;
                background: linear-gradient(135deg, #e6efff, #f8fbff);
                color: #333;
                min-height: 100vh;
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
            }
            nav ul {
                list-style: none;
                display: flex;
                gap: 25px;
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

            /* ===== Main content ===== */
            main {
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 80px 20px 60px;
                animation: slideUp 0.8s ease forwards;
            }
            .details-box {
                background: #fff;
                padding: 35px 40px;
                border-radius: 16px;
                box-shadow: 0 8px 25px rgba(0,0,0,0.15);
                width: 400px;
                text-align: left;
            }
            h2 {
                text-align: center;
                color: #004a99;
                margin-bottom: 25px;
            }
            .detail-item {
                margin-bottom: 15px;
                font-size: 16px;
            }
            .detail-item span {
                font-weight: 600;
            }

            a.back-btn {
                display: inline-block;
                margin-top: 20px;
                padding: 12px 20px;
                background: linear-gradient(135deg, #0078d7, #005fa3);
                color: white;
                border-radius: 12px;
                text-decoration: none;
                font-weight: 500;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }
            a.back-btn:hover {
                background: linear-gradient(135deg, #005fa3, #004f88);
                transform: translateY(-3px);
                box-shadow: 0 8px 18px rgba(0,0,0,0.2);
            }

            /* ===== Footer ===== */
            footer {
                text-align: center;
                padding: 25px;
                background: #f5f5f5;
                color: #666;
                font-size: 14px;
                border-top: 1px solid #ddd;
                position: relative;
            }

            /* ===== Animations ===== */
            @keyframes slideUp {
                from {
                    transform: translateY(40px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

            @media (max-width: 480px) {
                .details-box {
                    width: 90%;
                    padding: 25px;
                }
                header {
                    flex-direction: column;
                    gap: 10px;
                }
                nav ul {
                    flex-wrap: wrap;
                    justify-content: center;
                    gap: 10px;
                }
            }
        </style>
    </head>
    <body>
        <main>
            <div class="details-box">
                <h2>Chi tiết Xe Bus</h2>
                <div class="detail-item"><span>Biển số xe:</span> ${bus.plateNumber}</div>
                <div class="detail-item"><span>Sức chứa:</span> ${bus.capacity}</div>
                <div class="detail-item"><span>Mã xe:</span> ${bus.busId}</div>
                <a class="back-btn" href="BusServlet?action=list">← Quay lại danh sách</a>
            </div>
        </main>
    </body>
</html>
