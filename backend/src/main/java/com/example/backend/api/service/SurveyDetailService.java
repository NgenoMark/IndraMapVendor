package com.example.backend.api.service;

import com.example.backend.api.dto.SurveyDetailRequest;
import com.example.backend.api.dto.SurveyDetailResponse;

import java.util.List;

public interface SurveyDetailService {


    SurveyDetailResponse  saveSurveyDetail(SurveyDetailRequest surveyDetailRequest)
        throws  Exception;
    List<SurveyDetailResponse> getByApplicationNumber(String applicationNumber);
}
