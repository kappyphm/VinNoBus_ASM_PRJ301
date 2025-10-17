package dal.criteria;

import java.util.ArrayList;
import java.util.List;

/**
 * UserCriteria ---------------- Tiêu chí lọc, phân trang, sắp xếp cho bảng
 * [user]. - Lọc theo firebaseUid, role, isActive - Phân trang và sort được kế
 * thừa từ AbstractCriteria
 */
public class UserCriteria extends AbstractCriteria {

    private String role;
    private Boolean isActive;

    // ----- Build WHERE clause động -----
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

    // ----- Trả về các tham số tương ứng với WHERE -----
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

    // ----- Getters & Setters -----


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
