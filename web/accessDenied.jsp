<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${title} • VinNoBus</title>

        <!-- Google Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;600;700&display=swap" rel="stylesheet">

        <!-- Tailwind -->
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: {mono: ['Roboto Mono', 'ui-monospace', 'SFMono-Regular']},
                        colors: {brand: {50: '#eff6ff', 100: '#dbeafe', 200: '#bfdbfe', 300: '#93c5fd', 400: '#60a5fa', 500: '#3b82f6', 600: '#2563eb', 700: '#1d4ed8', 800: '#1e40af', 900: '#1e3a8a'}},
                        boxShadow: {soft: '0 8px 24px rgba(2,6,23,.06)'}
                    }
                }
            }
        </script>

        <style>
            html {
                font-family: 'Roboto Mono', monospace;
            }
            .tab-active {
                background-color: #2563eb;
                color: white;
            }
            .tab-inactive {
                background-color: white;
                color: #1e3a8a;
                border: 1px solid #2563eb;
            }
        </style>
    </head>

    <body class="bg-slate-50 h-screen flex items-center justify-center">

        <div class="bg-white shadow-lg border border-slate-200 rounded-2xl p-8 max-w-md text-center">
            <h1 class="text-3xl font-bold text-red-600">403</h1>
            <p class="mt-2 text-lg font-semibold">Không có quyền truy cập</p>
            <p class="text-slate-600 mt-1">
                Bạn không có quyền truy cập vào trang này hoặc tài khoản không đủ quyền hạn.
            </p>

            <a href="${pageContext.request.contextPath}/" 
               class="mt-6 inline-block px-5 py-2 rounded-xl bg-blue-600 text-white hover:bg-blue-700">
                Quay lại trang chủ
            </a>
        </div>

    </body>
</html>
