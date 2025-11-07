/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package module.payment.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Calendar;
import java.util.Date;
import module.ticket.dao.TicketDAO;
import module.ticket.model.Ticket;

/**
 *
 * @author Tham
 */
public class paymentController extends HttpServlet {

    private final TicketDAO ticketDAO = new TicketDAO();

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
            out.println("<title>Servlet paymentController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet paymentController at " + request.getContextPath() + "</h1>");
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
            action = "list"; // default
        }
        switch (action) {

            case "buyTrip":
                request.getRequestDispatcher("/view/Buy/trip.jsp").forward(request, response);
                break;
            case "calcTrip":
                request.getRequestDispatcher("/view/Buy/trip.jsp").forward(request, response);
                break;

            case "buyMonth":
                buyMonth(request, response);
                request.getRequestDispatcher("/view/Buy/month.jsp").forward(request, response);
                break;
            case "calcMonth":
                calcMonth(request, response);
                request.getRequestDispatcher("/view/Buy/month.jsp").forward(request, response);
                break;

            default:
                request.setAttribute("error", "Action không hợp lệ!");
                request.getRequestDispatcher("/view/Ticket/sell.jsp").forward(request, response);
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
        if (action == null) {
            action = "list"; // default
        }
        switch (action) {

            case "buyTrip":
                buyTrip(request, response);
                request.getRequestDispatcher("/view/Buy/trip.jsp").forward(request, response);
                break;
            case "calcTrip":
                calcTrip(request, response);
                request.getRequestDispatcher("/view/Buy/trip.jsp").forward(request, response);
                break;

            case "buyMonth":
                buyMonth(request, response);
                request.getRequestDispatcher("/view/Buy/month.jsp").forward(request, response);
                break;
            case "calcMonth":
                calcMonth(request, response);
                request.getRequestDispatcher("/view/Buy/month.jsp").forward(request, response);
                break;

            default:
                request.setAttribute("error", "Action không hợp lệ!");
                request.getRequestDispatcher("/view/Ticket/sell.jsp").forward(request, response);
        }

    }

    private void buyTrip(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String customerId = request.getParameter("customerId");
            int tripId = Integer.parseInt(request.getParameter("tripId"));
            int qty = Integer.parseInt(request.getParameter("quantity"));
            double price = Double.parseDouble(request.getParameter("price"));
            double total = price * qty;

            // Insert tickets
            for (int i = 0; i < qty; i++) {
                Ticket ticket = new Ticket();
                ticket.setCustomerId(customerId);
                ticket.setTripId(tripId);
                ticket.setPrice(price);
                ticket.setIssueDate(new Date());
                ticketDAO.insertTicket(ticket);
            }

            request.setAttribute("message", "Mua vé thành công");
            request.getRequestDispatcher("/view/Buy/trip.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi mua vé: " + e.getMessage());
            request.getRequestDispatcher("/view/Buy/trip.jsp").forward(request, response);
        }
    }

    private void calcTrip(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String customerId = request.getParameter("customerId");
            int tripId = Integer.parseInt(request.getParameter("tripId"));
            int qty = Integer.parseInt(request.getParameter("quantity"));

            double price = 15000; // giá vé cố định
            double total = price * qty;

            // Tạo QR cho thanh toán
            String bank = "MBBank";
            String stk = "0965047076";

            String qrUrl = "https://img.vietqr.io/image/"
                    + bank + "-" + stk + "-compact2.jpg?amount=" + (int) total;

            // Truyền dữ liệu sang hóa đơn JSP
            request.setAttribute("customerId", customerId);
            request.setAttribute("tripId", tripId);
            request.setAttribute("qty", qty);
            request.setAttribute("price", price);
            request.setAttribute("total", total);
            request.setAttribute("qr", qrUrl);
            request.setAttribute("bank", bank);
            request.setAttribute("stk", stk);
            request.getRequestDispatcher("/view/Buy/trip.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi tính tiền: " + e.getMessage());
            request.getRequestDispatcher("/view/Buy/trip.jsp").forward(request, response);
        }
    }

    private void buyMonth(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            String customerId = (String) session.getAttribute("userId");
            int routeId = Integer.parseInt(request.getParameter("routeId"));
            double price = 400000;

            // Ngày bắt đầu và ngày hết hạn (30 ngày)
            Date issueDate = new Date();
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DATE, 30);
            Date expiry = cal.getTime();

            Ticket t = new Ticket();
            t.setCustomerId(customerId);
            t.setPrice(price);
            t.setIssueDate(issueDate);
            t.setExpiryDate(expiry);
            t.setRouteId(routeId);

            boolean ok = ticketDAO.insertTicket(t);

            if (ok) {
                request.setAttribute("message", "Mua vé tháng thành công!");
            } else {
                request.setAttribute("error", "Không thể lưu vé, vui lòng thử lại!");
            }

            request.getRequestDispatcher("/view/Buy/month.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi mua vé tháng: " + e.getMessage());
            request.getRequestDispatcher("/view/Buy/month.jsp").forward(request, response);
        }

    }

    private void calcMonth(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy thông tin từ form
            String customerId = request.getParameter("customerId");
            int routeId = Integer.parseInt(request.getParameter("routeId"));
            double price = 400000; // Giá vé tháng cố định
            double total = price;  // Chỉ 1 vé / tháng

            // Lấy thông tin ngân hàng và số tài khoản
            String bank = "MBBank";
            String stk = "0965047076";

            // Sinh URL QR thanh toán
            String qrUrl = "https://img.vietqr.io/image/"
                    + bank + "-" + stk + "-compact2.jpg?amount=" + (int) total
                    + "&addInfo=VE_THANG_" + customerId;

            // Gửi dữ liệu sang JSP hiển thị hóa đơn
            request.setAttribute("customerId", customerId);
            request.setAttribute("routeId", routeId);
            request.setAttribute("price", price);
            request.setAttribute("total", total);
            request.setAttribute("bank", bank);
            request.setAttribute("stk", stk);
            request.setAttribute("qr", qrUrl);

            request.getRequestDispatcher("/view/Buy/month.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi tính tiền: " + e.getMessage());
            request.getRequestDispatcher("/view/Buy/month.jsp").forward(request, response);
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

}
