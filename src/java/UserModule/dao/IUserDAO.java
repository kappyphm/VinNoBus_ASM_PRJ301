package UserModule.dao;



import java.sql.SQLException;
import java.util.List;
import java.util.UUID;
import UserModule.model.entity.User;

/**
 * DAO interface for managing CRUD operations of User.
 * UserDAO is the central DAO, cascading related entities:
 * Staff, Customer, AuthProvider, Roles.
 */
public interface IUserDAO {

    /**
     * Inserts a new User into the database, cascading related entities:
     * Staff, Customer, AuthProvider, Roles.
     * @param user the User object to save
     * @throws SQLException if a database access error occurs
     */
    void save(User user) throws SQLException;

    /**
     * Updates an existing User, cascading related entities:
     * Staff, Customer, AuthProvider, Roles.
     * @param user the User object to update
     * @throws SQLException if a database access error occurs
     */
    void update(User user) throws SQLException;

    /**
     * Deletes a User by UID, cascading deletions of:
     * Staff, Customer, AuthProvider, UserRoles.
     * @param uid the UUID of the User to delete
     * @throws SQLException if a database access error occurs
     */
    void delete(UUID uid) throws SQLException;

    /**
     * Retrieves a User by UID, including Staff, Customer, Roles, and AuthProviders.
     * @param uid the UUID of the User
     * @return the User object, or null if not found
     * @throws SQLException if a database access error occurs
     */
    User findByUid(UUID uid) throws SQLException;

    /**
     * Retrieves a User by unique email.
     * @param email the email of the User
     * @return the User object, or null if not found
     * @throws SQLException if a database access error occurs
     */
    User findByEmail(String email) throws SQLException;

    /**
     * Retrieves all Users.
     * @return a list of all Users
     * @throws SQLException if a database access error occurs
     */
    List<User> findAll() throws SQLException;

    

    /**
     * Searches Users dynamically based on multiple criteria:
     * email, role, active status, created date range, keyword, etc.
     * @param criteria UserSearchCriteria object containing search filters
     * @return a list of Users matching the criteria
     * @throws SQLException if a database access error occurs
     */
    //List<User> findByCriteria(UserSearchCriteria criteria) throws SQLException;
}
