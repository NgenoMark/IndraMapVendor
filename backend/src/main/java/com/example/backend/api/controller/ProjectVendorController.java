package com.example.backend.api.controller;

import com.example.backend.api.model.ProjectVendor;
import com.example.backend.api.service.ProjectVendorService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/vendors")
public class ProjectVendorController {

    private final ProjectVendorService service;

    public ProjectVendorController(ProjectVendorService service) {
        this.service = service;
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody ProjectVendor vendor) {
        if (service.existsByEmail(vendor.getEmail())) {
            return ResponseEntity.badRequest().body("Email already exists");
        }
        ProjectVendor savedVendor = service.registerProjectVendor(vendor);
        return ResponseEntity.ok(savedVendor);
    }
}
