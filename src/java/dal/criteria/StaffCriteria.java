package dal.criteria;

import java.util.ArrayList;
import java.util.List;

/**
 * StaffCriteria
 * ----------------
 * Tiêu chí lọc, phân trang, sắp xếp cho bảng staff.
 * - Lọc theo staffCode, position, department
 * - Phân trang và sort được kế thừa từ AbstractCriteria
 */
public class StaffCriteria extends AbstractCriteria {

    private String staffCodeLike;
    private String positionLike;
    private String departmentLike;

    // ----- Build WHERE clause động -----
    @Override
    public String buildWhereClause() {
        StringBuilder sb = new StringBuilder();
        if (staffCodeLike != null) sb.append(" AND staff_code LIKE ?");
        if (positionLike != null) sb.append(" AND position LIKE ?");
        if (departmentLike != null) sb.append(" AND department LIKE ?");
        return sb.toString();
    }

    // ----- Trả về các tham số tương ứng với WHERE -----
    @Override
    public Object[] getParams() {
        List<Object> params = new ArrayList<>();
        if (staffCodeLike != null) params.add("%" + staffCodeLike + "%");
        if (positionLike != null) params.add("%" + positionLike + "%");
        if (departmentLike != null) params.add("%" + departmentLike + "%");
        return params.toArray();
    }

    // ----- Getters & Setters -----
    public String getStaffCodeLike() { return staffCodeLike; }
    public void setStaffCodeLike(String staffCodeLike) { this.staffCodeLike = staffCodeLike; }

    public String getPositionLike() { return positionLike; }
    public void setPositionLike(String positionLike) { this.positionLike = positionLike; }

    public String getDepartmentLike() { return departmentLike; }
    public void setDepartmentLike(String departmentLike) { this.departmentLike = departmentLike; }
}
