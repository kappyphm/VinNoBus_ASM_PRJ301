<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉnh sửa Xe Bus</title>
        <style>
            /* ===== Reset & Global ===== */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            body {
                font-family: 'Segoe UI', sans-serif;
                background: linear-gradient(135deg, #74b9ff, #a29bfe);
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            /* ===== Form box ===== */
            .form-box {
                background: #fff;
                padding: 35px 40px;
                border-radius: 16px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.15);
                width: 400px;
                text-align: center;
                animation: fadeIn 0.5s ease;
            }

            h2 {
                color: #2d3436;
                margin-bottom: 20px;
            }

            label {
                display: block;
                font-weight: 600;
                text-align: left;
                margin-top: 15px;
                margin-bottom: 5px;
                color: #555;
            }

            input[type="text"],
            input[type="number"] {
                width: 100%;
                padding: 10px 12px;
                border: 1px solid #dcdde1;
                border-radius: 8px;
                font-size: 15px;
                transition: all 0.3s ease-in-out;
            }

            input[type="text"]:focus,
            input[type="number"]:focus {
                border-color: #0984e3;
                box-shadow: 0 0 8px rgba(9,132,227,0.4);
                outline: none;
            }

            .error {
                color: #d63031;
                font-weight: 600;
                margin-top: 5px;
                font-size: 14px;
                text-align: left;
            }

            .message {
                color: #27ae60;
                font-weight: 600;
                margin-bottom: 15px;
            }

            .actions {
                display: flex;
                justify-content: space-between;
                margin-top: 25px;
            }

            button {
                padding: 12px 18px;
                background-color: #0984e3;
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 600;
                transition: all 0.3s ease-in-out;
            }

            button:hover {
                background-color: #74b9ff;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0,0,0,0.2);
            }

            a.back-btn {
                text-decoration: none;
                padding: 12px 18px;
                border-radius: 8px;
                border: 1px solid #ccc;
                color: #333;
                background-color: #f8f9fa;
                transition: all 0.3s ease-in-out;
            }

            a.back-btn:hover {
                background-color: #e2e6ea;
                transform: translateY(-1px);
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @media (max-width: 480px) {
                .form-box {
                    width: 90%;
                    padding: 25px;
                }
            }
        </style>
    </head>
    <body>
        <div class="form-box">
            <h2>Chỉnh sửa Xe Bus</h2>
            <c:if test="${not empty message}">
                <div class="message">${message}</div>
            </c:if>
            <form action="BusServlet" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="bus_id" value="${bus_id != null ? bus_id : bus.busId}">
                <label>Biển số xe:</label>
                <input type="text" name="plate_number" 
                       value="${plate_number != null ? plate_number : bus.plateNumber}" 
                       placeholder="VD: 29B-123.45"  >
                <c:if test="${not empty error_plate}">
                    <div class="error">${error_plate}</div>
                </c:if>
                <label>Sức chứa:</label>
                <input type="number" name="capacity" 
                       value="${capacity != null ? capacity : bus.capacity}" 
                       min="1"  >
                <c:if test="${not empty error_capacity}">
                    <div class="error">${error_capacity}</div>
                </c:if>
                <c:if test="${not empty error_general}">
                    <div class="error">${error_general}</div>
                </c:if>
                <div class="actions">
                    <a class="back-btn" href="BusServlet?action=list">← Quay lại</a>
                    <button type="submit">Cập nhật</button>
                </div>
            </form>
        </div>
    </body>
</html>
