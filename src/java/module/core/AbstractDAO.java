package module.core;

import module.core.AbstractCriteria;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * AbstractDAO<T>
 * ----------------- DAO tổng quát cho CRUD + query động với Criteria.Tất cả DAO
 * con (UserDAO, ProductDAO, ...) kế thừa lớp này.
 *
 * @param <T>
 */
public abstract class AbstractDAO<T, ID> {

    protected Connection connection;

    // --- Constructor ---
    public AbstractDAO(Connection connection) {
        this.connection = connection;
    }

    // --- Abstract methods cần triển khai cho từng entity cụ thể ---
    protected abstract T mapResultSetToEntity(ResultSet rs) throws SQLException;

    protected abstract ID extractGeneratedKey(ResultSet rs) throws SQLException;

    protected abstract String getTableName();

    protected abstract String getPrimaryKeyColumn();

    protected abstract PreparedStatement prepareInsertStatement(T entity, Connection conn) throws SQLException;

    protected abstract PreparedStatement prepareUpdateStatement(T entity, Connection conn) throws SQLException;

    // ================================================================
    // ==                     CRUD GENERIC METHODS                   ==
    // ================================================================
    /**
     * Tìm tất cả bản ghi
     *
     * @return
     */
    public List<T> findAll() {
        List<T> list = new ArrayList<>();
        String sql = "SELECT * FROM " + getTableName();
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToEntity(rs));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AbstractDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     * Tìm theo ID
     */
    public Optional<T> findById(ID id) {
        String sql = "SELECT * FROM " + getTableName() + " WHERE " + getPrimaryKeyColumn() + " = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setObject(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return Optional.of(mapResultSetToEntity(rs));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AbstractDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return Optional.empty();
    }

    protected Optional<T> findByColumn(String column, Object value) {
        String sql = "SELECT * FROM " + getTableName() + " WHERE " + column + " = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setObject(1, value);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return Optional.of(mapResultSetToEntity(rs));
            }
        } catch (SQLException e) {
            Logger.getLogger(AbstractDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return Optional.empty();
    }

    /**
     * Thêm mới bản ghi
     */
    public Optional<ID> insert(T entity) {
        try (PreparedStatement stmt = prepareInsertStatement(entity, connection)) {
            ResultSet rs = stmt.executeQuery();
            ID generatedId = extractGeneratedKey(rs);
            return Optional.ofNullable(generatedId);
        } catch (SQLException ex) {
            Logger.getLogger(AbstractDAO.class.getName()).log(Level.SEVERE, null, ex);
            return Optional.empty();
        }
    }

    /**
     * Cập nhật bản ghi
     */
    public Optional<ID> update(T entity) {
        try (PreparedStatement stmt = prepareUpdateStatement(entity, connection)) {
            ResultSet rs = stmt.executeQuery();
            ID updatedId = extractGeneratedKey(rs);
            return Optional.ofNullable(updatedId);
        } catch (SQLException ex) {
            Logger.getLogger(AbstractDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return Optional.empty();
    }

    /**
     * Xóa theo ID
     */
    public Optional<ID> delete(Object id) {
    String sql = "DELETE FROM " + getTableName() + " " +
                 "OUTPUT deleted." + getPrimaryKeyColumn() + " " +
                 "WHERE " + getPrimaryKeyColumn() + " = ?";
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setObject(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            ID deletedId = extractGeneratedKey(rs);
            return Optional.ofNullable(deletedId);
        }
    } catch (SQLException ex) {
        Logger.getLogger(AbstractDAO.class.getName()).log(Level.SEVERE, null, ex);
    }
    return Optional.empty();
}


    // ================================================================
    // ==                     CRITERIA QUERIES                       ==
    // ================================================================
    /**
     * Tìm kiếm động với Criteria (phân trang + sắp xếp + điều kiện WHERE)
     */
    public List<T> findByCriteria(AbstractCriteria criteria) {
        List<T> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM " + getTableName() + " WHERE 1=1 ");
        sql.append(criteria.buildWhereClause());
        sql.append(" ORDER BY ").append(criteria.getSortBy())
                .append(" ").append(criteria.getSortDirection());
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            Object[] params = criteria.getParams();
            int index = 1;
            for (Object p : params) {
                stmt.setObject(index++, p);
            }
            stmt.setInt(index++, criteria.getOffset());
            stmt.setInt(index, criteria.getLimit());

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(mapResultSetToEntity(rs));
            }
        } catch (SQLException ex) {
            Logger.getLogger(AbstractDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     * Đếm tổng số bản ghi theo tiêu chí (cho phân trang)
     */
    public int countByCriteria(AbstractCriteria criteria) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM " + getTableName() + " WHERE 1=1 ");
        sql.append(criteria.buildWhereClause());

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            Object[] params = criteria.getParams();
            int index = 1;
            for (Object p : params) {
                stmt.setObject(index++, p);
            }
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AbstractDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
}
