package com.example.backend.api.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class LoginRequest {
    // Setters (optional, needed if you're using @RequestBody)
    // Getters
    private String username;
    private String password;

    // Default constructor (needed for JSON deserialization)
    public LoginRequest() {}

    public LoginRequest(String username, String password) {
        this.username = username;
        this.password = password;
    }

}
