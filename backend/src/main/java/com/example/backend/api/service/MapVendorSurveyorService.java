package com.example.backend.api.service;

import com.example.backend.api.dto.MapVendorSurveyorRequest;
import com.example.backend.api.dto.MapVendorSurveyorResponse;

import java.util.List;

public interface MapVendorSurveyorService {

    List<MapVendorSurveyorResponse> getAllSurveyors();

    MapVendorSurveyorResponse saveSurveyor(MapVendorSurveyorRequest surveyorRequest)
            throws Exception;

    List<MapVendorSurveyorResponse> findBySurveyorId ( String surveyorId);

    MapVendorSurveyorResponse updateSurveyor ( MapVendorSurveyorRequest surveyorRequest);
}
