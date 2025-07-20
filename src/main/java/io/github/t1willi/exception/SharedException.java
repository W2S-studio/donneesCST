package io.github.t1willi.exception;

public class SharedException extends Exception {
    public SharedException(String message) {
        super(message);
    }

    public static class UserSessionExpiredException extends SharedException {
        public UserSessionExpiredException() {
            super("User session has expired");
        }
    }

    public static class MissingTokenException extends SharedException {
        public MissingTokenException() {
            super("Token is missing");
        }
    }

    public static class InvalidTokenException extends SharedException {
        public InvalidTokenException() {
            super("Token is invalid");
        }
    }

    public static class ExpiredTokenException extends SharedException {
        public ExpiredTokenException() {
            super("Token has expired");
        }
    }

    public static class UserNotFoundException extends SharedException {
        public UserNotFoundException() {
            super("User not found");
        }
    }

    public static class EmailAlreadyValidatedException extends SharedException {
        public EmailAlreadyValidatedException() {
            super("Email is already validated");
        }
    }

    public static class ValidationTokenStillValidException extends SharedException {
        public ValidationTokenStillValidException() {
            super("Validation token is still valid");
        }
    }
}
