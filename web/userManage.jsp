<%-- 
    Document   : userManage
    Created on : Oct 14, 2025, 8:00:15 AM
    Author     : kappyphm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Người Dùng</title>
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
        <div class="min-h-screen container mx-auto p-4 sm:p-6 lg:p-8">
            <div class="bg-white p-8 rounded-[5px] shadow-sm">
                <div class="flex justify-between items-center mb-6">
                    <h1 class="text-2xl font-bold">Danh Sách Người Dùng</h1>
                    <a href="private.jsp" class="text-black hover:underline text-sm">Quay lại</a>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead class="border-b">
                            <tr>
                                <th class="p-3">ID</th>
                                <th class="p-3">Tên đăng nhập</th>
                                <th class="p-3">Email (Ví dụ)</th>
                                <th class="p-3">Vai trò (Ví dụ)</th>
                                <th class="p-3 text-right">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Dữ liệu mẫu -->
                            <tr class="border-b hover:bg-gray-50">
                                <td class="p-3">1</td>
                                <td class="p-3">admin</td>
                                <td class="p-3">admin@example.com</td>
                                <td class="p-3">Quản trị viên</td>
                                <td class="p-3 text-right">
                                    <a href="#" class="text-blue-600 hover:underline mr-4">Sửa</a>
                                    <a href="#" class="text-red-600 hover:underline">Xóa</a>
                                </td>
                            </tr>
                            <tr class="border-b hover:bg-gray-50">
                                <td class="p-3">2</td>
                                <td class="p-3">user01</td>
                                <td class="p-3">user01@example.com</td>
                                <td class="p-3">Người dùng</td>
                                <td class="p-3 text-right">
                                    <a href="#" class="text-blue-600 hover:underline mr-4">Sửa</a>
                                    <a href="#" class="text-red-600 hover:underline">Xóa</a>
                                </td>
                            </tr>
                            <tr class="border-b hover:bg-gray-50">
                                <td class="p-3">3</td>
                                <td class="p-3">user02</td>
                                <td class="p-3">user02@example.com</td>
                                <td class="p-3">Người dùng</td>
                                <td class="p-3 text-right">
                                    <a href="#" class="text-blue-600 hover:underline mr-4">Sửa</a>
                                    <a href="#" class="text-red-600 hover:underline">Xóa</a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
