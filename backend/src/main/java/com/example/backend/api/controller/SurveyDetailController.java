package com.example.backend.api.controller;


import com.example.backend.api.dto.PaymentDetailResponse;
import com.example.backend.api.dto.SurveyDetailRequest;
import com.example.backend.api.dto.SurveyDetailResponse;
import com.example.backend.api.service.SurveyDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping( "/survey-detail")
public class SurveyDetailController {

    private final SurveyDetailService surveyDetailService;

    @Autowired
    public SurveyDetailController(SurveyDetailService surveyDetailService) {
        this.surveyDetailService = surveyDetailService;
    }

    @PostMapping("/saveSurveyDetail")
    public ResponseEntity<?> saveSurveyDetail(@RequestBody SurveyDetailRequest surveyDetailRequest) {
        try {
            SurveyDetailResponse response = surveyDetailService.saveSurveyDetail(surveyDetailRequest);
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body("Error saving survey details: " + e.getMessage());
        }
    }

    @GetMapping("/getByApplicationNo/{applicationNumber}")
    public List<SurveyDetailResponse> getSurveyDetailByApplicationNo(@PathVariable String applicationNumber){
        return surveyDetailService.getByApplicationNumber(applicationNumber);
    }


}
