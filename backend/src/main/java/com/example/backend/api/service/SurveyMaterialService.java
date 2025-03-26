package com.example.backend.api.service;

import com.example.backend.api.dto.SurveyMaterialRequest;
import com.example.backend.api.dto.SurveyMaterialResponse;

import java.util.List;

public interface SurveyMaterialService {

    SurveyMaterialResponse saveSurveyMaterial(SurveyMaterialRequest surveyMaterialRequest)
        throws Exception;

    List<SurveyMaterialResponse> getByApplicationNo(String applicationNumber);
}
