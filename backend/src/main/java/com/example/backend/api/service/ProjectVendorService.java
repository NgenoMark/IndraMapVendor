package com.example.backend.api.service;

import com.example.backend.api.model.ProjectVendor;
import com.example.backend.api.repository.ProjectVendorRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class ProjectVendorService {

    private final ProjectVendorRepository repository;
    private final PasswordEncoder passwordEncoder;

    public ProjectVendorService(ProjectVendorRepository repository, PasswordEncoder passwordEncoder) {
        this.repository = repository;
        this.passwordEncoder = passwordEncoder;
    }

    public ProjectVendor registerProjectVendor(ProjectVendor vendor) {
        vendor.setPassword(passwordEncoder.encode(vendor.getPassword())); // Encrypt password before saving
        return repository.save(vendor);
    }

    public boolean existsByEmail(String email) {
        return repository.findByEmail(email).isPresent();
    }
}
