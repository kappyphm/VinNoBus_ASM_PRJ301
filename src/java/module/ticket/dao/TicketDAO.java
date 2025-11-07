/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.ticket.dao;

import dal.DBContext;

import java.sql.PreparedStatement;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import module.ticket.model.Ticket;

/**
 *
 * @author Tham
 */
public class TicketDAO extends DBContext implements ITicketDAO {

    @Override
    public boolean insertTicket(Ticket ticket) throws SQLException {

        String sql = "INSERT INTO Ticket (customer_id, trip_id, route_id, price, issue_date, expiry_date, invoice_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, ticket.getCustomerId());
            ps.setObject(2, ticket.getTripId() == 0 ? null : ticket.getTripId());
            ps.setObject(3, ticket.getRouteId() == 0 ? null : ticket.getRouteId());
            ps.setDouble(4, ticket.getPrice());
            ps.setTimestamp(5, new java.sql.Timestamp(ticket.getIssueDate().getTime()));
            if (ticket.getExpiryDate() != null) {
                ps.setDate(6, new java.sql.Date(ticket.getExpiryDate().getTime()));
            } else {
                ps.setNull(6, java.sql.Types.DATE);
            }
            ps.setObject(7, ticket.getInvoiceId());

            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Lỗi khi thêm vé: " + e.getMessage());
            throw new RuntimeException(e.getMessage());

        }
    }

    @Override
    public List<Ticket> findAll() throws SQLException {
        List<Ticket> list = new ArrayList<>();
        String sql = "SELECT * FROM Ticket";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Ticket t = new Ticket();
                t.setTicketId(rs.getInt("ticket_id"));
                t.setCustomerId(rs.getString("customer_id"));
                t.setTripId(rs.getInt("trip_id"));
                t.setRouteId(rs.getInt("route_id"));
                t.setPrice(rs.getDouble("price"));
                t.setIssueDate(rs.getDate("issue_date"));
                t.setExpiryDate(rs.getDate("expiry_date"));
                t.setInvoiceId(rs.getObject("invoice_id", Integer.class));
                list.add(t);
            }

        } catch (SQLException e) {
            System.out.println("Lỗi khi lấy danh sách vé: " + e.getMessage());
        }
        return list;

    }

    public Ticket findMonthlyTicket(String customerId, int routeId) throws SQLException {
        String sql = "SELECT * FROM Ticket WHERE customer_id = ? AND route_id = ? AND expiry_date >= GETDATE()";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, customerId);
            ps.setInt(2, routeId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Ticket ticket = new Ticket();
                    ticket.setTicketId(rs.getInt("ticket_id"));
                    ticket.setCustomerId(rs.getString("customer_id"));
                    ticket.setRouteId(rs.getInt("route_id"));
                    ticket.setIssueDate(rs.getDate("issue_date"));
                    ticket.setExpiryDate(rs.getDate("expiry_date"));
                    ticket.setPrice(rs.getDouble("price"));
                    ticket.setInvoiceId(rs.getObject("invoice_id", Integer.class));
                    return ticket;
                }
            }
        } catch (SQLException e) {
            System.out.println("❌ Lỗi khi tìm vé tháng: " + e.getMessage());
        }
        return null;
    }

    public Ticket findTicketById(String ticketId) throws SQLException {
        String sql = "SELECT * FROM Ticket WHERE ticket_id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, ticketId);
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            Ticket t = new Ticket();
            t.setTicketId(rs.getInt("ticket_id"));
            t.setCustomerId(rs.getString("customer_id"));
            t.setPrice(rs.getDouble("price"));
            t.setTripId(rs.getInt("trip_id"));
            t.setRouteId(rs.getInt("route_id"));
            t.setIssueDate(rs.getDate("issue_date"));
            t.setExpiryDate(rs.getDate("expiry_date"));
            t.setInvoiceId(rs.getInt("invoice_id"));
            return t;
        }
        return null;
    }

    public List<Map<String, Object>> getAllRoutes() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT route_id, route_name FROM Route ORDER BY route_id";
        try {
            if (connection == null || connection.isClosed()) {
                System.out.println("⚠️ Kết nối null trong getAllRoutes()");
                return list;
            }

            try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Map<String, Object> r = new HashMap<>();
                    r.put("route_id", rs.getInt("route_id"));
                    r.put("route_name", rs.getString("route_name"));
                    list.add(r);
                }
            }
        } catch (Exception e) {
            System.out.println("❌ Lỗi lấy danh sách tuyến: " + e.getMessage());
        }
        return list;
    }
}
