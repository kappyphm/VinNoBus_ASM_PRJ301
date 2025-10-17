package dal.criteria;

import java.util.ArrayList;
import java.util.List;

/**
 * Criteria tìm kiếm Staff. Có thể filter theo department, position,
 * staffCode,...
 */
public class StaffCriteria extends AbstractCriteria {

    private String department;
    private String position;
    private String staffCodeLike;

    @Override
    public String buildWhereClause() {
        StringBuilder sb = new StringBuilder();
        if (department != null) {
            sb.append(" AND department = ?");
        }
        if (position != null) {
            sb.append(" AND position = ?");
        }
        if (staffCodeLike != null) {
            sb.append(" AND staff_code LIKE ?");
        }
        return sb.toString();
    }

    @Override
    public Object[] getParams() {
        List<Object> params = new ArrayList<>();
        if (department != null) {
            params.add(department);
        }
        if (position != null) {
            params.add(position);
        }
        if (staffCodeLike != null) {
            params.add("%" + staffCodeLike + "%");
        }
        return params.toArray();
    }

    // Getters & Setters
    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getStaffCodeLike() {
        return staffCodeLike;
    }

    public void setStaffCodeLike(String staffCodeLike) {
        this.staffCodeLike = staffCodeLike;
    }
}
