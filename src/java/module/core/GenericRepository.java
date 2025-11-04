package module.core;

import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

/**
 * GenericRepository
 * -----------------
 * Interface định nghĩa các phương thức CRUD + query tiêu chuẩn.
 * 
 * Tất cả phương thức ném SQLException để Service layer xử lý.
 *
 * @param <T> Entity type
 * @param <ID> ID type
 */
public interface GenericRepository<T, ID> {

    Optional<ID> insert(T entity) throws SQLException;

    Optional<ID> update(T entity) throws SQLException;

    Optional<ID> delete(ID id) throws SQLException;

    Optional<T> findById(ID id) throws SQLException;

    List<T> findAll() throws SQLException;

    List<T> findByCriteria(AbstractCriteria criteria) throws SQLException;

    int countByCriteria(AbstractCriteria criteria) throws SQLException;

    boolean isExist(ID id) throws SQLException;
}
