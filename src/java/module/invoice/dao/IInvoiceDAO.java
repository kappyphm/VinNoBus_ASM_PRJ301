/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.invoice.dao;

import module.invoice.model.Invoice;
import java.sql.*;
/**
 *
 * @author Tham
 */
public interface IInvoiceDAO {
    int insertInvoice(Invoice invoice) throws SQLException;
    
}
