package com.example.backend.api.repository;

import com.example.backend.api.model.ProjectVendor;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface ProjectVendorRepository extends JpaRepository<ProjectVendor, Long> {
    Optional<ProjectVendor> findByEmail(String email);
}
