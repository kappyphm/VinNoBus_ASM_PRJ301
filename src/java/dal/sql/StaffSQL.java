package dal.sql;

/**
 * Các câu lệnh SQL cho bảng Staff.
 */
public class StaffSQL {

    public static final String BASE_SELECT = "SELECT * FROM dbo.staff WHERE 1=1";

    public static final String FIND_BY_ID = "SELECT * FROM dbo.staff WHERE staff_id = ?";
    public static final String FIND_BY_USER_ID = "SELECT * FROM dbo.staff WHERE user_id = ?";

    public static final String INSERT = "INSERT INTO dbo.staff (user_id, staff_code, position, department) VALUES (?, ?, ?, ?)";
    public static final String UPDATE = "UPDATE dbo.staff SET staff_code = ?, position = ?, department = ?, updated_at = GETDATE() WHERE staff_id = ?";
    public static final String DELETE = "DELETE FROM dbo.staff WHERE staff_id = ?";
}
