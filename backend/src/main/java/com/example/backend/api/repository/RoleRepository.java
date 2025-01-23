package com.example.backend.api.repository;

import com.example.backend.api.model.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<Role, Integer> {
    // Optional: You can add custom queries if needed.
    Role findByRoleName(String roleName);
}
