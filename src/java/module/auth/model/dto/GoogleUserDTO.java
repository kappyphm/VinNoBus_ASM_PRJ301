/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package module.auth.model.dto;

/**
 *
 * @author kappyphm
 */
public class GoogleUserDTO {

    private String sub;
    private String email;
    private String name;
    private String picture;
    private String local;

    public GoogleUserDTO(String sub, String email, String name, String picture, String local) {
        this.sub = sub;
        this.email = email;
        this.name = name;
        this.picture = picture;
        this.local = local;
    }

    public GoogleUserDTO() {
    }

    public String getSub() {
        return sub;
    }

    public void setSub(String sub) {
        this.sub = sub;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getLocal() {
        return local;
    }

    public void setLocal(String local) {
        this.local = local;
    }

}
