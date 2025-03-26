package com.example.backend.api.service;

import com.example.backend.api.dto.SurveyMaterialRequest;
import com.example.backend.api.dto.SurveyMaterialResponse;

import javax.transaction.Transactional;
import java.util.List;

public interface SurveyMaterialService {

    SurveyMaterialResponse saveSurveyMaterial(SurveyMaterialRequest surveyMaterialRequest)
        throws Exception;

    @Transactional
    List<SurveyMaterialResponse> getByApplicationNo(String applicationNumber);
}
