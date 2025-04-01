package com.example.backend.api.service;

import com.example.backend.api.dto.SurveyDetailRequest;
import com.example.backend.api.dto.SurveyDetailResponse;
import com.example.backend.api.model.SurveyDetail;

import javax.transaction.Transactional;
import java.util.List;

public interface SurveyDetailService {


    SurveyDetailResponse saveSurveyDetail(SurveyDetailRequest surveyDetailRequest)
            throws Exception;


    @Transactional
    List<SurveyDetailResponse> getByApplicationNumber(String applicationNumber);

    SurveyDetailResponse findSurveyDetails(SurveyDetailRequest request);

    boolean updateSurveyStatus(Integer surveyId, String surveyStatus);
    List<SurveyDetailResponse> getSurveyById(Integer surveyId);

}
