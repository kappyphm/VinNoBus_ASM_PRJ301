package dal.criteria;

import java.util.ArrayList;
import java.util.List;

/**
 * Criteria tìm kiếm User. Có thể filter theo role, isActive, firebaseUid,...
 */
public class UserCriteria extends AbstractCriteria {

    private String role;
    private Boolean isActive;

    @Override
    public String buildWhereClause() {
        StringBuilder sb = new StringBuilder();
        if (role != null) {
            sb.append(" AND role = ?");
        }
        if (isActive != null) {
            sb.append(" AND is_active = ?");
        }
        return sb.toString();
    }

    @Override
    public Object[] getParams() {
        List<Object> params = new ArrayList<>();
        if (role != null) {
            params.add(role);
        }
        if (isActive != null) {
            params.add(isActive);
        }
        return params.toArray();
    }

    // Getters & Setters
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }

}
