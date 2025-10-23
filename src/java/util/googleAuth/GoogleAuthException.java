package util.googleAuth;

/**
 * Ngoại lệ mô tả lỗi xảy ra trong quá trình xác thực Google OAuth.
 */
public class GoogleAuthException extends Exception {

    public GoogleAuthException(String message) {
        super(message);
    }

    public GoogleAuthException(String message, Throwable cause) {
        super(message, cause);
    }
}
