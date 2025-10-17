/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package constant;

/**
 *
 * @author kappyphm
 */
public class Query {

    //User
    public static final String SAVE_USER = "";

    //Staff
    public static final String ADD_STAFF = "INSERT INTO Staff (user_id, staff_code, full_name, phone, department, position) VALUES (?,?,?,?,?,?)";
    public static final String UPDATE_STAFF = """
                                              UPDATE Staff SET
                                                staff_code = ?, 
                                                full_name = ?, 
                                                phone = ?, 
                                                department = ?, 
                                                position = ?
                                              WHERE
                                                user_id = ?
                                              """;
    public static final String DELETE_STAFF_BY_USERID = "DELETE FROM Staff WHERE user_id = ?";
    public static final String FIND_STAFF_BY_ID = "SELECT * FROM Staff WHERE user_id = ?";
    public static final String FIND_STAFF_BY_USERID = "SELECT * FROM Staff WHERE user_id = ?";
    public static final String FIND_ALL_STAFF = "SELECT * FROM Staff";
    
    //Role
    public static final String ADD_ROLE = "INSERT INTO Roles(role_name) VALUES (?)";
    public static final String UPDATE_ROLE = "UPDATE Roles SET role_name=? WHERE role_id=?";
    public static final String DELETE_ROLE = "DELETE FROM Roles WHERE role_id=?";
    public static final String FIND_ROLE_BY_ID = "SELECT * FROM Roles WHERE role_id=?";
    public static final String FIND_ROLE_BY_NAME = "SELECT * FROM Roles WHERE role_name=?";
    public static final String FIND_ALL_ROLE = "SELECT * FROM Roles";
    public static final String ADD_USER_ROLE = "INSERT INTO UserRoles (user_id,role_id) VALUES(?,?)";
    public static final String DELETE_USER_ROLE = "DELETE FROM UserRoles WHERE user_id=?";
    public static final String FIND_ROLES_BY_USER_ID = """
                                                       SELECT
                                                       FROM Roles r
                                                       JOIN UserRoles ur ON ur.role_id = r.role_id
                                                       WHERE ur.user_id = ?
                                                       """;
}
