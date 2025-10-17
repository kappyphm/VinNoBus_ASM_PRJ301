/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.List;
import java.util.UUID;
import model.entity.Staff;

/**
 *
 * @author kappyphm
 */
public interface IStaffDAO {

    /**
     * Inserts a new Staff. Typically called from UserDAO when saving a User.
     *
     * @param staff the Staff object to save
     * @throws SQLException if a database access error occurs
     */
    void save(Staff staff) throws SQLException;

    /**
     * Updates Staff information.
     *
     * @param staff the Staff object to update
     * @throws SQLException if a database access error occurs
     */
    void update(Staff staff) throws SQLException;

    /**
     * Deletes Staff by User ID (used in cascade when User is deleted).
     *
     * @param userId the UUID of the associated User
     * @throws SQLException if a database access error occurs
     */
    void deleteByUserId(UUID userId) throws SQLException;

    /**
     * Retrieves Staff by staff ID.
     *
     * @param id the Staff ID
     * @return the Staff object, or null if not found
     * @throws SQLException if a database access error occurs
     */
    Staff findById(int id) throws SQLException;

    /**
     * Retrieves Staff by User ID.
     *
     * @param userId the UUID of the associated User
     * @return the Staff object, or null if not found
     * @throws SQLException if a database access error occurs
     */
    Staff findByUserId(UUID userId) throws SQLException;

    /**
     * Retrieves all Staff records.
     *
     * @return a list of all Staff
     * @throws SQLException if a database access error occurs
     */
    List<Staff> findAll() throws SQLException;
}
