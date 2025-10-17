package dal.criteria;

import java.util.ArrayList;
import java.util.List;

/**
 * CustomerCriteria ---------------- Tiêu chí lọc, phân trang, sắp xếp cho bảng
 * customer. - Lọc theo membershipLevel, loyaltyPoints (min/max) - Phân trang và
 * sort được kế thừa từ AbstractCriteria
 */
public class CustomerCriteria extends AbstractCriteria {

    private String membershipLevel;
    private Integer minLoyaltyPoints;
    private Integer maxLoyaltyPoints;

    // ----- Build WHERE clause động -----
    @Override
    public String buildWhereClause() {
        StringBuilder sb = new StringBuilder();
        if (membershipLevel != null) {
            sb.append(" AND membership_level = ?");
        }
        if (minLoyaltyPoints != null) {
            sb.append(" AND loyalty_points >= ?");
        }
        if (maxLoyaltyPoints != null) {
            sb.append(" AND loyalty_points <= ?");
        }
        return sb.toString();
    }

    // ----- Trả về các tham số tương ứng với WHERE -----
    @Override
    public Object[] getParams() {
        List<Object> params = new ArrayList<>();
        if (membershipLevel != null) {
            params.add(membershipLevel);
        }
        if (minLoyaltyPoints != null) {
            params.add(minLoyaltyPoints);
        }
        if (maxLoyaltyPoints != null) {
            params.add(maxLoyaltyPoints);
        }
        return params.toArray();
    }

    // ----- Getters & Setters -----
    public String getMembershipLevel() {
        return membershipLevel;
    }

    public void setMembershipLevel(String membershipLevel) {
        this.membershipLevel = membershipLevel;
    }

    public Integer getMinLoyaltyPoints() {
        return minLoyaltyPoints;
    }

    public void setMinLoyaltyPoints(Integer minLoyaltyPoints) {
        this.minLoyaltyPoints = minLoyaltyPoints;
    }

    public Integer getMaxLoyaltyPoints() {
        return maxLoyaltyPoints;
    }

    public void setMaxLoyaltyPoints(Integer maxLoyaltyPoints) {
        this.maxLoyaltyPoints = maxLoyaltyPoints;
    }
}
