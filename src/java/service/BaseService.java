package service;

import dal.DBContext;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * BaseService ----------------- Lớp cha cho tất cả Service trong hệ thống. -
 * Cung cấp Connection dùng chung cho nhiều DAO. - Quản lý transaction: begin,
 * commit, rollback. - Đảm bảo atomic transaction cho nhiều thao tác DB.
 */
public abstract class BaseService extends DBContext {

    /**
     * Lấy connection hiện tại (từ DBContext)
     */
    public Connection getConnection() {
        return connection;
    }

    /**
     * Bắt đầu transaction (tắt autoCommit)
     */
    public void beginTransaction() throws SQLException {
        if (connection == null || connection.isClosed()) {
            throw new SQLException("Connection is not available to begin transaction!");
        }
        connection.setAutoCommit(false);
    }

    /**
     * Commit transaction (xác nhận tất cả thay đổi)
     */
    public void commitTransaction() throws SQLException {
        if (connection != null) {
            connection.commit();
            connection.setAutoCommit(true);
        }
    }

    /**
     * Rollback transaction (hoàn tác tất cả thao tác)
     */
    public void rollbackTransaction() {
        try {
            if (connection != null && !connection.getAutoCommit()) {
                connection.rollback();
                connection.setAutoCommit(true);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BaseService.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
