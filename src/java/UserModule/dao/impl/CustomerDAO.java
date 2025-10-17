/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package UserModule.dao.impl;

import static UserModule.constant.Query.*;
import dal.DBContext;
import UserModule.dao.ICustomerDAO;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import UserModule.model.entity.Customer;

/**
 *
 * @author kappyphm
 */
public class CustomerDAO extends DBContext implements ICustomerDAO {

    @Override
    public void save(Customer customer) throws SQLException {
        String sql = ADD_CUSTOMER;
        try(var ps = connection.prepareStatement(sql)) {
            ps.setObject(1, customer.getUser());
            ps.setString(2, customer.getCustomerCode());
            ps.setString(3, customer.getFullName());
            ps.setString(4, customer.getPhone());
            ps.setString(5, customer.getAddress());
            ps.executeUpdate();
        }

    }

    @Override
    public void update(Customer customer) throws SQLException {
        String sql = UPDATE_CUSTOMER;
        try(var ps = connection.prepareStatement(sql)) {
            ps.setString(1, customer.getCustomerCode());
            ps.setString(2, customer.getFullName());
            ps.setString(3, customer.getPhone());
            ps.setString(4, customer.getAddress());
            ps.setObject(5, customer.getUser());
            ps.executeUpdate();
        }
    }

    @Override
    public void deleteByUserId(UUID userId) throws SQLException {
        String sql = DELETE_CUSTOMER_BY_USERID;
        try(var ps = connection.prepareStatement(sql)) {
            ps.setObject(1, userId);
            ps.executeUpdate();
        }
    }

    @Override
    public Optional<Customer> findById(int id) throws SQLException {
        String sql = FIND_CUSTOMER_BY_ID;
        try(var ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            try(var rs = ps.executeQuery()) {
                if(rs.next()) {
                    return Optional.of(parse(rs));
                }
            }
        }
        return Optional.empty();
    }

    @Override
    public Optional<Customer> findByUserId(UUID userId) throws SQLException {
        String sql = FIND_CUSTOMER_BY_USERID;
        try(var ps = connection.prepareStatement(sql)) {
            ps.setObject(1, userId);
            try(var rs = ps.executeQuery()) {
                if(rs.next()) {
                    return Optional.of(parse(rs));
                }
            }
        }
        return Optional.empty();
    }

    @Override
    public List<Customer> findAll() throws SQLException {
        String sql = FIND_ALL_CUSTOMER;
        try(var ps = connection.prepareStatement(sql)) {
            try(var rs = ps.executeQuery()) {
                List<Customer> customers = new ArrayList<>();
                while(rs.next()) {
                    customers.add(parse(rs));
                }
                return customers;
            }
        }
    }

    private Customer parse(ResultSet rs) throws SQLException {
        Customer customer = new Customer();
        customer.setId(rs.getInt("id"));
        customer.setCustomerCode(rs.getString("customer_code"));
        customer.setFullName(rs.getString("full_name"));
        customer.setPhone(rs.getString("phone"));
        customer.setAddress(rs.getString("address"));
        customer.setUser((UUID) rs.getObject("user_id"));
        return customer;
    }
    
}
