package util.googleAuth;

import jakarta.json.Json;
import jakarta.json.JsonObject;
import jakarta.json.JsonReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import module.auth.model.dto.GoogleUserDTO;

/**
 * Utility class for authenticating users via Google OAuth 2.0. Loads client
 * credentials from a .properties file and verifies ID tokens.
 */
public final class GoogleAuthUtil {

    private static final Logger LOGGER = Logger.getLogger(GoogleAuthUtil.class.getName());

    private static final String AUTH_ENDPOINT = "https://accounts.google.com/o/oauth2/v2/auth";
    private static final String TOKEN_ENDPOINT = "https://oauth2.googleapis.com/token";
    private static final String TOKEN_INFO_ENDPOINT = "https://oauth2.googleapis.com/tokeninfo";

    // Loaded from google-oauth.properties
    private static String CLIENT_ID;
    private static String CLIENT_SECRET;
    private static String REDIRECT_URI;

    static {
        loadConfig();
    }

    private GoogleAuthUtil() {
    }

    /**
     * Loads client_id, client_secret, and redirect_uri from
     * google-oauth.properties.
     */
    private static void loadConfig() {
        try (InputStream is = GoogleAuthUtil.class.getClassLoader().getResourceAsStream("../GoogleAuth.properties")) {
            if (is == null) {
                throw new IOException("Missing google-oauth.properties in classpath.");
            }

            Properties props = new Properties();
            props.load(is);

            CLIENT_ID = props.getProperty("google.client.id");
            CLIENT_SECRET = props.getProperty("google.client.secret");
            REDIRECT_URI = props.getProperty("google.redirect.uri");

            if (CLIENT_ID == null || CLIENT_SECRET == null || REDIRECT_URI == null) {
                throw new IOException("Missing required properties in google-oauth.properties.");
            }

            LOGGER.info("✅ Google OAuth configuration loaded successfully.");

        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "❌ Failed to load Google OAuth configuration.", e);
        }
    }

    /**
     * Builds the Google authorization URL to redirect the user to the login
     * page.
     */
    public static String buildAuthorizationUrl(String state) {
        return AUTH_ENDPOINT
                + "?client_id=" + URLEncoder.encode(CLIENT_ID, StandardCharsets.UTF_8)
                + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, StandardCharsets.UTF_8)
                + "&response_type=code"
                + "&scope=" + URLEncoder.encode("openid email profile", StandardCharsets.UTF_8)
                + "&state=" + URLEncoder.encode(state, StandardCharsets.UTF_8)
                + "&prompt=select_account";
    }

    /**
     * Exchanges the authorization code for an ID token.
     *
     * @throws GoogleAuthException if the token exchange fails.
     */
    public static String getIdToken(String code) throws GoogleAuthException {
        try {
            String postData = "code=" + URLEncoder.encode(code, StandardCharsets.UTF_8)
                    + "&client_id=" + URLEncoder.encode(CLIENT_ID, StandardCharsets.UTF_8)
                    + "&client_secret=" + URLEncoder.encode(CLIENT_SECRET, StandardCharsets.UTF_8)
                    + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, StandardCharsets.UTF_8)
                    + "&grant_type=authorization_code";

            URL url = new URL(TOKEN_ENDPOINT);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

            try (OutputStream os = conn.getOutputStream()) {
                os.write(postData.getBytes(StandardCharsets.UTF_8));
            }

            int responseCode = conn.getResponseCode();
            if (responseCode != 200) {
                String error = new String(conn.getErrorStream().readAllBytes(), StandardCharsets.UTF_8);
                LOGGER.log(Level.SEVERE, "Google Token API returned error: {0}", error);
                throw new GoogleAuthException("Failed to obtain id_token from Google. HTTP " + responseCode);
            }

            String responseBody = new String(conn.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
            try (JsonReader reader = Json.createReader(new StringReader(responseBody))) {
                JsonObject json = reader.readObject();
                String idToken = json.getString("id_token", null);
                if (idToken == null) {
                    throw new GoogleAuthException("Response does not contain a valid id_token.");
                }
                return idToken;
            }

        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error while requesting id_token from Google", e);
            throw new GoogleAuthException("Unable to connect to Google Token API.", e);
        }
    }

    /**
     * Verifies the given ID token and extracts the user profile.
     *
     * @throws GoogleAuthException if verification fails.
     */
    public static GoogleUserDTO verifyAndExtractUserProfile(String idToken) throws GoogleAuthException {
        if (idToken == null || idToken.isEmpty()) {
            throw new GoogleAuthException("id_token is null or empty.");
        }

        try {
            URL verifyUrl = new URL(TOKEN_INFO_ENDPOINT + "?id_token=" + URLEncoder.encode(idToken, StandardCharsets.UTF_8));

            try (InputStream is = verifyUrl.openStream(); JsonReader reader = Json.createReader(is)) {

                JsonObject info = reader.readObject();

                String aud = info.getString("aud", "");
                String iss = info.getString("iss", "");

                if (!CLIENT_ID.equals(aud)
                        || !(iss.equals("https://accounts.google.com") || iss.equals("accounts.google.com"))) {
                    LOGGER.log(Level.WARNING, "Invalid token: wrong aud or iss. aud={0}, iss={1}", new Object[]{aud, iss});
                    throw new GoogleAuthException("Invalid token: aud/iss mismatch.");
                }

                String sub = info.getString("sub", null);
                String email = info.getString("email", null);
                String name = info.getString("name", "User");
                String picture = info.getString("picture", null);
                String locale = info.getString("locale", null);

                return new GoogleUserDTO(sub, email, name, picture, locale);
            }

        } catch (IOException e) {
            throw new GoogleAuthException("Failed to verify id_token with Google.", e);
        }
    }
}
