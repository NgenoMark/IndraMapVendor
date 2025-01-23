package com.example.backend.api.service;

import com.example.backend.api.model.User;
import com.example.backend.api.repository.UserRepository;
import com.example.backend.api.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtUtil jwtUtil;  // JWT token generator

    /**
     * Authenticate a user based on their username and password.
     * @param username The username of the user trying to authenticate.
     * @param password The password provided by the user.
     * @return A JWT token if authentication is successful.
     * @throws Exception If the user is not found or the password is incorrect.
     */
    public String authenticateUser(String username, String password) throws Exception {
        // Retrieve user by username
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new Exception("User not found"));

        // Verify the password
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new Exception("Invalid password");
        }

        // Generate and return JWT token for the authenticated user
        return jwtUtil.generateToken(user.getUsername());
    }
}