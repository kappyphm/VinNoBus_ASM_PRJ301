<%-- 
    Document   : Header
    Created on : Oct 16, 2025, 3:32:33 PM
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<header class="border-b border-slate-200 bg-white">
    <div class="max-w-5xl mx-auto px-5 py-4 flex items-center justify-between">
        <a href="admin.jsp" class="flex items-center gap-2">
            <div class="w-8 h-8 rounded-xl bg-brand-600 text-white grid place-items-center font-semibold">V</div>
            <span class="font-semibold">VinNoBus</span>
        </a>
        <jsp:include page="/view/auth/component/LoginComp.jsp" />
    </div>
</header>