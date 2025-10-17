package dal.criteria;

import java.util.ArrayList;
import java.util.List;

/**
 * Criteria tìm kiếm Profile. Có thể filter theo email, phone, fullName,...
 */
public class ProfileCriteria extends AbstractCriteria {

    private String emailLike;
    private String phoneLike;
    private String fullNameLike;

    @Override
    public String buildWhereClause() {
        StringBuilder sb = new StringBuilder();
        if (emailLike != null) {
            sb.append(" AND email LIKE ?");
        }
        if (phoneLike != null) {
            sb.append(" AND phone LIKE ?");
        }
        if (fullNameLike != null) {
            sb.append(" AND full_name LIKE ?");
        }
        return sb.toString();
    }

    @Override
    public Object[] getParams() {
        List<Object> params = new ArrayList<>();
        if (emailLike != null) {
            params.add("%" + emailLike + "%");
        }
        if (phoneLike != null) {
            params.add("%" + phoneLike + "%");
        }
        if (fullNameLike != null) {
            params.add("%" + fullNameLike + "%");
        }
        return params.toArray();
    }

    // Getters & Setters
    public String getEmailLike() {
        return emailLike;
    }

    public void setEmailLike(String emailLike) {
        this.emailLike = emailLike;
    }

    public String getPhoneLike() {
        return phoneLike;
    }

    public void setPhoneLike(String phoneLike) {
        this.phoneLike = phoneLike;
    }

    public String getFullNameLike() {
        return fullNameLike;
    }

    public void setFullNameLike(String fullNameLike) {
        this.fullNameLike = fullNameLike;
    }
}
