package module.core;

import java.lang.reflect.*;
import java.sql.*;
import java.util.*;
import module.core.annotation.Column;
import module.core.annotation.Table;
import module.core.annotation.Unique;

@SuppressWarnings("unchecked")
public class DAOFactory {

    public static <T extends GenericRepository<E, ID>, E, ID> T createProxy(
            T daoInstance, Connection connection, Class<E> entityClass) {

        return (T) Proxy.newProxyInstance(
                daoInstance.getClass().getClassLoader(),
                daoInstance.getClass().getInterfaces(),
                new UniqueMethodHandler<>(daoInstance, connection, entityClass)
        );
    }

    /**
     * InvocationHandler: tự động xử lý các method findBy<Field>.
     */
    private static class UniqueMethodHandler<E, ID> implements InvocationHandler {

        private final GenericRepository<E, ID> target;
        private final Connection connection;
        private final Class<E> entityClass;
        private final Map<String, Field> uniqueFields = new HashMap<>();
        private final String tableName;

        public UniqueMethodHandler(GenericRepository<E, ID> target, Connection conn, Class<E> clazz) {
            this.target = target;
            this.connection = conn;
            this.entityClass = clazz;

            Table t = clazz.getAnnotation(Table.class);
            if (t == null) {
                throw new IllegalStateException("Missing @Table in entity " + clazz);
            }
            this.tableName = t.name();

            for (Field f : clazz.getDeclaredFields()) {
                if (f.isAnnotationPresent(Unique.class) && f.isAnnotationPresent(Column.class)) {
                    uniqueFields.put("findBy" + capitalize(f.getName()), f);
                }
            }
        }

        @Override
        public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
            String name = method.getName();

            // Nếu là findBy<UniqueField>
            if (uniqueFields.containsKey(name)) {
                Field f = uniqueFields.get(name);
                String colName = f.getAnnotation(Column.class).name();
                String sql = "SELECT * FROM " + tableName + " WHERE " + colName + " = ?";
                try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                    stmt.setObject(1, args[0]);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        E obj = map(rs);
                        return Optional.of(obj);
                    }
                    return Optional.empty();
                }
            }

            // Các method còn lại gọi vào DAO gốc
            return method.invoke(target, args);
        }

        private E map(ResultSet rs) throws Exception {
            E obj = entityClass.getDeclaredConstructor().newInstance();
            for (Field f : entityClass.getDeclaredFields()) {
                if (f.isAnnotationPresent(Column.class)) {
                    Column c = f.getAnnotation(Column.class);
                    Object value = rs.getObject(c.name());
                    f.setAccessible(true);
                    f.set(obj, value);
                }
            }
            return obj;
        }

        private String capitalize(String s) {
            return Character.toUpperCase(s.charAt(0)) + s.substring(1);
        }
    }
}
