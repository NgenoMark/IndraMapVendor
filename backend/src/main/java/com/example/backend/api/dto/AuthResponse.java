package com.example.backend.api.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class AuthResponse {
    // Setter method (optional)
    // Getter method
    private String token;

    // Default constructor (needed for JSON serialization/deserialization)
    public AuthResponse() {}

    // Constructor that takes a token
    public AuthResponse(String token) {
        this.token = token;
    }

}
