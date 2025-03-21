package com.example.backend.api.model.repositories;

import com.example.backend.api.model.MapMaterial;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface MapMaterialRepository extends JpaRepository<MapMaterial, Long> {

    Optional<List<MapMaterial>> findByMapNumber(String mapNumber);
}
