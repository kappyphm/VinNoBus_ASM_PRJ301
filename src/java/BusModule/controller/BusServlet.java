/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package BusModule.controller;

import BusModule.model.Bus;
import BusModule.services.BusServices;
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
@WebServlet(name = "BusServlet", urlPatterns = {"/BusServlet"})
public class BusServlet extends HttpServlet {

    BusServices busServices;

    @Override
    public void init() throws ServletException {
        busServices = new BusServices();
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
            out.println("<title>Servlet BusServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BusServlet at " + request.getContextPath() + "</h1>");
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
            action = "list";
        }

        try {
            switch (action) {
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteBus(request, response);
                    break;
                case "search":
                    searchBus(request, response);
                    break;
                case "detail":
                    showDetail(request, response);
                    break;
                default:
                    listBus(request, response);
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
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "add":
                    insertBus(request, response);
                    break;
                case "update":
                    updateBus(request, response);
                    break;
                default:
                    listBus(request, response);
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

    private void listBus(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String search = request.getParameter("search");
        String sort = request.getParameter("sort");
        int page = 1;
        int pageSize = 10;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        List<Bus> list = busServices.getAllBuses(search, sort, page, pageSize);
        int total = busServices.countAllBuses();
        int totalPages = (int) Math.ceil((double) total / pageSize);

        request.setAttribute("busList", list);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("/WEB-INF/Bus/BusList.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Bus/BusAdd.jsp").forward(request, response);
    }

    private void insertBus(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        String plate = request.getParameter("plate_number");
        String capStr = request.getParameter("capacity");
        int capacity = 0;
        try {
            capacity = Integer.parseInt(capStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dung lượng phải là số hợp lệ.");
            request.getRequestDispatcher("/WEB-INF/Bus/BusAdd.jsp").forward(request, response);
            return;
        }

        Bus bus = new Bus(0, plate, capacity);
        boolean success = busServices.addBus(bus);

        if (success) {
            response.sendRedirect("BusServlet?action=list");
        } else {
            request.setAttribute("error", "Không thể thêm xe bus (có thể trùng biển số).");
            request.getRequestDispatcher("/WEB-INF/Bus/BusAdd.jsp").forward(request, response);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Bus bus = busServices.getBusById(id);
        if (bus == null) {
            response.sendRedirect("BusServlet?action=list");
            return;
        }
        request.setAttribute("bus", bus);
        request.getRequestDispatcher("/WEB-INF/Bus/BusEditForm.jsp").forward(request, response);
    }

    private void updateBus(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("bus_id"));
        String plate = request.getParameter("plate_number");
        int capacity = Integer.parseInt(request.getParameter("capacity"));

        Bus bus = new Bus(id, plate, capacity);
        boolean success = busServices.updateBus(bus);

        if (success) {
            response.sendRedirect("BusServlet?action=list");
        } else {
            request.setAttribute("error", "Cập nhật thất bại!");
            request.setAttribute("bus", bus);
            request.getRequestDispatcher("/WEB-INF/Bus/BusEditForm.jsp").forward(request, response);
        }
    }

    private void deleteBus(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        busServices.deleteBus(id);
        response.sendRedirect("BusServlet?action=list");
    }

    private void searchBus(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Bus> list = busServices.searchBusByPlate(keyword);
        request.setAttribute("busList", list);
        request.getRequestDispatcher("/WEB-INF/Bus/BusList.jsp").forward(request, response);
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Bus bus = busServices.getBusById(id);
        request.setAttribute("bus", bus);
        request.getRequestDispatcher("/WEB-INF/Bus/BusDetail.jsp").forward(request, response);
    }
                                                                                            
}
