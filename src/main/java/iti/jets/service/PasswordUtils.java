package iti.jets.service;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class PasswordUtils {

    private static final int ITERATIONS = 10000; // Higher is more secure
    private static final int KEY_LENGTH = 256; // Length of the resulting hash (bits)

    // Method to hash the password
    public static String hashPassword(String password) {
        // Generate a random salt for each password
        byte[] salt = null;
        try {
            salt = getSalt();


        // Hash the password using PBKDF2
        char[] passwordChars = password.toCharArray();
        PBEKeySpec spec = new PBEKeySpec(passwordChars, salt, ITERATIONS, KEY_LENGTH);
        SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
        byte[] hash = skf.generateSecret(spec).getEncoded();

        // Return the salt and hash in a format that can be stored
        return saltToHex(salt) + ":" + bytesToHex(hash);
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            e.printStackTrace();
            return null;
        }
    }

    // Method to check the entered password
    public static boolean checkPassword(String password, String storedPassword){
        // Split the stored password into salt and hash
        String[] parts = storedPassword.split(":");
        byte[] salt = hexToByteArray(parts[0]);
        byte[] storedHash = hexToByteArray(parts[1]);

        // Hash the entered password with the same salt and compare the results
        char[] passwordChars = password.toCharArray();
        PBEKeySpec spec = new PBEKeySpec(passwordChars, salt, ITERATIONS, storedHash.length * 8);
        SecretKeyFactory skf = null;
        try {
            skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
            byte[] hash = skf.generateSecret(spec).getEncoded();

        // Compare the stored hash with the generated hash
        return MessageDigest.isEqual(storedHash, hash);
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            e.printStackTrace();
            return false;
        }

    }

    // Generate a random salt
    private static byte[] getSalt() throws NoSuchAlgorithmException {
        SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
        byte[] salt = new byte[16];
        sr.nextBytes(salt);
        return salt;
    }

    // Convert bytes to hex string
    private static String bytesToHex(byte[] bytes) {
        StringBuilder hexString = new StringBuilder();
        for (int i = 0; i < bytes.length; i++) {
            String hex = Integer.toHexString(0xff & bytes[i]);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }

    // Convert hex string to bytes
    private static byte[] hexToByteArray(String hex) {
        int length = hex.length();
        byte[] bytes = new byte[length / 2];
        for (int i = 0; i < length; i += 2) {
            bytes[i / 2] = (byte) ((Character.digit(hex.charAt(i), 16) << 4)
                    + Character.digit(hex.charAt(i + 1), 16));
        }
        return bytes;
    }

    // Convert salt (byte array) to hex string for storage
    private static String saltToHex(byte[] salt) {
        return bytesToHex(salt);
    }

    public static void main(String[] args) throws Exception {
        String password = "mySecurePassword";

        // Hash the password
        String hashedPassword = hashPassword(password);
        ln("Hashed Password: " + hashedPassword);

        // Check the password
        boolean isPasswordCorrect = checkPassword(password, hashedPassword);
        ln("Password valid: " + isPasswordCorrect);
    }
}
