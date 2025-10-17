package dal.sql;

/**
 * Các câu lệnh SQL cho bảng Profile.
 */
public class ProfileSQL {

    public static final String BASE_SELECT = "SELECT * FROM dbo.profile WHERE 1=1";

    public static final String FIND_BY_ID = "SELECT * FROM dbo.profile WHERE profile_id = ?";
    public static final String FIND_BY_USER_ID = "SELECT * FROM dbo.profile WHERE user_id = ?";

    public static final String INSERT = "INSERT INTO dbo.profile (user_id, full_name, birth_date, phone, email, address, avatar_url) VALUES (?, ?, ?, ?, ?, ?, ?)";
    public static final String UPDATE = "UPDATE dbo.profile SET full_name = ?, birth_date = ?, phone = ?, email = ?, address = ?, avatar_url = ?, updated_at = GETDATE() WHERE profile_id = ?";
    public static final String DELETE = "DELETE FROM dbo.profile WHERE profile_id = ?";
}
