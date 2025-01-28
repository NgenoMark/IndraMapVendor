package com.example.backend.api;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordHasher {
    public static void main(String[] args) {
        // Create an instance of BCryptPasswordEncoder
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        // The plain-text password you want to hash
        String plainPassword = "Password123";

        // Hash the password
        String hashedPassword = encoder.encode(plainPassword);

        // Print the hashed password
        System.out.println("Hashed Password: " + hashedPassword);
    }
}
