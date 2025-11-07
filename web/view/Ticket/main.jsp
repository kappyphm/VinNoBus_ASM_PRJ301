<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>VinNoBus Ticket Management</title>

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;600;700&display=swap" rel="stylesheet">
        <script src="https://cdn.tailwindcss.com"></script>

        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        fontFamily: {mono: ['JetBrains Mono', 'ui-monospace', 'SFMono-Regular']},
                        colors: {
                            brand: {50: '#eff6ff', 100: '#dbeafe', 200: '#bfdbfe', 300: '#93c5fd', 400: '#60a5fa', 500: '#3b82f6', 600: '#2563eb', 700: '#1d4ed8', 800: '#1e40af', 900: '#1e3a8a'},
                        },
                        boxShadow: {soft: '0 8px 24px rgba(2,6,23,.06)'}
                    }
                }
            }
        </script>

        <style>
            html {
                font-family:'JetBrains Mono',ui-monospace,SFMono-Regular,Menlo,Monaco,Consolas,'Courier New',monospace
            }
        </style>
    </head>

    <body class="bg-brand-50 min-h-screen flex items-center justify-center text-slate-800">

        <div class="bg-white rounded-2xl shadow-soft p-10 w-full max-w-md border border-slate-200 text-center">
            <div class="flex items-center justify-center mb-5">
                <div class="w-14 h-14 rounded-xl bg-brand-600 text-white grid place-items-center text-3xl shadow-soft">🚌</div>
            </div>

            <h1 class="text-2xl font-bold text-brand-700 mb-8">VinNoBus Ticket Management</h1>

            <form action="${pageContext.request.contextPath}/view/Ticket/sell.jsp" method="get" class="mb-4">
                <button type="submit"
                        class="w-full bg-brand-600 hover:bg-brand-700 text-white py-3 rounded-xl font-semibold text-base transition-all shadow-soft">
                    🎟️ Bán Vé Lượt
                </button>
            </form>

            <form action="${pageContext.request.contextPath}/view/Ticket/checkin.jsp" method="get" class="mb-4">
                <button type="submit"
                        class="w-full bg-brand-600 hover:bg-brand-700 text-white py-3 rounded-xl font-semibold text-base transition-all shadow-soft">
                    🧾 Check-in Vé Tháng
                </button>
            </form>

            <p class="text-xs text-slate-500 mt-6">© 2025 VinNoBus • Ticket Management System</p>
        </div>

    </body>
</html>
