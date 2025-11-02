package module.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import module.core.AbstractDAO;
import module.user.model.entity.Customer;

public class CustomerDAO extends AbstractDAO<Customer, String> {

    public CustomerDAO(Connection connection) {
        super(connection);
    }

    @Override
    protected Customer mapResultSetToEntity(ResultSet rs) throws SQLException {

        Customer customer = new Customer();

        customer.setUserId(rs.getString("user_id"));
        customer.setMembershipLevel(rs.getString("membership_level"));
        customer.setCreatedAt(rs.getTimestamp("created_at"));
        customer.setUpdatedAt(rs.getTimestamp("updated_at"));
        customer.setLoyaltyPoints(rs.getInt("loyalty_points"));

        return customer;

    }

    @Override
    protected String extractGeneratedKey(ResultSet rs) throws SQLException {
        return rs.getString(getPrimaryKeyColumn());
    }

    @Override
    protected String getTableName() {
        return "Customer";
    }

    @Override
    protected String getPrimaryKeyColumn() {

        //return a string name
        return "user_id";

    }

    @Override
    protected PreparedStatement prepareInsertStatement(Customer entity, Connection conn) throws SQLException {
        String sql = "INSERT INTO " + getTableName()
                + " (user_id, membership_level, loyalty_points)"
                + " OUTPUT inserted." + getPrimaryKeyColumn()
                + " VALUES (?,?,?)";
        PreparedStatement stm = conn.prepareStatement(sql);
        stm.setString(1, entity.getUserId());
        stm.setString(2, entity.getMembershipLevel());
        stm.setInt(3, entity.getLoyaltyPoints());

        return stm;

    }

    @Override
    protected PreparedStatement prepareUpdateStatement(Customer entity, Connection conn) throws SQLException {
        String sql = "UPDATE "
                + getTableName()
                + " SET membership_level=?, loyalty_points=? "
                + " WHERE user_id=? "
                + " OUTPUT INSERTED." + getPrimaryKeyColumn();
        PreparedStatement stm = conn.prepareStatement(sql);

        stm.setString(1, entity.getMembershipLevel());
        stm.setInt(2, entity.getLoyaltyPoints());
        stm.setString(3, entity.getUserId());

        return stm;
    }

}
