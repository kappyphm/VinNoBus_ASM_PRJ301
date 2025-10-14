<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto Mono', monospace;
        }
    </style>
</head>
<body class="bg-gray-50 text-black">
    <div class="min-h-screen flex flex-col items-center justify-center">
        <div class="w-full max-w-md p-8 bg-white rounded-[5px] shadow-sm text-center">
            <h1 class="text-3xl font-bold mb-4">Chào mừng đến với Trang Web</h1>
            <p class="text-gray-600 mb-8">Đây là trang chủ công khai. Bất kỳ ai cũng có thể xem được nội dung này.</p>
            <div class="flex justify-center gap-4">
                <a href="login.jsp" class="px-6 py-2 bg-black text-white rounded-[5px] hover:bg-gray-800 transition-colors">Đăng Nhập</a>
                <a href="register.jsp" class="px-6 py-2 bg-white text-black border border-black rounded-[5px] hover:bg-gray-100 transition-colors">Đăng Ký</a>
            </div>
        </div>
    </div>
</body>
</html>
