package com.example.backend.api.service;

import com.example.backend.api.dto.MapSurveyRequest;
import com.example.backend.api.dto.MapSurveyResponse;

import java.util.List;

public interface MapSurveyService {

    MapSurveyResponse saveMapSurvey(MapSurveyRequest mapSurveyRequest)
            throws Exception;


    List<MapSurveyResponse> getAllSurveys();
}
