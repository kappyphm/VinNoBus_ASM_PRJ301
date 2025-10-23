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
import java.util.logging.Level;
import java.util.logging.Logger;
import model.entity.GoogleUserProfile;

/**
 * Tiện ích xác thực người dùng bằng Google OAuth 2.0. Hỗ trợ luồng
 * Authorization Code để lấy id_token và trích xuất thông tin user.
 */
public final class GoogleAuthUtil {

    // --- CẤU HÌNH ---
    private static final String CLIENT_ID = "108530769869-h4fkmloblr6vgfgvn8j4eol1kbsm9h4s.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    private static final String REDIRECT_URI = "http://localhost:9999/FirebaseAuth/oauth2callback";

    private static final String AUTH_ENDPOINT = "https://accounts.google.com/o/oauth2/v2/auth";
    private static final String TOKEN_ENDPOINT = "https://oauth2.googleapis.com/token";
    private static final String TOKEN_INFO_ENDPOINT = "https://oauth2.googleapis.com/tokeninfo";

    // Logger chuẩn
    private static final Logger LOGGER = Logger.getLogger(GoogleAuthUtil.class.getName());

    // Ngăn tạo instance
    private GoogleAuthUtil() {
    }

    /**
     * Xây dựng URL đăng nhập Google.
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
     * Gửi authorization code lên Google để lấy id_token.
     *
     * @throws GoogleAuthException nếu không thể lấy token
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
                LOGGER.log(Level.SEVERE, "Google token API trả về lỗi: {0}", error);
                throw new GoogleAuthException("Không thể lấy id_token từ Google. Mã lỗi: " + responseCode);
            }

            String responseBody = new String(conn.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
            try (JsonReader reader = Json.createReader(new StringReader(responseBody))) {
                JsonObject json = reader.readObject();
                String idToken = json.getString("id_token", null);
                if (idToken == null) {
                    throw new GoogleAuthException("Phản hồi không chứa id_token hợp lệ.");
                }
                return idToken;
            }

        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi gửi yêu cầu lấy id_token", e);
            throw new GoogleAuthException("Không thể kết nối đến Google để lấy id_token.", e);
        }
    }

    /**
     * Xác minh id_token và lấy thông tin người dùng.
     *
     * @throws GoogleAuthException nếu token không hợp lệ
     */
    public static GoogleUserProfile verifyAndExtractUserProfile(String idToken) throws GoogleAuthException {
        if (idToken == null || idToken.isEmpty()) {
            throw new GoogleAuthException("id_token rỗng hoặc không hợp lệ.");
        }

        try {
            URL verifyUrl = new URL(TOKEN_INFO_ENDPOINT + "?id_token=" + URLEncoder.encode(idToken, StandardCharsets.UTF_8));

            try (InputStream is = verifyUrl.openStream(); JsonReader reader = Json.createReader(is)) {

                JsonObject info = reader.readObject();

                String aud = info.getString("aud", "");
                String iss = info.getString("iss", "");

                // Xác minh token
                if (!CLIENT_ID.equals(aud)
                        || !(iss.equals("https://accounts.google.com") || iss.equals("accounts.google.com"))) {
                    LOGGER.log(Level.WARNING, "Token không hợp lệ: sai aud hoặc iss. aud={0}, iss={1}", new Object[]{aud, iss});
                    throw new GoogleAuthException("Token không hợp lệ: aud/iss sai.");
                }

                // Trích xuất thông tin user
                String sub = info.getString("sub", null);
                String email = info.getString("email", null);
                String name = info.getString("name", "User");
                String picture = info.getString("picture", null);
                String givenName = info.getString("given_name", null);
                String familyName = info.getString("family_name", null);
                String locale = info.getString("locale", null);

                return new GoogleUserProfile(sub, email, name, picture, givenName, familyName, locale);
            }

        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Lỗi khi xác minh id_token", e);
            throw new GoogleAuthException("Không thể xác minh id_token với Google.", e);
        }
    }
}
