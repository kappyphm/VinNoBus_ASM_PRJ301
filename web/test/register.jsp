<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Đăng ký • VinNoBus</title>
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
                        boxShadow: {soft: '0 8px 24px rgba(2, 6, 23, 0.06)'}
                    }
                }
            }
        </script>
        <style> html {
            font-family: 'Roboto Mono', ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, 'Liberation Mono', 'Courier New', monospace;
        } </style>
    </head>
    <body class="bg-brand-50 min-h-screen flex items-center justify-center p-6 text-slate-800">
        <main class="w-full max-w-2xl rounded-2xl border border-slate-200 bg-white p-6 shadow-soft">
            <div class="flex items-center gap-2 mb-4">
                <div class="w-8 h-8 rounded-xl bg-brand-600 text-white grid place-items-center font-semibold">V</div>
                <div class="font-semibold">VinNoBus</div>
            </div>
            <h1 class="text-xl font-semibold">Đăng ký tài khoản</h1>
            <p class="text-sm text-slate-600 mt-1">Điền thông tin bên dưới. Mật khẩu tối thiểu 12 ký tự, và phải chứa ít nhất 1 số hoặc 1 ký tự đặc biệt.</p>

            <form class="mt-6 grid grid-cols-1 md:grid-cols-2 gap-4" action="/register" method="post" onsubmit="return validatePassword()">
                <div class="col-span-1 md:col-span-2">
                    <label class="block text-sm mb-1">Họ & Tên</label>
                    <input name="name" required type="text" class="w-full rounded-xl border border-slate-200 px-3 py-2" placeholder="VD: Nguyễn Văn A" />
                </div>

                <div>
                    <label class="block text-sm mb-1">Email</label>
                    <input name="email" required type="email" class="w-full rounded-xl border border-slate-200 px-3 py-2" placeholder="you@example.com" />
                </div>

                <div>
                    <label class="block text-sm mb-1">Số điện thoại</label>
                    <input name="phone" required type="tel" class="w-full rounded-xl border border-slate-200 px-3 py-2" placeholder="09xx xxx xxx" />
                </div>

                <div>
                    <label class="block text-sm mb-1">Avatar</label>
                    <img src="${userDetail.avatarUrl}" alt="alt"/>
                    <input name="avatarUrl" type="url" class="w-full rounded-xl border border-slate-200 px-3 py-2" placeholder="https://..." />
                </div>

                <div>
                    <label class="block text-sm mb-1">Ngày sinh</label>
                    <input name="dob" type="date" class="w-full rounded-xl border border-slate-200 px-3 py-2" />
                </div>

                <div class="md:col-span-2">
                    <label class="block text-sm mb-1">Địa chỉ</label>
                    <input name="address" type="text" class="w-full rounded-xl border border-slate-200 px-3 py-2" placeholder="Số nhà, đường, phường/xã, quận/huyện, tỉnh/thành" />
                </div>

            </form>

            <div class="mt-8 text-center">
                <a href="info.jsp" class="text-xs text-slate-500 hover:underline">← Về trang thông tin</a>
            </div>
        </main>


    </body>
</html>
