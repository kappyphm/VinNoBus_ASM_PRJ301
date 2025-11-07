/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.ticket.service;

import dal.DBContext;
import java.util.Date;
import module.invoice.dao.InvoiceDAO;
import module.invoice.model.Invoice;
import module.ticket.dao.TicketDAO;
import module.ticket.model.Ticket;
import java.sql.*;

/**
 *
 * @author Tham
 */
public class TicketService {

    private final DBContext db = new DBContext();

    private final TicketDAO ticketDAO = new TicketDAO();
    private final InvoiceDAO invoiceDAO = new InvoiceDAO();

    public Invoice sellTicket(Ticket ticket, String paymentMethod) {

        try {
            // 1️⃣ Tạo hóa đơn
            Invoice invoice = new Invoice();
            invoice.setPaymentMethod(paymentMethod);
            invoice.setPaymentDate(new Date());
            invoice.setStatus("PAID");

            int invoiceId = invoiceDAO.insertInvoice(invoice);
            System.out.println("Invoice ID sau khi insert: " + invoiceId);

            if (invoiceId == -1) {
                System.out.println("Không thể tạo hóa đơn (insertInvoice lỗi)");
                return null;
            }

            // 2️⃣ Gắn invoice_id vào vé
            
        invoice.setInvoiceId(invoiceId); //set đúng mã thực tế vừa sinh trong DB

        ticket.setInvoiceId(invoiceId);
        boolean success = ticketDAO.insertTicket(ticket);

        if (success) return invoice; // Trả lại hóa đơn thật
        return null;
        } catch (SQLException e) {
            System.out.println("💥 SQLException trong TicketService: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    public boolean validateMonthlyTicket(String customerId, int routeId) throws SQLException {
        Ticket ticket = ticketDAO.findMonthlyTicket(customerId, routeId);
        return ticket != null;
    }

    // Lấy thông tin TicketCheckinDTO
    public Ticket getMonthlyTicket(String customerId, int routeId) throws SQLException {
        return ticketDAO.findMonthlyTicket(customerId, routeId);
    }

   
}
