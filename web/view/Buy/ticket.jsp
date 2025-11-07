<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Mua vé • VinNoBus</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;600;700&display=swap" rel="stylesheet">
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
                font-family: 'Roboto Mono', ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, 'Courier New', monospace
            }
        </style>
    </head>
    <body class="bg-brand-50 text-slate-800 min-h-screen flex items-center justify-center">

        <div class="bg-white rounded-2xl shadow-soft p-8 w-[400px] text-center border border-slate-200">
            <div class="w-14 h-14 rounded-2xl bg-brand-600 text-white grid place-items-center mx-auto mb-4 text-2xl font-semibold shadow-soft">
                🚌
            </div>
            <h1 class="text-2xl font-semibold mb-6">Mua vé xe buýt</h1>

            <div class="space-y-4">
                <form action="trip.jsp">
                    <button class="w-full bg-emerald-600 hover:bg-emerald-700 text-white px-4 py-3 rounded-xl font-medium transition-all shadow-soft">
                        🎟️ Mua vé lượt
                    </button>
                </form>

                <form action="month.jsp">
                    <button class="w-full bg-brand-600 hover:bg-brand-700 text-white px-4 py-3 rounded-xl font-medium transition-all shadow-soft">
                        🗓️ Mua vé tháng
                    </button>
                </form>
            </div>

            <p class="text-xs text-slate-500 mt-6">VinNoBus • Kết nối hành trình an toàn & tiện lợi</p>
        </div>

    </body>
</html>
