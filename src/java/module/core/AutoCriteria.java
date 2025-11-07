package module.core;

import java.lang.reflect.Field;
import java.util.*;
import java.util.stream.Collectors;
import module.core.annotation.Column;
import module.core.annotation.PK;

/**
 * AutoCriteria<T>
 * ---------------- Tự động sinh tiêu chí truy vấn (WHERE, params) dựa trên
 * Entity và giá trị được set động.
 *
 * - Không cần viết XxxCriteria thủ công. - Chỉ cần gọi: new
 * AutoCriteria<>(User.class).eq("email", "abc@gmail.com") - Hỗ trợ: eq, like,
 * gt, lt, between, in
 */
public class AutoCriteria<T> extends AbstractCriteria {

    private final Class<T> entityClass;
    private final Map<String, Field> columns = new LinkedHashMap<>();

    // Điều kiện WHERE động
    private final List<String> conditions = new ArrayList<>();
    private final List<Object> params = new ArrayList<>();

    public AutoCriteria(Class<T> entityClass) {
        this.entityClass = entityClass;
        scanColumns();
    }

    private void scanColumns() {
        for (Field f : entityClass.getDeclaredFields()) {
            if (f.isAnnotationPresent(Column.class)) {
                columns.put(f.getName(), f);
            }
            
            if (f.isAnnotationPresent(PK.class)) {
                this.sortBy = f.getAnnotation(Column.class).name();
            }
        }
    }

    // ========================= API Builder =========================
    public AutoCriteria<T> eq(String field, Object value) {
        if (value != null && columns.containsKey(field)) {
            String col = columns.get(field).getAnnotation(Column.class).name();
            conditions.add("AND " + col + " = ?");
            params.add(value);
        }
        return this;
    }

    public AutoCriteria<T> like(String field, String pattern) {
        if (pattern != null && columns.containsKey(field)) {
            String col = columns.get(field).getAnnotation(Column.class).name();
            conditions.add("AND " + col + " LIKE ?");
            params.add("%" + pattern + "%");
        }
        return this;
    }

    public AutoCriteria<T> gt(String field, Object value) {
        if (value != null && columns.containsKey(field)) {
            String col = columns.get(field).getAnnotation(Column.class).name();
            conditions.add("AND " + col + " > ?");
            params.add(value);
        }
        return this;
    }

    public AutoCriteria<T> lt(String field, Object value) {
        if (value != null && columns.containsKey(field)) {
            String col = columns.get(field).getAnnotation(Column.class).name();
            conditions.add("AND " + col + " < ?");
            params.add(value);
        }
        return this;
    }

    public AutoCriteria<T> between(String field, Object from, Object to) {
        if (from != null && to != null && columns.containsKey(field)) {
            String col = columns.get(field).getAnnotation(Column.class).name();
            conditions.add("AND " + col + " BETWEEN ? AND ?");
            params.add(from);
            params.add(to);
        }
        return this;
    }

    public AutoCriteria<T> in(String field, Collection<?> values) {
        if (values != null && !values.isEmpty() && columns.containsKey(field)) {
            String col = columns.get(field).getAnnotation(Column.class).name();
            String placeholders = values.stream().map(v -> "?").collect(Collectors.joining(","));
            conditions.add("AND " + col + " IN (" + placeholders + ")");
            params.addAll(values);
        }
        return this;
    }

    // ========================= Build =========================
    @Override
    public String buildWhereClause() {
        return String.join(" ", conditions);
    }

    @Override
    public Object[] getParams() {
        return params.toArray();
    }
}
