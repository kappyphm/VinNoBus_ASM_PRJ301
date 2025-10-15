/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package RouteModule.controller;

import RouteModule.model.Route;
import RouteModule.services.RouteServices;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "RouteServlet", urlPatterns = {"/RouteServlet"})
public class RouteServlet extends HttpServlet {

    private RouteServices routeServices;

    @Override
    public void init() throws ServletException {
        routeServices = new RouteServices();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RouteServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RouteServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list"; // mặc định hiển thị danh sách
        }
        try {
            switch (action) {
                case "list":
                    listRoutes(request, response);
                    break;
                case "details":
                    showDetails(request, response);
                    break;
                case "add":   
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteRoute(request, response);
                    break;
                default:
                    listRoutes(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    addRoute(request, response);
                    break;
                case "update":
                    updateRoute(request, response);
                    break;
                default:
                    listRoutes(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    // ======================= CÁC HÀM XỬ LÝ =======================

    private void listRoutes(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String search = request.getParameter("search");
        String type = request.getParameter("type");
        String sortColumn = request.getParameter("sortColumn");
        String sortOrder = request.getParameter("sortOrder");

        int page = 1;
        int pageSize = 10;

        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        List<Route> list = routeServices.getAllRoutes(search, type, sortColumn, sortOrder, page, pageSize);
        int total = routeServices.countRoutes(search, type);

        // ✅ Tính số trang
        int totalPages = (int) Math.ceil((double) total / pageSize);

        // ✅ Gửi sang JSP
        request.setAttribute("listRoutes", list);
        request.setAttribute("totalRoutes", total);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);
        request.setAttribute("type", type);
        request.setAttribute("sortColumn", sortColumn);
        request.setAttribute("sortOrder", sortOrder);

        // ✅ Đảm bảo đường dẫn đúng cấu trúc /WEB-INF/Route/
        request.getRequestDispatcher("/WEB-INF/Route/RouteList.jsp").forward(request, response);
    }

    private void showDetails(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Route route = routeServices.getRouteDetails(id);
        request.setAttribute("route", route);
        request.getRequestDispatcher("/WEB-INF/Route/RouteDetails.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Route route = routeServices.getRouteById(id);
        request.setAttribute("route", route);
        request.getRequestDispatcher("/WEB-INF/Route/RouteForm.jsp").forward(request, response);
    }

    private void addRoute(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String name = request.getParameter("routeName");
        String type = request.getParameter("type");
        int frequency = Integer.parseInt(request.getParameter("frequency"));

        Route route = new Route(0, name, type, frequency);
        boolean success = routeServices.addRoute(route);

        if (success) {
            response.sendRedirect("RouteServlet?action=list");
        } else {
            request.setAttribute("errorMessage", "Tuyến đường đã tồn tại!");
            request.getRequestDispatcher("/WEB-INF/Route/RouteForm.jsp").forward(request, response);
        }
    }

    private void updateRoute(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("routeId"));
        String name = request.getParameter("routeName");
        String type = request.getParameter("type");
        int frequency = Integer.parseInt(request.getParameter("frequency"));

        Route route = new Route(id, name, type, frequency);
        routeServices.updateRoute(route);
        response.sendRedirect("RouteServlet?action=list");
    }

    private void deleteRoute(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        routeServices.deleteRoute(id);
        response.sendRedirect("RouteServlet?action=list");
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Route/RouteForm.jsp").forward(request, response);
    }

}
