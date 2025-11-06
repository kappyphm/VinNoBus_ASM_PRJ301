/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.invoice.dao;

import dal.DBContext;
import java.sql.*;
import module.invoice.model.Invoice;

public class InvoiceDAO extends DBContext implements IInvoiceDAO {

    @Override
    public int insertInvoice(Invoice invoice) throws SQLException {
        int id = -1;
        String sql = "INSERT INTO Invoice (payment_method, payment_date, status) VALUES (?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, invoice.getPaymentMethod());
            ps.setTimestamp(2, new Timestamp(invoice.getPaymentDate().getTime()));
            ps.setString(3, invoice.getStatus());
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                id = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi thêm hóa đơn: " + e.getMessage());
            e.printStackTrace();
        }

        return id;
    }
    public int createInvoice(String paymentMethod) throws SQLException {
        String sql = "INSERT INTO Invoice(payment_method, status) VALUES (?, 'PENDING')";
        try (PreparedStatement ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, paymentMethod);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // trả về invoice_id vừa tạo
                }
            }
        }
        return -1; // lỗi
    }
    public void updateInvoiceStatus(int invoiceId, String status) throws SQLException {
        String sql = "UPDATE Invoice SET status=? WHERE invoice_id=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, status);
        ps.setInt(2, invoiceId);
        ps.executeUpdate();
    }
}
