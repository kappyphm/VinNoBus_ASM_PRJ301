/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.user.model.entity;

import module.core.annotation.Column;
import module.core.annotation.PK;
import module.core.annotation.Table;

/**
 *
 * @author kappyphm
 */
@Table(name = "[user]")
public class User {

    @PK
    @Column( name = "user_id")
    private String userId;

    @Column(name = "is_active")
    private boolean active;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean isActive) {
        this.active = active;
    }

}
