package com.example.backend.api.model.repositories;

import com.example.backend.api.model.MapSurveyDetail;
import com.example.backend.api.model.MapSurveyDetailId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MapSurveyRepository extends JpaRepository<MapSurveyDetail , MapSurveyDetailId> {

    List<MapSurveyDetail> findAll();

    List<MapSurveyDetail> findByIdMapNumber(String mapNumber);

}
