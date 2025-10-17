package dal.dao;

import dal.DBContext;
import dal.criteria.AbstractCriteria;
import dal.exception.DataAccessException;
import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * AbstractDAO<T>
 * --------------
 * Lớp cơ sở cung cấp:
 * - CRUD cơ bản (findOne, findAll, execute)
 * - Query động với filter, sort, pagination
 * - Logging & Exception chuẩn (DataAccessException)
 *
 * @param <T> Entity model tương ứng
 */
public abstract class AbstractDAO<T> extends DBContext {

    protected final Logger logger = Logger.getLogger(getClass().getName());

    /**
     * Parse ResultSet -> Entity T.
     * @param rs ResultSet
     * @return Optional<T> (tránh null)
     * @throws SQLException nếu lỗi mapping dữ liệu
     */
    protected abstract Optional<T> parse(ResultSet rs) throws SQLException;

    // -------------------------------
    //        COMMON OPERATIONS
    // -------------------------------

    protected Optional<T> findOne(String sql, Object... params) {
        try (PreparedStatement stm = prepare(sql, params);
             ResultSet rs = stm.executeQuery()) {
            if (rs.next()) return parse(rs);
            return Optional.empty();
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error executing findOne: " + sql, e);
            throw new DataAccessException("Database error while executing findOne", e);
        }
    }

    protected List<T> findAll(String sql, Object... params) {
        List<T> result = new ArrayList<>();
        try (PreparedStatement stm = prepare(sql, params);
             ResultSet rs = stm.executeQuery()) {
            while (rs.next()) parse(rs).ifPresent(result::add);
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error executing findAll: " + sql, e);
            throw new DataAccessException("Database error while executing findAll", e);
        }
        return result;
    }

    protected boolean execute(String sql, Object... params) {
        try (PreparedStatement stm = prepare(sql, params)) {
            int rows = stm.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error executing SQL update: " + sql, e);
            throw new DataAccessException("Database error while executing update", e);
        }
    }

    // -------------------------------
    //       CRITERIA QUERY
    // -------------------------------

    public List<T> findAllByCriteria(String baseQuery, AbstractCriteria criteria) {
        StringBuilder sql = new StringBuilder(baseQuery);

        // WHERE
        sql.append(" ").append(criteria.buildWhereClause());

        // ORDER BY
        sql.append(" ORDER BY ")
           .append(criteria.getSortBy()).append(" ")
           .append(criteria.getSortDirection());

        // Pagination (SQL Server style)
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        // Params
        List<Object> params = new ArrayList<>(Arrays.asList(criteria.getParams()));
        params.add(criteria.getOffset());
        params.add(criteria.getLimit());

        try {
            return findAll(sql.toString(), params.toArray());
        } catch (DataAccessException e) {
            logger.log(Level.WARNING, "Error while executing criteria query", e);
            throw e; // rethrow để service xử lý
        }
    }

    // -------------------------------
    //         UTILITIES
    // -------------------------------

    /**
     * Tạo PreparedStatement và gán tham số an toàn.
     */
    private PreparedStatement prepare(String sql, Object... params) throws SQLException {
        PreparedStatement stm = connection.prepareStatement(sql);
        for (int i = 0; i < params.length; i++) {
            stm.setObject(i + 1, params[i]);
        }
        return stm;
    }
}
