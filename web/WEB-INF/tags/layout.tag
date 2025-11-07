<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ attribute name="title" required="true" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" scope="request" />


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

    <body class="bg-brand-50 min-h-screen text-slate-800 flex flex-col">

        <header class="border-b border-slate-200 bg-white">
            <jsp:include page="/WEB-INF/components/header.jsp"/>
        </header>

        <main class="flex-grow">
            <jsp:doBody/>
        </main>

        <footer class="bg-white border-t border-slate-200 mt-10">
            <jsp:include page="/WEB-INF/components/footer.jsp"/>
        </footer>

    </body>
</html>
