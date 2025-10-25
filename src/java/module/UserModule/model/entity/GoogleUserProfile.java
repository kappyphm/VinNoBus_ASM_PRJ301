package module.UserModule.model.entity;

public class GoogleUserProfile {

    private final String userId;
    private final String email;
    private final String name;
    private final String picture;
    private final String givenName;
    private final String familyName;
    private final String locale;

    public GoogleUserProfile(String userId, String email, String name,
            String picture, String givenName, String familyName, String locale) {
        this.userId = userId;
        this.email = email;
        this.name = name;
        this.picture = picture;
        this.givenName = givenName;
        this.familyName = familyName;
        this.locale = locale;
    }

    public String getUserId() {
        return userId;
    }
    
    public String getEmail() {
        return email;
    }

    public String getName() {
        return name;
    }

    public String getPicture() {
        return picture;
    }

    public String getGivenName() {
        return givenName;
    }

    public String getFamilyName() {
        return familyName;
    }

    public String getLocale() {
        return locale;
    }
}
