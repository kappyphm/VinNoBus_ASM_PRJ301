<%-- 
    Document   : Header
    Created on : Oct 16, 2025, 3:32:33 PM
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý người dùng • VinNoBus</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:wght@400;500;600;700&display=swap" rel="stylesheet">
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {extend: {
                        fontFamily: {mono: ['Roboto Mono', 'ui-monospace', 'SFMono-Regular']},
                        colors: {brand: {50: '#eff6ff', 100: '#dbeafe', 200: '#bfdbfe', 300: '#93c5fd', 400: '#60a5fa', 500: '#3b82f6', 600: '#2563eb', 700: '#1d4ed8', 800: '#1e40af', 900: '#1e3a8a'}},
                        boxShadow: {soft: '0 8px 24px rgba(2,6,23,.06)'}
                    }}
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

    <body class="bg-brand-50 text-slate-800 min-h-screen">
        <header class="border-b border-slate-200 bg-white">
            <div class="max-w-5xl mx-auto px-5 py-4 flex items-center justify-between">
                <a href="admin.jsp" class="flex items-center gap-2">
                    <div class="w-8 h-8 rounded-xl bg-brand-600 text-white grid place-items-center font-semibold">V</div>
                    <span class="font-semibold">VinNoBus</span>
                </a>
                <jsp:include page="/view/auth/component/LoginComp.jsp" />
            </div>
        </header>