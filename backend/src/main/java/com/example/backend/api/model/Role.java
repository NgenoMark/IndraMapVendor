package com.example.backend.api.model;

import org.springframework.data.annotation.Id;

import javax.persistence.*;

@Entity
@Table(name = "roles")
public class Role {
    @javax.persistence.Id
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String roleName;

    public void setId(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    // Getters and Setters
}

