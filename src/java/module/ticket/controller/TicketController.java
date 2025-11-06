/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package module.ticket.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import module.invoice.model.Invoice;
import module.ticket.dao.TicketDAO;
import module.ticket.model.Ticket;
import module.ticket.service.TicketService;

/**
 *
 * @author Tham
 */
@WebServlet(name = "TicketController", urlPatterns = {"/TicketServlet"})
public class TicketController extends HttpServlet {

    private final TicketService ticketService = new TicketService();
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
            out.println("<title>Servlet TicketController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TicketController at " + request.getContextPath() + "</h1>");
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
            case "sell":
                request.getRequestDispatcher("/view/Ticket/sell.jsp").forward(request, response);
                break;
            case "checkin":
                request.getRequestDispatcher("/view/Ticket/checkin.jsp").forward(request, response);
                break;
            case "main":
                showMainMenu(request, response, action);
                break;
            case "history":
                try {
                TicketHistory(request, response);
            } catch (SQLException e) {
                request.setAttribute("error", "Không thể tải lịch sử vé: " + e.getMessage());
            }
            request.getRequestDispatcher("/view/Ticket/TicketHistory.jsp").forward(request, response);
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
            case "sell":
                TicketSell(request, response);
                request.getRequestDispatcher("/view/Ticket/sell.jsp").forward(request, response);
                break;
            case "checkin":
                TicketCheckin(request, response);
                request.getRequestDispatcher("/view/Ticket/checkin.jsp").forward(request, response);
                break;

            case "history":
                try {
                TicketHistory(request, response);
            } catch (SQLException e) {
                request.setAttribute("error", "Không thể tải lịch sử vé: " + e.getMessage());
            }
            request.getRequestDispatcher("/view/Ticket/TicketHistory.jsp").forward(request, response);
            break;
            default:
                request.setAttribute("error", "Action không hợp lệ!");
                request.getRequestDispatcher("/view/Ticket/sell.jsp").forward(request, response);
        }

    }

    private void showMainMenu(HttpServletRequest request, HttpServletResponse response, String jspPath)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/Ticket/main.jsp").forward(request, response);
    }

    private void TicketSell(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // 🧱 Lấy dữ liệu từ form 
            String customerId = request.getParameter("customerId");
            String ticketType = request.getParameter("ticketType");
            String tripIdStr = request.getParameter("tripId");
            String routeIdStr = request.getParameter("routeId");
            String priceStr = request.getParameter("price");
            String createdBy = request.getParameter("createdBy");
            String paymentMethod = request.getParameter("paymentMethod"); // "CASH" hoặc "ONLINE"

            if (customerId == null || priceStr == null || createdBy == null
                    || customerId.isEmpty() || priceStr.isEmpty() || createdBy.isEmpty()
                    || ticketType == null || paymentMethod == null) {
                request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");

                return;
            }

            // 🧱 Tạo Ticket
            double price = Double.parseDouble(priceStr);
            Ticket ticket = new Ticket();
            ticket.setCustomerId(customerId);
            ticket.setPrice(price);
            ticket.setCreatedBy(createdBy);
            ticket.setIssueDate(new Date());
            int quantity = 1;
            try {
                quantity = Integer.parseInt(request.getParameter("quantity"));
            } catch (Exception e) {
                quantity = 1;

            }
            if (ticketType.equals("TRIP")) {
                if (tripIdStr == null || tripIdStr.isEmpty()) {
                    request.setAttribute("error", "Vui lòng nhập ID chuyến cho vé lượt!");
                    return;
                }
                ticket.setTripId(Integer.parseInt(tripIdStr));
                ticket.setRouteId(0); // TRIP thì không cần route
                ticket.setExpiryDate(null);
            } else {
                ticket.setRouteId(Integer.parseInt(routeIdStr));
                java.util.Calendar cal = java.util.Calendar.getInstance();
                cal.setTime(new Date());
                if (ticketType.equals("DAY")) {
                    cal.add(java.util.Calendar.DATE, 1);
                } else {
                    cal.add(java.util.Calendar.MONTH, 1);
                }
                ticket.setExpiryDate(new java.sql.Date(cal.getTimeInMillis()));
            }

            Invoice invoice = ticketService.sellTicket(ticket, paymentMethod);

            if (invoice != null) {
                request.setAttribute("invoice", invoice);
                request.setAttribute("message", "Bán vé và tạo hóa đơn thành công!");

                if ("ONLINE".equalsIgnoreCase(paymentMethod)) {
                    // Lấy thông tin ngân hàng cố định (hoặc cho phép chọn từ form)
                    String bank = request.getParameter("bank");
                    String stk = request.getParameter("stk");
                    double amount = ticket.getPrice(); // Lấy số tiền thật từ hóa đơn

                    // Tạo URL QR VietQR
                    String qrUrl = "https://img.vietqr.io/image/"
                            + bank + "-" + stk + "-compact2.jpg"
                            + "?amount=" + (int) amount; // Ép sang int để gọn tiền

                    request.setAttribute("qr", qrUrl);
                    request.setAttribute("amount", (int) amount);
                    request.setAttribute("bank", bank);
                    request.setAttribute("stk", stk);
                    request.getRequestDispatcher("/view/Ticket/sell.jsp").forward(request, response);
                    return;
//                } 
//                else if ("CASH".equalsIgnoreCase(paymentMethod)) {
//                    request.setAttribute("message", "Thanh toán tiền mặt thành công!");
//                    request.getRequestDispatcher("/view/Ticket/sell.jsp").forward(request, response);
//                    return;
                } else {
                    request.getRequestDispatcher("/view/Ticket/invoice.jsp").forward(request, response);
                    return;
                }
            }
            // Nếu có lỗi không tạo được
            request.setAttribute("error", "Không thể tạo vé!");
            request.getRequestDispatcher("/view/Ticket/sell.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/view/Ticket/sell.jsp").forward(request, response);
        }

    }

    private void TicketCheckin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String customerIdStr = request.getParameter("customerId");
            String routeIdStr = request.getParameter("routeId");

            if (customerIdStr == null || routeIdStr == null || customerIdStr.isEmpty() || routeIdStr.isEmpty()) {
                request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
                request.getRequestDispatcher("/view/Ticket/checkin.jsp").forward(request, response);
                return;
            }
            int routeId = Integer.parseInt(routeIdStr);
            String customerId = customerIdStr.trim();
            boolean valid = ticketService.validateMonthlyTicket(customerId, routeId);
            Ticket ticket = ticketService.getMonthlyTicket(customerId, routeId);

            if (valid && ticket != null) {
                request.setAttribute("message", "Vé tháng hợp lệ! Hết hạn: " + ticket.getExpiryDate());
            } else {
                request.setAttribute("error", "Vé tháng không hợp lệ hoặc đã hết hạn!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }

    }

    private void TicketHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        try {
            HttpSession session = request.getSession();
            String role = (String) session.getAttribute("role");
            String customerIdParam = request.getParameter("customerId");
            String sessionCustomerId = (String) session.getAttribute("customerId");

            TicketDAO dao = new TicketDAO();
            List<Ticket> tickets;

            // Nếu là customer → bắt buộc dùng session ID
            if ("customer".equalsIgnoreCase(role)) {
                if (sessionCustomerId == null) {
                    request.setAttribute("error", "Bạn chưa đăng nhập!");
                } else {
                    tickets = dao.getTicketsByCustomerId(sessionCustomerId);
                    request.setAttribute("tickets", tickets);
                }

                // Admin
            } else if ("admin".equalsIgnoreCase(role)) {
                // Admin tự chọn customer để xem, nếu không chọn → xem tất cả
                if (customerIdParam != null && !customerIdParam.isEmpty()) {
                    tickets = dao.getTicketsByCustomerId(customerIdParam);
                } else {
                    tickets = dao.findAll();
                }
                request.setAttribute("tickets", tickets);

            } else {
                request.setAttribute("error", "Không có quyền truy cập");
            }

            request.getRequestDispatcher("/view/Ticket/history.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi tải lịch sử vé: " + e.getMessage());
            request.getRequestDispatcher("/view/Ticket/TicketHistory.jsp").forward(request, response);
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
