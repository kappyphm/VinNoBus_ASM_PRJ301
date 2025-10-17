package dal.dao;

import dal.criteria.CustomerCriteria;
import dal.sql.CustomerSQL;
import model.entity.Customer;

import java.sql.*;
import java.util.*;

/**
 * DAO quản lý Customer. Sử dụng AbstractDAO, logging & DataAccessException
 * chuẩn.
 */
public class CustomerDAO extends AbstractDAO<Customer> {

    @Override
    protected Optional<Customer> parse(ResultSet rs) throws SQLException {
        Customer c = new Customer();
        c.setCustomerId(rs.getInt("customer_id"));
        c.setUserId(rs.getInt("user_id"));
        c.setMembershipLevel(rs.getString("membership_level"));
        c.setLoyaltyPoints(rs.getInt("loyalty_points"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        c.setUpdatedAt(rs.getTimestamp("updated_at"));
        return Optional.of(c);
    }

    // -------------------------
    // CRUD cơ bản
    // -------------------------
    public Optional<Customer> findById(int id) {
        return findOne(CustomerSQL.FIND_BY_ID, id);
    }

    public Optional<Customer> findByUserId(int userId) {
        return findOne(CustomerSQL.FIND_BY_USER_ID, userId);
    }

    public boolean insert(Customer c) {
        return execute(CustomerSQL.INSERT, c.getUserId(), c.getMembershipLevel(), c.getLoyaltyPoints());
    }

    public boolean update(Customer c) {
        return execute(CustomerSQL.UPDATE, c.getMembershipLevel(), c.getLoyaltyPoints(), c.getCustomerId());
    }

    public boolean delete(int customerId) {
        return execute(CustomerSQL.DELETE, customerId);
    }

    // -------------------------
    // Query có filter + sort + paging
    // -------------------------
    public List<Customer> findAll(CustomerCriteria criteria) {
        return findAllByCriteria(CustomerSQL.BASE_SELECT, criteria);
    }
}
