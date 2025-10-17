package dao;

import java.sql.SQLException;
import java.util.List;
import java.util.UUID;
import model.entity.Customer;

/**
 * DAO interface for managing CRUD operations of Customer.
 * Customer exists dependent on User.
 */
public interface ICustomerDAO {

    void save(Customer customer) throws SQLException;

    void update(Customer customer) throws SQLException;

    /**
     * Deletes Customer by User ID (used in cascade when User is deleted).
     * @param userId the UUID of the associated User
     * @throws SQLException if a database access error occurs
     */
    void deleteByUserId(UUID userId) throws SQLException;

    Customer findById(int id) throws SQLException;

    Customer findByUserId(UUID userId) throws SQLException;

    List<Customer> findAll() throws SQLException;
}
