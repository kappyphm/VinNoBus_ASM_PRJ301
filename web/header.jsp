<%@ page contentType="text/html; charset=UTF-8" %> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>

<header
  class="sticky top-0 z-50 bg-[rgba(0,98,204,0.9)] backdrop-blur-md text-white shadow-lg px-6 md:px-12 py-4 flex items-center justify-between"
>
  <!-- Logo -->
  <div
    class="flex items-center gap-2 text-xl font-bold cursor-pointer"
    onclick="window.location.href = 'index.jsp'"
  >
    🚌 <span>Bus Management System</span>
  </div>

  <!-- Navigation -->
  <nav>
    <ul class="flex flex-wrap gap-6 md:gap-10 items-center">
      <li>
        <a
          href="BusServlet?action=list"
          class="relative font-medium hover:text-yellow-300 after:absolute after:left-0 after:-bottom-0.5 after:h-[2px] after:w-0 after:bg-yellow-300 after:transition-all hover:after:w-full"
        >
          Xe Bus
        </a>
      </li>

      <li>
        <a
          href="RouteServlet?action=list"
          class="relative font-medium hover:text-yellow-300 after:absolute after:left-0 after:-bottom-0.5 after:h-[2px] after:w-0 after:bg-yellow-300 after:transition-all hover:after:w-full"
        >
          Tuyến Đường
        </a>
      </li>

      <li>
        <a
          href="TripServlet?action=list"
          class="relative font-medium hover:text-yellow-300 after:absolute after:left-0 after:-bottom-0.5 after:h-[2px] after:w-0 after:bg-yellow-300 after:transition-all hover:after:w-full"
        >
          Chuyến Xe
        </a>
      </li>

      <li>
        <a
          href="StationServlet?action=list"
          class="relative font-medium hover:text-yellow-300 after:absolute after:left-0 after:-bottom-0.5 after:h-[2px] after:w-0 after:bg-yellow-300 after:transition-all hover:after:w-full"
        >
          Trạm Xe
        </a>
      </li>

      <li>
        <a
          href="TicketServlet?action=list"
          class="relative font-medium hover:text-yellow-300 after:absolute after:left-0 after:-bottom-0.5 after:h-[2px] after:w-0 after:bg-yellow-300 after:transition-all hover:after:w-full"
        >
          Vé
        </a>
      </li>

      <li>
        <a
          href="ReportServlet?action=overview"
          class="relative font-medium hover:text-yellow-300 after:absolute after:left-0 after:-bottom-0.5 after:h-[2px] after:w-0 after:bg-yellow-300 after:transition-all hover:after:w-full"
        >
          Báo Cáo
        </a>
      </li>

      <!-- Auth Component -->
      <li class="text-white"><%@include file="/components/AuthComp.jsp" %></li>
    </ul>
  </nav>
</header>
