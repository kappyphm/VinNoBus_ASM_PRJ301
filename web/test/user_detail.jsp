<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Thông tin người dùng • VinNoBus</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;600;700&display=swap" rel="stylesheet">
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: { extend: {
        fontFamily: { mono: ['Roboto Mono','ui-monospace','SFMono-Regular'] },
        colors: { brand:{50:'#eff6ff',100:'#dbeafe',200:'#bfdbfe',300:'#93c5fd',400:'#60a5fa',500:'#3b82f6',600:'#2563eb',700:'#1d4ed8',800:'#1e40af',900:'#1e3a8a'} },
        boxShadow: { soft:'0 8px 24px rgba(2,6,23,.06)' }
      }}
    }
  </script>
  <style> html{font-family:'Roboto Mono',ui-monospace,SFMono-Regular,Menlo,Monaco,Consolas,'Liberation Mono','Courier New',monospace} </style>
</head>
<body class="bg-brand-50 text-slate-800 min-h-screen">
  <header class="border-b border-slate-200 bg-white">
    <div class="max-w-5xl mx-auto px-5 py-4 flex items-center justify-between">
      <a href="admin.jsp" class="flex items-center gap-2">
        <div class="w-8 h-8 rounded-xl bg-brand-600 text-white grid place-items-center font-semibold">V</div>
        <span class="font-semibold">VinNoBus</span>
      </a>
      <a href="info.jsp" class="text-sm text-brand-700 hover:underline">Trang thông tin</a>
    </div>
  </header>

  <main class="max-w-5xl mx-auto px-5 py-8">
    <h1 class="text-2xl font-semibold">Thông tin người dùng</h1>
    <p class="text-sm text-slate-600 mt-1">Chi tiết hồ sơ và trạng thái tài khoản.</p>

    <!-- Avatar + Basic -->
    <div class="mt-6 grid grid-cols-1 md:grid-cols-[160px_1fr] gap-6">
      <div class="rounded-2xl border border-slate-200 bg-white p-4 shadow-soft flex flex-col items-center">
        <img src="${empty user.avatarUrl ? 'https://ui-avatars.com/api/?name=' += (empty user.name ? 'U' : user.name) : user.avatarUrl}" alt="avatar"
             class="w-28 h-28 rounded-2xl object-cover border border-slate-200"/>
        <div class="mt-3 text-sm text-slate-500">User ID</div>
        <div class="font-medium">${empty user.userId ? '—' : user.userId}</div>
        <div class="mt-2 text-xs ${user.active ? 'text-emerald-600' : 'text-slate-500'}">
          ${user.active ? 'Đang hoạt động' : 'Tạm khóa'}
        </div>
      </div>

      <div class="rounded-2xl border border-slate-200 bg-white p-4 shadow-soft">
        <div class="grid sm:grid-cols-2 gap-4 text-sm">
          <div>
            <div class="text-slate-500">Họ & Tên</div>
            <div class="font-medium">${empty user.name ? '—' : user.name}</div>
          </div>
          <div>
            <div class="text-slate-500">Email</div>
            <div class="font-medium">${empty user.email ? '—' : user.email}</div>
          </div>
          <div>
            <div class="text-slate-500">Số điện thoại</div>
            <div class="font-medium">${empty user.phone ? '—' : user.phone}</div>
          </div>
          <div>
            <div class="text-slate-500">Ngày sinh</div>
            <div class="font-medium">
              <c:choose>
                <c:when test="${not empty user.dob}"><fmt:formatDate value="${user.dob}" pattern="dd/MM/yyyy"/></c:when>
                <c:otherwise>—</c:otherwise>
              </c:choose>
            </div>
          </div>
          <div class="sm:col-span-2">
            <div class="text-slate-500">Địa chỉ</div>
            <div class="font-medium">${empty user.address ? '—' : user.address}</div>
          </div>
        </div>

        <div class="mt-6 flex flex-wrap gap-3">
          <a href="/users/edit?id=${user.userId}" class="px-3 py-2 rounded-xl bg-brand-600 text-white text-sm hover:bg-brand-700 shadow-soft">Chỉnh sửa</a>
          <a href="/users" class="px-3 py-2 rounded-xl border border-brand-200 text-brand-700 text-sm hover:bg-brand-100">Danh sách user</a>
        </div>
      </div>
    </div>

    <!-- Developer note -->
    <div class="mt-6 text-xs text-slate-500">
      *Controller nên đặt thuộc tính request <code>user</code> là bean có các field: userId, active, name, email, phone, avatarUrl, dob(java.util.Date), address.
    </div>
  </main>
</body>
</html>
