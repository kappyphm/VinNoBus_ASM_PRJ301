package module.core;

import java.util.*;

/**
 * GenericRepository
 * -----------------
 * Interface định nghĩa các phương thức CRUD + query tiêu chuẩn.
 */
public interface GenericRepository<T, ID> {

    Optional<ID> insert(T entity);
    Optional<ID> update(T entity);
    Optional<ID> delete(ID id);

    Optional<T> findById(ID id);
    List<T> findAll();

    List<T> findByCriteria(AbstractCriteria criteria);
    int countByCriteria(AbstractCriteria criteria);

    boolean isExist(ID id);
}
