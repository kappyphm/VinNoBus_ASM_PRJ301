package dal.sql;

/**
 * Các câu lệnh SQL cho bảng Customer.
 */
public class CustomerSQL {

    public static final String BASE_SELECT = "SELECT * FROM dbo.customer WHERE 1=1";

    public static final String FIND_BY_ID = "SELECT * FROM dbo.customer WHERE customer_id = ?";
    public static final String FIND_BY_USER_ID = "SELECT * FROM dbo.customer WHERE user_id = ?";

    public static final String INSERT = "INSERT INTO dbo.customer (user_id, membership_level, loyalty_points) VALUES (?, ?, ?)";
    public static final String UPDATE = "UPDATE dbo.customer SET membership_level = ?, loyalty_points = ?, updated_at = GETDATE() WHERE customer_id = ?";
    public static final String DELETE = "DELETE FROM dbo.customer WHERE customer_id = ?";
}
