<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Đăng nhập • VinNoBus</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;600;700&display=swap" rel="stylesheet">
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          fontFamily: { mono: ['Roboto Mono', 'ui-monospace', 'SFMono-Regular'] },
          colors: { brand: { 50:'#eff6ff',100:'#dbeafe',200:'#bfdbfe',300:'#93c5fd',400:'#60a5fa',500:'#3b82f6',600:'#2563eb',700:'#1d4ed8',800:'#1e40af',900:'#1e3a8a' } },
          boxShadow: { soft: '0 8px 24px rgba(2, 6, 23, 0.06)' }
        }
      }
    }
  </script>
  <style> html { font-family: 'Roboto Mono', ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, 'Liberation Mono', 'Courier New', monospace; } </style>
</head>
<body class="bg-brand-50 min-h-screen flex items-center justify-center p-6 text-slate-800">
  <main class="w-full max-w-md rounded-2xl border border-slate-200 bg-white p-6 shadow-soft">
    <div class="flex items-center gap-2 mb-4">
      <div class="w-8 h-8 rounded-xl bg-brand-600 text-white grid place-items-center font-semibold">V</div>
      <div class="font-semibold">VinNoBus</div>
    </div>
    <h1 class="text-xl font-semibold">Đăng nhập</h1>
    <p class="text-sm text-slate-600 mt-1">Chọn phương thức đăng nhập</p>

    <div class="mt-6 grid gap-3">
      <a href="/oauth/google" class="px-4 py-2 rounded-xl border border-slate-200 hover:bg-slate-50 flex items-center justify-center gap-2">
        <span>Đăng nhập với Google</span>
      </a>
      <a href="/oauth/facebook" class="px-4 py-2 rounded-xl border border-slate-200 hover:bg-slate-50 flex items-center justify-center gap-2">
        <span>Đăng nhập với Facebook</span>
      </a>
      <a href="/login/phone" class="px-4 py-2 rounded-xl border border-slate-200 hover:bg-slate-50 flex items-center justify-center gap-2">
        <span>Đăng nhập với Số điện thoại</span>
      </a>
    </div>

    <div class="mt-6 text-center text-sm">
      Chưa có tài khoản?
      <a class="text-brand-700 hover:underline" href="register.jsp">Đăng ký</a>
    </div>
    <div class="mt-8 text-center">
      <a href="info.jsp" class="text-xs text-slate-500 hover:underline">← Về trang thông tin</a>
    </div>
  </main>
</body>
</html>
