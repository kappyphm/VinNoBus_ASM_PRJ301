/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.UserModule.criteria;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author kappyphm
 */
public class UserCriteria extends AbstractCriteria {

    private String role;
    private boolean isActive;

    @Override
    public String buildWhereClause() {

        StringBuilder sb = new StringBuilder();
        if (role != null && !role.isEmpty()) {
            sb.append(" AND role = ? ");
        }
        if (isActive) {
            sb.append(" AND is_active = ? ");
        }

        return sb.toString();

    }

    @Override
    public Object[] getParams() {
        List<Object> params = new ArrayList<>();
        if (role != null && !role.isEmpty()) {
            params.add(role);
        }
        if (isActive) {
            params.add(isActive);
        }
        return params.toArray();
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }

}
