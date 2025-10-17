package dal.criteria;

import java.util.ArrayList;
import java.util.List;

/**
 * ProfileCriteria ---------------- Tiêu chí lọc, phân trang, sắp xếp cho bảng
 * profile. - Lọc theo fullName, phone, email - Phân trang và sort được kế thừa
 * từ AbstractCriteria
 */
public class ProfileCriteria extends AbstractCriteria {

    private String fullNameLike;
    private String phoneLike;
    private String emailLike;

    // ----- Build WHERE clause động -----
    @Override
    public String buildWhereClause() {
        StringBuilder sb = new StringBuilder();
        if (fullNameLike != null) {
            sb.append(" AND full_name LIKE ?");
        }
        if (phoneLike != null) {
            sb.append(" AND phone LIKE ?");
        }
        if (emailLike != null) {
            sb.append(" AND email LIKE ?");
        }
        return sb.toString();
    }

    // ----- Trả về các tham số tương ứng với WHERE -----
    @Override
    public Object[] getParams() {
        List<Object> params = new ArrayList<>();
        if (fullNameLike != null) {
            params.add("%" + fullNameLike + "%");
        }
        if (phoneLike != null) {
            params.add("%" + phoneLike + "%");
        }
        if (emailLike != null) {
            params.add("%" + emailLike + "%");
        }
        return params.toArray();
    }

    // ----- Getters & Setters -----
    public String getFullNameLike() {
        return fullNameLike;
    }

    public void setFullNameLike(String fullNameLike) {
        this.fullNameLike = fullNameLike;
    }

    public String getPhoneLike() {
        return phoneLike;
    }

    public void setPhoneLike(String phoneLike) {
        this.phoneLike = phoneLike;
    }

    public String getEmailLike() {
        return emailLike;
    }

    public void setEmailLike(String emailLike) {
        this.emailLike = emailLike;
    }
}
