package dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import model.entity.Role;

/**
 * DAO interface for managing CRUD operations of Role. Also handles User ↔ Role
 * mappings.
 */
public interface IRoleDAO {

    void save(Role role) throws SQLException;

    void update(Role role) throws SQLException;

    /**
     * Deletes a Role by ID. Note: does not cascade to UserRoles; UserDAO should
     * handle that.
     *
     * @param id the Role ID
     * @throws SQLException if a database access error occurs
     */
    void delete(int id) throws SQLException;

    Optional<Role> findById(int id) throws SQLException;

    Optional<Role> findByName(String roleName) throws SQLException;

    List<Role> findAll() throws SQLException;

    /**
     * Updates User ↔ Role mappings. Removes old mappings and inserts new ones.
     *
     * @param userId the UUID of the User
     * @param roles list of new Role objects
     * @throws SQLException if a database access error occurs
     */
    void updateUserRoles(UUID userId, List<Role> roles) throws SQLException;

    /**
     * Retrieves Roles assigned to a User.
     *
     * @param userId the UUID of the User
     * @return list of Roles
     * @throws SQLException if a database access error occurs
     */
    List<Role> findRolesByUserId(UUID userId) throws SQLException;
}
