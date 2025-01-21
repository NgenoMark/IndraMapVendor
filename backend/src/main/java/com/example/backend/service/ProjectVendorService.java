package com.example.backend.service;

import com.example.backend.api.model.ProjectVendor;
import com.example.backend.api.repository.ProjectVendorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class ProjectVendorService {



    private final ProjectVendorRepository repository;
    private final BCryptPasswordEncoder passwordEncoder;

    public ProjectVendorService(ProjectVendorRepository repository, BCryptPasswordEncoder passwordEncoder) {
        this.repository = repository;
        this.passwordEncoder = passwordEncoder;
    }

    public ProjectVendor registerProjectVendor(ProjectVendor vendor) {
        vendor.setPassword(passwordEncoder.encode(vendor.getPassword())); // Encrypt password
        return repository.save(vendor);
    }

    public boolean existsByEmail(String email) {
        return repository.findByEmail(email).isPresent();
    }
}
