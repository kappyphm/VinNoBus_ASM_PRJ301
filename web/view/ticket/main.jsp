<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="ui" tagdir="/WEB-INF/tags" %>

<ui:layout>
    <jsp:attribute name="title">Bán vé và checkin vé tháng • VinNoBus</jsp:attribute>

    <jsp:body>
        <div class="bg-brand-50 min-h-screen flex items-center justify-center text-slate-800">

            <div class="bg-white rounded-2xl shadow-soft p-10 w-full max-w-md border border-slate-200 text-center">
                <div class="flex items-center justify-center mb-5">
                    <div class="w-14 h-14 rounded-xl bg-brand-600 text-white grid place-items-center text-3xl shadow-soft">🚌</div>
                </div>

                <h1 class="text-2xl font-bold text-brand-700 mb-8">VinNoBus Ticket Management</h1>

                <form action="${pageContext.request.contextPath}/view/ticket/sell.jsp" method="get" class="mb-4">
                    <button type="submit"
                            class="w-full bg-brand-600 hover:bg-brand-700 text-white py-3 rounded-xl font-semibold text-base transition-all shadow-soft">
                        🎟️ Bán Vé Lượt
                    </button>
                </form>

                <form action="${pageContext.request.contextPath}/view/ticket/checkin.jsp" method="get" class="mb-4">
                    <button type="submit"
                            class="w-full bg-brand-600 hover:bg-brand-700 text-white py-3 rounded-xl font-semibold text-base transition-all shadow-soft">
                        🧾 Check-in Vé Tháng
                    </button>
                </form>

                <p class="text-xs text-slate-500 mt-6">© 2025 VinNoBus • Ticket Management System</p>
            </div>

        </div>
    </jsp:body>
</ui:layout>
