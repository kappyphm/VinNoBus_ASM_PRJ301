<%@ page contentType="text/html; charset=UTF-8" %>

<div class="bg-white shadow-soft border-b border-slate-200">
    <div class="max-w-5xl mx-auto px-5 py-4 flex items-center justify-between">

        <!-- Logo -->
        <a href="${ctx}/" class="flex items-center gap-2">
            <div class="w-8 h-8 rounded-xl bg-brand-600 text-white grid place-items-center font-semibold">V</div>
            <span class="font-semibold text-lg text-slate-900">VinNoBus</span>
        </a>

        <!-- Menu -->
        <nav class="flex items-center gap-4 text-slate-700 font-medium">
            <a href="BusServlet?action=list" class="px-3 py-1 rounded-xl hover:bg-brand-50 hover:text-brand-600 transition">Bus</a>
            <a href="RouteServlet?action=list" class="px-3 py-1 rounded-xl hover:bg-brand-50 hover:text-brand-600 transition">Route</a>
            <a href="TripServlet?action=list" class="px-3 py-1 rounded-xl hover:bg-brand-50 hover:text-brand-600 transition">Trip</a>
            <a href="TicketServlet?action=list" class="px-3 py-1 rounded-xl hover:bg-brand-50 hover:text-brand-600 transition">Ticket</a>
            <a href="StationServlet?action=list" class="px-3 py-1 rounded-xl hover:bg-brand-50 hover:text-brand-600 transition">Station</a>
            <a href="${ctx}/customers" class="px-3 py-1 rounded-xl hover:bg-brand-50 hover:text-brand-600 transition">Customer</a>
            <a href="${ctx}/staffs" class="px-3 py-1 rounded-xl hover:bg-brand-50 hover:text-brand-600 transition">Staff</a>
        </nav>

        <!-- Login Button -->
        <div>
            <jsp:include page="/WEB-INF/components/LoginButton.jsp" />
        </div>

    </div>
</div>
