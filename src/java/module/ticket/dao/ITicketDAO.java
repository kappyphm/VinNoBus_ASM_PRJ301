/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.ticket.dao;

import module.ticket.model.Ticket;
import java.sql.*;
import java.util.List;
/**
 *
 * @author Tham
 */
public interface ITicketDAO {
    boolean insertTicket(Ticket ticket) throws SQLException;
    List<Ticket> findAll() throws SQLException;
    
}
