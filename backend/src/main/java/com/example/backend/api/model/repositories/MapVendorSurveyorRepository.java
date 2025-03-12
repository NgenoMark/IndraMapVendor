package com.example.backend.api.model.repositories;

import com.example.backend.api.model.MapVendorSurveyor;
import com.example.backend.api.model.MapVendorSurveyorId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MapVendorSurveyorRepository extends JpaRepository<MapVendorSurveyor, MapVendorSurveyorId> {
    List<MapVendorSurveyor> findAll();
}
