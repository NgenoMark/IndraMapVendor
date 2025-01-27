package com.example.backend.api.service;

import com.example.backend.api.model.Role;
import com.example.backend.api.model.User;
import com.example.backend.api.repository.UserRepository;
import com.example.backend.api.repository.RoleRepository;
import com.example.backend.api.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AuthService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

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
        Optional<User> optionalUser = userRepository.findByUsername(username);

        // Log if user is not found
        if (!optionalUser.isPresent()) {
            System.out.println("Authentication failed: User not found with username: " + username); // Add log
            throw new Exception("User not found");
        }

        User user = optionalUser.get();

        // Log user retrieval
        System.out.println("User found: " + user.getUsername());

        // Verify the password
        if (!passwordEncoder.matches(password, user.getPassword())) {
            System.out.println("Authentication failed: Invalid password for user: " + username); // Add log
            throw new Exception("Invalid password");
        }

        // Log successful authentication
        System.out.println("User successfully authenticated: " + username);

        // Generate and return JWT token for the authenticated user
        return jwtUtil.generateToken(user.getUsername());
    }

    /**
     * Find a role by its name.
     * @param roleName The name of the role to search for.
     * @return The Role object if found, otherwise null.
     */
    public Role findByRoleName(String roleName) {
        // Retrieve the role by its name using the RoleRepository
        return roleRepository.findByRoleName(roleName);
    }
}
