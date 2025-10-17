/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.impl;

import static constant.Query.ADD_STAFF;
import static constant.Query.DELETE_STAFF_BY_USERID;
import static constant.Query.UPDATE_STAFF;
import dal.DBContext;
import dao.IStaffDAO;
import java.sql.*;
import java.util.List;
import java.util.UUID;
import model.entity.Staff;

/**
 *
 * @author kappyphm
 */
public class StaffDAO extends DBContext implements IStaffDAO {

    @Override
    public void save(Staff staff) throws SQLException {
        try (var st = connection.prepareStatement(ADD_STAFF)) {
            st.setObject(1, staff.getUser_id());
            st.setString(2, staff.getStaffCode());
            st.setString(3, staff.getFullName());
            st.setString(4, staff.getPhone());
            st.setString(5, staff.getDepartment());
            st.setString(6, staff.getPosition());

            st.executeUpdate();
        }

    }

    @Override
    public void update(Staff staff) throws SQLException {
        try (var st = connection.prepareStatement(UPDATE_STAFF)) {
            st.setObject(6, staff.getUser_id());
            st.setString(1, staff.getStaffCode());
            st.setString(2, staff.getFullName());
            st.setString(3, staff.getPhone());
            st.setString(4, staff.getDepartment());
            st.setString(5, staff.getPosition());

            st.executeUpdate();
        }
    }

    @Override
    public void deleteByUserId(UUID userId) throws SQLException {
        try (var st = connection.prepareStatement(DELETE_STAFF_BY_USERID)) {
            st.setObject(1, userId);

            st.executeUpdate();
        }
    }

    @Override
    public Staff findById(int id) throws SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Staff findByUserId(UUID userId) throws SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Staff> findAll() throws SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
