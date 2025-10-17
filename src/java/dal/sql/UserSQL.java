package dal.sql;

/**
 * Các câu lệnh SQL cho bảng User.
 */
public class UserSQL {

    public static final String BASE_SELECT = "SELECT * FROM dbo.[user] WHERE 1=1";

    public static final String FIND_BY_ID = "SELECT * FROM dbo.[user] WHERE user_id = ?";
    public static final String FIND_BY_FIREBASE_UID = "SELECT * FROM dbo.[user] WHERE firebase_uid = ?";

    public static final String INSERT = "INSERT INTO dbo.[user] (firebase_uid, role, is_active) VALUES (?, ?, ?)";
    public static final String UPDATE = "UPDATE dbo.[user] SET role = ?, is_active = ?, updated_at = GETDATE() WHERE user_id = ?";
    public static final String DELETE = "DELETE FROM dbo.[user] WHERE user_id = ?";
}
