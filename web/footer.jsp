<%-- 
    Document   : footer
    Created on : Oct 16, 2025, 3:43:12 PM
    Author     : Admin
--%>
<%@ page contentType="text/html; charset=UTF-8" %>

<!-- Footer -->
<footer class="footer">
    <div class="footer-container">
        <div class="footer-left">
            <h3>Bus Management System</h3>
            <p>Hệ thống quản lý tuyến xe thông minh và chuyên nghiệp</p>
        </div>
        <div class="footer-center">
            <h4>Liên hệ</h4>
            <p>📍 123 Đường ABC, TP.HCM</p>
            <p>✉️ support@busmanagement.com</p>
            <p>📞 +84 123 456 789</p>
        </div>
        <div class="footer-right">
            <h4>Theo dõi chúng tôi</h4>
            <div class="social-icons">
                <a href="#" class="social-icon">🌐</a>
                <a href="#" class="social-icon">🐦</a>
                <a href="#" class="social-icon">📘</a>
                <a href="#" class="social-icon">💼</a>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        © 2025 Bus Management System - Designed by Ngô Quang Huy, Phạm Gia Khánh, Nguyễn Thị Thắm, Đinh Thị Thu Trang, Nguyễn Bá Quang Minh
    </div>
</footer>

<style>
    /* ===== Footer Global ===== */
    .footer {
        background: linear-gradient(135deg, #0d2b66, #005fa3);
        color: #fff;
        padding: 40px 20px 20px;
        font-family: 'Segoe UI', sans-serif;
        position: relative;
        overflow: hidden;
        animation: fadeInUp 1s ease forwards;
    }

    .footer-container {
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 30px;
        max-width: 1200px;
        margin: 0 auto;
    }

    .footer h3 {
        margin-bottom: 10px;
        font-size: 22px;
        letter-spacing: 1px;
    }

    .footer h4 {
        margin-bottom: 10px;
        font-size: 18px;
        color: #ffdd57;
    }

    .footer p {
        margin-bottom: 8px;
        font-size: 14px;
        color: #d1d9ff;
        line-height: 1.5;
    }

    /* Social icons */
    .social-icons {
        display: flex;
        gap: 12px;
        margin-top: 5px;
    }

    .social-icon {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 36px;
        height: 36px;
        background: rgba(255,255,255,0.15);
        border-radius: 50%;
        color: white;
        font-size: 18px;
        text-decoration: none;
        transition: all 0.3s ease;
    }

    .social-icon:hover {
        background: #ffdd57;
        color: #0d2b66;
        transform: translateY(-3px) scale(1.1);
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    }

    /* Footer bottom */
    .footer-bottom {
        text-align: center;
        margin-top: 30px;
        font-size: 13px;
        color: #cfd8ff;
        border-top: 1px solid rgba(255,255,255,0.2);
        padding-top: 15px;
    }

    /* ===== Animations ===== */
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* ===== Responsive ===== */
    @media (max-width: 768px) {
        .footer-container {
            flex-direction: column;
            text-align: center;
            gap: 20px;
        }

        .footer-right, .footer-center, .footer-left {
            width: 100%;
        }

        .social-icons {
            justify-content: center;
        }
    }
</style>

