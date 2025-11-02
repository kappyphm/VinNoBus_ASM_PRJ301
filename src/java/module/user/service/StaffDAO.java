/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.user.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import module.core.AbstractDAO;
import module.user.model.entity.Staff;

/**
 *
 * @author kappyphm
 */
public class StaffDAO extends AbstractDAO<Staff, String> {

    public StaffDAO(Connection connection) {
        super(connection);
    }

    @Override
    protected Staff mapResultSetToEntity(ResultSet rs) throws SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected String extractGeneratedKey(ResultSet rs) throws SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    protected String getTableName() {
        return "staff";
    }

    @Override
    protected String getPrimaryKeyColumn() {
        return "user_id";
    }

    @Override
    protected PreparedStatement prepareInsertStatement(Staff entity, Connection conn) throws SQLException {
        
    }

    @Override
    protected PreparedStatement prepareUpdateStatement(Staff entity, Connection conn) throws SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    
}
