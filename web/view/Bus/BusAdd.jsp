<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    <head>
        <title>Thêm Xe Bus Mới</title>
        <style>
            body {
                font-family: 'Segoe UI', Arial, sans-serif;
                background: linear-gradient(135deg, #74b9ff, #a29bfe);
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            .form-container {
                background-color: #fff;
                padding: 35px 40px;
                border-radius: 16px;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
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
                text-align: left;
                font-weight: 600;
                color: #555;
                margin-top: 15px;
                margin-bottom: 5px;
            }

            input[type="text"],
            input[type="number"] {
                width: 100%;
                padding: 10px 12px;
                border: 1px solid #dcdde1;
                border-radius: 8px;
                outline: none;
                transition: 0.3s;
                font-size: 15px;
            }

            input:focus {
                border-color: #0984e3;
                box-shadow: 0 0 5px rgba(9, 132, 227, 0.4);
            }

            button {
                width: 100%;
                background: #0984e3;
                color: white;
                padding: 12px;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: bold;
                margin-top: 20px;
                cursor: pointer;
                transition: 0.3s;
            }

            button:hover {
                background: #74b9ff;
            }

            a {
                display: inline-block;
                margin-top: 20px;
                text-decoration: none;
                color: #636e72;
                font-size: 14px;
            }

            a:hover {
                text-decoration: underline;
                color: #2d3436;
            }

            .message {
                color: #27ae60;
                font-weight: 600;
                margin-bottom: 15px;
            }

            .error {
                color: #d63031;
                font-weight: 600;
                margin-bottom: 15px;
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
        </style>
    </head>
    <body>

        <div class="form-container">
            <h2>Thêm Xe Bus Mới</h2>

            <!-- Hiển thị thông báo -->
            <c:if test="${not empty message}">
                <div class="message">${message}</div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <form action="BusServlet" method="post">
                <input type="hidden" name="action" value="add">

                <label>Biển số xe:</label>
                <input type="text" name="plate_number" placeholder="VD: 29B-123.45" >

                <label>Sức chứa:</label>
                <input type="number" name="capacity" placeholder="VD: 40">

                <button type="submit">➕ Thêm Xe Bus</button>
                <a href="BusServlet?action=list">← Quay lại danh sách</a>
            </form>
        </div>

    </body>
</html>
