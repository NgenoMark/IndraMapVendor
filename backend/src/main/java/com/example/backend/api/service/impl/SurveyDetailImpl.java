package com.example.backend.api.service.impl;

import com.example.backend.api.dto.MapSurveyResponse;
import com.example.backend.api.dto.MapVendorSurveyorResponse;
import com.example.backend.api.dto.SurveyDetailRequest;
import com.example.backend.api.dto.SurveyDetailResponse;
import com.example.backend.api.model.ProjectData;
import com.example.backend.api.model.SurveyDetail;
import com.example.backend.api.model.SurveyDetailId;
import com.example.backend.api.model.repositories.SurveyDetailRepository;
import com.example.backend.api.service.SurveyDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class SurveyDetailImpl implements SurveyDetailService {

    private final SurveyDetailRepository surveyDetailRepository;

    @Autowired
    public SurveyDetailImpl(SurveyDetailRepository surveyDetailRepository) {
        this.surveyDetailRepository = surveyDetailRepository;
    }

    @Transactional
    @Override
    public     SurveyDetailResponse  saveSurveyDetail(SurveyDetailRequest surveyDetailRequest)
    {

        long seqSurveyId = surveyDetailRepository.getNextSeqValue("SEQ_SURVEY_ID");
        // Create composite ID object
        SurveyDetailId surveyDetailId = new SurveyDetailId();
        surveyDetailId.setApplicationNumber(surveyDetailRequest.getApplicationNumber());
        surveyDetailId.setVendorId(surveyDetailRequest.getVendorId());
        surveyDetailId.setMapNumber(surveyDetailRequest.getMapNumber());

        // Check if record exists
        boolean exists = surveyDetailRepository.existsById(surveyDetailId);
        if (exists) {
            // If it exists, return a response without saving
            return new SurveyDetailResponse(surveyDetailRepository.findById(surveyDetailId).orElse(null));

        }

        // If it doesn't exist, create and save new survey detail
        SurveyDetail surveyDetail = new SurveyDetail();
        surveyDetail.setId(surveyDetailId);
        surveyDetail.setSurveyId((int)seqSurveyId);
        surveyDetail.setMeterPhase(surveyDetailRequest.getMeterPhase());
        surveyDetail.setSurveyStatus(surveyDetailRequest.getSurveyStatus() != null ? surveyDetailRequest.getSurveyStatus() : "PENDING");

        surveyDetail.setPrograma(surveyDetailRequest.getPrograma() != null ? surveyDetailRequest.getPrograma() : "MAP_API");
        surveyDetail.setfActual(surveyDetailRequest.getfActual() != null ? surveyDetailRequest.getfActual() : new Date());
        surveyDetail.setUsuario(surveyDetailRequest.getVendorId() != null ? surveyDetailRequest.getVendorId() : "DEFAULT_USER");


        // Save the new survey detail to the database
        surveyDetail = surveyDetailRepository.save(surveyDetail);

        // Return response with saved data
        return new SurveyDetailResponse(surveyDetail);
    }

    @Override
    public List<SurveyDetailResponse> getByApplicationNumber(String applicationNumber) {
        return surveyDetailRepository.findById_ApplicationNumber(applicationNumber).
                stream()
                .map(SurveyDetailResponse::new)
                .collect(Collectors.toList());

    }


    @Override
    public SurveyDetailResponse findSurveyDetails(SurveyDetailRequest request) {
        // Fetch list, then get the first matching record
        SurveyDetail surveyDetail = surveyDetailRepository.findById_ApplicationNumber(request.getApplicationNumber())
                .stream()
                .findFirst()
                .orElse(null);

        if (surveyDetail != null) {
            return new SurveyDetailResponse(
                    surveyDetail.getId().getApplicationNumber(),
                    surveyDetail.getId().getMapNumber(),
                    surveyDetail.getId().getVendorId()
            );
        }

        return null; // Return null if not found
    }


}
