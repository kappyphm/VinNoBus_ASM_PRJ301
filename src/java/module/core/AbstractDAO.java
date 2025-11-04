package module.core;

import java.lang.reflect.*;
import java.sql.*;
import java.util.*;
import java.util.logging.*;
import module.core.annotation.*;

/**
 * AbstractDAO<T, ID>
 * -------------------
 * DAO tổng quát: cung cấp CRUD + findByCriteria + tự động generate findBy<Field> cho @Unique.
 * @param <T> Entity type
 * @param <ID> ID type (String, UUID, Integer)
 */
public abstract class AbstractDAO<T, ID> implements GenericRepository<T, ID> {

    protected Connection connection;
    protected Class<T> entityClass;
    protected String tableName;

    protected Map<String, Field> columns = new HashMap<>();
    protected Field idField;
    protected Map<String, Field> uniqueFields = new HashMap<>();

    public AbstractDAO(Connection connection, Class<T> entityClass) {
        this.connection = connection;
        this.entityClass = entityClass;
        initMetadata();
    }

    private void initMetadata() {
        Table table = entityClass.getAnnotation(Table.class);
        if (table == null)
            throw new RuntimeException("Entity missing @Table annotation: " + entityClass);
        tableName = table.name();

        for (Field f : entityClass.getDeclaredFields()) {
            f.setAccessible(true);
            Column c = f.getAnnotation(Column.class);
            if (c != null) {
                columns.put(c.name(), f);
                if (c.id()) idField = f;
            }
            if (f.isAnnotationPresent(Unique.class)) {
                uniqueFields.put("findBy" + capitalize(f.getName()), f);
            }
        }
        if (idField == null)
            throw new RuntimeException("Missing @Column(id=true) in entity " + entityClass);
    }

    // ========================= CRUD =========================

    @Override
    public Optional<ID> insert(T entity) {
        try {
            StringBuilder cols = new StringBuilder();
            StringBuilder vals = new StringBuilder();
            List<Object> params = new ArrayList<>();

            for (Map.Entry<String, Field> e : columns.entrySet()) {
                Field f = e.getValue();
                Column c = f.getAnnotation(Column.class);
                if (!c.id()) {
                    cols.append(c.name()).append(",");
                    vals.append("?").append(",");
                    params.add(f.get(entity));
                }
            }

            cols.setLength(cols.length() - 1);
            vals.setLength(vals.length() - 1);

            String sql = "INSERT INTO " + tableName + " (" + cols + ") OUTPUT inserted." +
                         idField.getAnnotation(Column.class).name() + " VALUES (" + vals + ")";

            PreparedStatement stmt = connection.prepareStatement(sql);
            for (int i = 0; i < params.size(); i++) stmt.setObject(i + 1, params.get(i));

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return Optional.ofNullable((ID) rs.getObject(1));
        } catch (Exception e) {
            Logger.getLogger(AbstractDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return Optional.empty();
    }

    @Override
    public Optional<ID> update(T entity) {
        try {
            StringBuilder set = new StringBuilder();
            List<Object> params = new ArrayList<>();

            for (Map.Entry<String, Field> e : columns.entrySet()) {
                Column c = e.getValue().getAnnotation(Column.class);
                if (!c.id()) {
                    set.append(c.name()).append(" = ?,");
                    params.add(e.getValue().get(entity));
                }
            }
            set.setLength(set.length() - 1);

            String idCol = idField.getAnnotation(Column.class).name();
            Object idVal = idField.get(entity);

            String sql = "UPDATE " + tableName + " SET " + set + " OUTPUT inserted." + idCol +
                         " WHERE " + idCol + " = ?";

            PreparedStatement stmt = connection.prepareStatement(sql);
            int idx = 1;
            for (Object p : params) stmt.setObject(idx++, p);
            stmt.setObject(idx, idVal);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return Optional.ofNullable((ID) rs.getObject(1));
        } catch (Exception e) {
            Logger.getLogger(AbstractDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return Optional.empty();
    }

    @Override
    public Optional<ID> delete(ID id) {
        try {
            String idCol = idField.getAnnotation(Column.class).name();
            String sql = "DELETE FROM " + tableName + " OUTPUT deleted." + idCol +
                         " WHERE " + idCol + " = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setObject(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return Optional.ofNullable((ID) rs.getObject(1));
        } catch (SQLException e) {
            Logger.getLogger(AbstractDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return Optional.empty();
    }

    @Override
    public Optional<T> findById(ID id) {
        try {
            String sql = "SELECT * FROM " + tableName + " WHERE " +
                         idField.getAnnotation(Column.class).name() + " = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setObject(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return Optional.of(map(rs));
        } catch (Exception e) {
            Logger.getLogger(AbstractDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return Optional.empty();
    }

    @Override
    public List<T> findAll() {
        List<T> list = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement("SELECT * FROM " + tableName);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) {
            Logger.getLogger(AbstractDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }

    @Override
    public boolean isExist(ID id) {
        try {
            String sql = "SELECT COUNT(*) FROM " + tableName + " WHERE " +
                         idField.getAnnotation(Column.class).name() + " = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setObject(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (SQLException e) {
            Logger.getLogger(AbstractDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    // ========================= Criteria =========================

    @Override
    public List<T> findByCriteria(AbstractCriteria c) {
        List<T> list = new ArrayList<>();
        String sql = "SELECT * FROM " + tableName + " WHERE 1=1 " + c.buildWhereClause() +
                     " ORDER BY " + c.getSortBy() + " " + c.getSortDirection() +
                     " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            Object[] params = c.getParams();
            int idx = 1;
            for (Object p : params) stmt.setObject(idx++, p);
            stmt.setInt(idx++, c.getOffset());
            stmt.setInt(idx, c.getLimit());
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) list.add(map(rs));
        } catch (Exception e) {
            Logger.getLogger(AbstractDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return list;
    }

    @Override
    public int countByCriteria(AbstractCriteria c) {
        String sql = "SELECT COUNT(*) FROM " + tableName + " WHERE 1=1 " + c.buildWhereClause();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            Object[] params = c.getParams();
            int idx = 1;
            for (Object p : params) stmt.setObject(idx++, p);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            Logger.getLogger(AbstractDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return 0;
    }

    // ========================= Helpers =========================

    protected T map(ResultSet rs) throws Exception {
        T obj = entityClass.getDeclaredConstructor().newInstance();
        for (Map.Entry<String, Field> e : columns.entrySet()) {
            Field f = e.getValue();
            f.setAccessible(true);
            f.set(obj, rs.getObject(e.getKey()));
        }
        return obj;
    }

    protected String capitalize(String str) {
        return Character.toUpperCase(str.charAt(0)) + str.substring(1);
    }
}
