package com.example.backend.api.model.repositories;

import com.example.backend.api.model.MapSurveyDetail;
import com.example.backend.api.model.MapSurveyDetailId;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MapSurveyRepository extends JpaRepository<MapSurveyDetail , MapSurveyDetailId> {
}
